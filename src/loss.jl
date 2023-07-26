function photometric_loss(
    rgba::R; bundle::RayBundle, images::Images, rng_state::UInt64,
) where R <: AbstractMatrix{Float32}
    kab = get_backend(rgba)
    loss = allocate(kab, Float32, bundle.n_rays)
    ∇rgba = KernelAbstractions.zeros(kab, Float32, size(rgba))

    # TODO allow to configure
    background_color = SVector{3, Float32}(0f0, 0f0, 0f0)
    random_background = true

    total_rays::UInt32 = length(bundle.directions)

    photometric_loss!(kab)(
        reinterpret(SVector{4, Float32}, reshape(∇rgba, :)), loss,
        rgba, bundle.thread_indices, rng_state, bundle.image_indices,
        bundle.span, bundle.samples.deltas, images, total_rays,
        background_color, random_background;
        ndrange=bundle.n_rays)
    sum(loss), ∇rgba
end

function ChainRulesCore.rrule(
    ::typeof(photometric_loss), rgba::R;
    bundle::RayBundle, images::Images, rng_state::UInt64,
) where R <: AbstractMatrix{Float32}
    loss, ∇rgba = photometric_loss(rgba; bundle, images, rng_state)
    photometric_loss_pullback(_) = (NoTangent(), ∇rgba)
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
    ∇rgba::M, loss::D, @Const(rgba), @Const(thread_indices), rng_state::UInt64,
    @Const(image_indices), @Const(span), @Const(deltas),
    images::Images, n_rays::UInt32,
    background_color::SVector{3, Float32}, random_background::Bool,
) where {
    M <: AbstractVector{SVector{4, Float32}},
    D <: AbstractVector{Float32},
}
    @uniform scale::Float32 = 1f0 / n_rays

    i::UInt32 = @index(Global)
    @inbounds idx = thread_indices[i]

    rng_state = advance(rng_state, (idx - 0x1) * max_rng_samples_per_ray())
    xy, rng_state = random_vec2f0(rng_state)
    if random_background
        background_color, rng_state = random_vec3f0(rng_state)
    end

    @inbounds image_idx = image_indices[i]
    @inbounds ray_span = span[i]
    offset, steps = ray_span[1], ray_span[2]

    composed_rgb, composed_steps, composed_T =
        alpha_compose!(nothing, rgba, offset, steps, deltas)
    target_rgb, target_alpha = sample(images, xy, image_idx)
    target_rgb = target_rgb .+ (1f0 - target_alpha) .* background_color

    if composed_steps == steps
        composed_rgb .+= composed_T .* background_color
    end

    diff = composed_rgb .- target_rgb
    ∇loss = 2f0 .* diff
    @inbounds loss[i] = mean(abs2, diff) * scale

    @inline function consumer(
        rgb::SVector{3, Float32}, hcomposed_rgb::MVector{3, Float32},
        ω::Float32, δt::Float32, σ::Float32, T::Float32, write_idx::UInt32,
    )
        rgb_diff = composed_rgb .- hcomposed_rgb
        ∇rgb = (scale * ω) .* ∇loss
        ∇σ = (scale * σ * δt) * (∇loss ⋅ (T .* rgb .- rgb_diff))
        @inbounds ∇rgba[write_idx] = SVector{4, Float32}(∇rgb[1], ∇rgb[2], ∇rgb[3], ∇σ)
    end
    alpha_compose!(consumer, rgba, offset, composed_steps, deltas)
end

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

        @inbounds rgb, log_σ = to_rgb_a(@view(rgba[:, read_idx]))
        σ = exp(log_σ)
        @inbounds δ = deltas[read_idx]

        α = 1f0 - exp(-σ * δ)
        ω = α * T
        T *= 1f0 - α

        composed_rgb .+= ω .* rgb
        isnothing(consumer) || consumer(rgb, composed_rgb, ω, δ, σ, T, read_idx)
    end
    composed_rgb, step, T
end

@inline function to_rgb_a(x)
    @inbounds SVector{3, Float32}(x[1], x[2], x[3]), x[4]
end
