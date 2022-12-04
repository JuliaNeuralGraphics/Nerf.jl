function photometric_loss(
    rgba::R; bundle::RayBundle, samples::RaySamples, images::Images,
    n_rays::Int,
) where R <: AbstractMatrix{Float32}
    rgb = rgba[1:3, :]
    @assert 0f0 ≤ minimum(rgb) ≤ 1f0
    @assert 0f0 ≤ maximum(rgb) ≤ 1f0

    dev = device_from_type(R)
    loss = similar(dev, Float32, (length(bundle),))
    ∇rgba = zeros(dev, Float32, size(rgba))
    CUDA.synchronize()
    wait(photometric_loss!(dev)(
        reinterpret(SVector{4, Float32}, reshape(∇rgba, :)), loss,
        rgba, bundle.Ξ, bundle.image_indices, bundle.span, samples.deltas,
        images, UInt32(n_rays); ndrange=length(bundle)))
    CUDA.synchronize()
    sum(loss), ∇rgba
end

function ChainRulesCore.rrule(
    ::typeof(photometric_loss), rgba::R; bundle::RayBundle,
    samples::RaySamples, images::Images, n_rays::Int,
) where R <: AbstractMatrix{Float32}
    loss, ∇rgba = photometric_loss(rgba; bundle, samples, images, n_rays)
    photometric_loss_pullback(_) = NoTangent(), ∇rgba
    loss, photometric_loss_pullback
end

@kernel function photometric_loss!(
    ∇rgba::M, loss::D, rgba::R, Ξ::K, image_indices::I,
    span::S, deltas::D, images::Images, n_rays::UInt32,
) where {
    M <: AbstractVector{SVector{4, Float32}},
    R <: AbstractMatrix{Float32},
    K <: AbstractVector{SVector{3, Float32}},
    I <: AbstractVector{UInt32},
    S <: AbstractVector{SVector{3, UInt32}},
    D <: AbstractVector{Float32},
}
    @uniform scale::Float32 = 1f0 / n_rays

    i::UInt32 = @index(Global)
    ξ = Ξ[i]
    image_idx = image_indices[i]
    ray_span = span[i]
    offset, steps = ray_span[1], ray_span[2]

    composed_rgb, composed_steps = alpha_compose!(nothing, rgba, offset, steps, deltas)
    target_rgb = sample(images, SVector{2, Float32}(ξ[1], ξ[2]), image_idx)

    diff = composed_rgb .- target_rgb
    ∇loss = 2f0 .* diff
    loss[i] = mean(abs2, diff) * scale

    @inline function consumer(
        rgb::SVector{3, Float32}, hcomposed_rgb::MVector{3, Float32},
        ω::Float32, δt::Float32, σ::Float32, T::Float32, write_idx::UInt32,
    )
        δrgb = composed_rgb .- hcomposed_rgb
        ∇rgb = ω .* ∇loss .* ∇sigmoid(rgb) .* scale
        ∇σ = σ * δt * (∇loss ⋅ (T .* rgb .- δrgb)) * scale
        ∇rgba[write_idx] = SVector{4, Float32}(∇rgb[1], ∇rgb[2], ∇rgb[3], ∇σ)
    end
    alpha_compose!(consumer, rgba, offset, composed_steps, deltas)
end

@inline ∇sigmoid(v::SVector{3, Float32}) = v .* (1f0 .- v)

@inline function alpha_compose!(
    consumer, rgba::R, offset::UInt32, steps::UInt32, deltas::D,
) where {
    R <: AbstractMatrix{Float32}, D <: AbstractVector{Float32},
}
    composed_rgb = zeros(MVector{3, Float32})
    T, ϵ = 1f0, 1f-4
    step = zero(UInt32)
    while step < steps
        T < ϵ && break
        step += 0x1
        read_idx = offset + step

        rgb, log_σ = to_rgb_a(@view(rgba[:, read_idx]))
        σ = exp(log_σ)
        δ = deltas[read_idx]

        α = 1f0 - exp(-σ * δ)
        ω = α * T
        T *= 1f0 - α

        composed_rgb .+= ω .* rgb
        isnothing(consumer) || consumer(rgb, composed_rgb, ω, δ, σ, T, read_idx)
    end
    composed_rgb, step
end

@inline to_rgb_a(x) = SVector{3, Float32}(x[1], x[2], x[3]), x[4]
