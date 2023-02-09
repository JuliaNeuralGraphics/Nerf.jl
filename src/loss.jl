function photometric_loss(
    rgba::R; bundle::RayBundle, samples::RaySamples, images::Images,
    n_rays::Int, rng_state::UInt64,
) where R <: AbstractMatrix{Float32}
    dev = device_from_type(R)
    loss = similar(dev, Float32, (length(bundle),))
    ∇rgba = zeros(dev, Float32, size(rgba))
    wait(photometric_loss!(dev)(
        reinterpret(SVector{4, Float32}, reshape(∇rgba, :)), loss,
        rgba, bundle.thread_indices, rng_state, bundle.image_indices,
        bundle.span, samples.deltas, images, UInt32(n_rays);
        ndrange=length(bundle)))
    # TODO accumulate loss in the kernel?
    sum(loss), ∇rgba
end

function ChainRulesCore.rrule(
    ::typeof(photometric_loss), rgba::R; bundle::RayBundle,
    samples::RaySamples, images::Images, n_rays::Int, rng_state::UInt64,
) where R <: AbstractMatrix{Float32}
    loss, ∇rgba = photometric_loss(
        rgba; bundle, samples, images, n_rays, rng_state)
    function photometric_loss_pullback(_)
        NoTangent(), ∇rgba
    end
    loss, photometric_loss_pullback
end

"""
# Arguments:

- `rgba: <: AbstractMatrix{Float32}`: Output of the model.
    Must be of `(4, N)` shape, where each 4 components are RGBA (A for density).

Refer to [`RayBundle`](@ref) for documentation on `thread_indices`,
`image_indices` and `span` arguments.

Refer to [`RaySamples`](@ref) for documentation on `deltas` argument.
"""
@kernel function photometric_loss!(
    ∇rgba::M, loss::D, @Const(rgba),
    @Const(thread_indices), rng_state::UInt64, @Const(image_indices),
    @Const(span), @Const(deltas), images::Images, n_rays::UInt32,
) where {
    M <: AbstractVector{SVector{4, Float32}},
    D <: AbstractVector{Float32},
}
    @uniform scale::Float32 = 1f0 / n_rays

    i::UInt32 = @index(Global)
    @inbounds idx = thread_indices[i]

    # Same as in sampler:
    # 3 random numbers per ray: 2 for pixel, 1 for time offset.
    rng_state = advance(rng_state, (idx - 0x1) * 0x3)
    xy, rng_state = random_vec2f0(rng_state)

    @inbounds image_idx = image_indices[i]
    @inbounds ray_span = span[i]
    offset, steps = ray_span[1], ray_span[2]

    composed_rgb, composed_steps = alpha_compose!(nothing, rgba, offset, steps, deltas)
    target_rgb = sample(images, xy, image_idx)

    diff = composed_rgb .- target_rgb
    ∇loss = 2f0 .* diff
    @inbounds loss[i] = mean(abs2, diff) * scale

    @inline function consumer(
        rgb::SVector{3, Float32}, hcomposed_rgb::MVector{3, Float32},
        ω::Float32, δt::Float32, σ::Float32, T::Float32, write_idx::UInt32,
    )
        rgb_diff = composed_rgb .- hcomposed_rgb
        ∇rgb = ω .* ∇loss .* ∇sigmoid(rgb) .* scale
        ∇σ = σ * δt * (∇loss ⋅ (T .* rgb .- rgb_diff)) * scale
        @inbounds ∇rgba[write_idx] = SVector{4, Float32}(∇rgb[1], ∇rgb[2], ∇rgb[3], ∇σ)
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

@inline function to_rgb_a(x)
    @inbounds SVector{3, Float32}(x[1], x[2], x[3]), x[4]
end
