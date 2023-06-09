function photometric_loss(
    rgba::R, envmap::E = nothing;
    bundle::RayBundle, images::Images, rng_state::UInt64,
) where {
    R <: AbstractMatrix{Float32},
    E <: Union{Envmap, Nothing},
}
    kab = get_backend(rgba)
    loss = allocate(kab, Float32, bundle.n_rays)
    ∇rgba = KernelAbstractions.zeros(kab, Float32, size(rgba))
    ∇envmap = isnothing(envmap) ? nothing :
        KernelAbstractions.zeros(kab, Float32, size(envmap.data))

    # TODO allow to configure
    background_color = SVector{3, Float32}(0f0, 0f0, 0f0)
    random_background = true

    total_rays::UInt32 = length(bundle.directions)

    envmap_args = if isnothing(envmap)
        (nothing, nothing, nothing)
    else
        ed = reinterpret(SVector{3, Float32}, envmap.data)
        (bundle.directions, ed, envmap.resolution)
    end

    photometric_loss!(kab)(
        # Output args.
        reinterpret(SVector{4, Float32}, reshape(∇rgba, :)),
        ∇envmap,
        loss,
        # Input args.
        rgba, bundle.thread_indices, rng_state, bundle.image_indices,
        bundle.span, bundle.samples.deltas, images, total_rays,
        background_color, random_background,
        envmap_args...;
        ndrange=bundle.n_rays)
    sum(loss), ∇rgba, ∇envmap
end

function ChainRulesCore.rrule(::typeof(photometric_loss), rgba, envmap; loss_kwargs...)
    loss, ∇rgba, ∇envmap = photometric_loss(rgba, envmap; loss_kwargs...)
    photometric_loss_pullback(_) = (NoTangent(), ∇rgba, ∇envmap)
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
    # Output args.
    ∇rgba::M, ∇envmap, loss::D,
    # Input args.
    @Const(rgba), @Const(thread_indices), rng_state::UInt64,
    @Const(image_indices), @Const(span), @Const(deltas),
    images::Images, n_rays::UInt32,
    background_color::SVector{3, Float32}, random_background::Bool,
    # Args for envmap.
    @Const(directions), envmap, envmap_resolution::SVector{2, Int32},
) where {
    M <: AbstractVector{SVector{4, Float32}},
    D <: AbstractVector{Float32},
}
    @uniform scale::Float32 = 1f0 / n_rays

    i::UInt32 = @index(Global)
    @inbounds idx = thread_indices[i]
    direction = directions[i]

    # Same as in sampler:
    # 3 random numbers per ray: 2 for pixel, 1 for time offset.
    rng_state = advance(rng_state, (idx - 0x1) * max_rng_samples_per_ray())
    xy, rng_state = random_vec2f0(rng_state)
    if !isnothing(envmap)
        background_color = read_envmap(envmap, envmap_resolution, direction)
    elseif random_background
        background_color, rng_state = random_vec3f0(rng_state)
    end

    @inbounds image_idx = image_indices[i]
    @inbounds ray_span = span[i]
    offset, steps = ray_span[1], ray_span[2]

    composed_rgb, composed_steps, composed_T =
        alpha_compose!(nothing, rgba, offset, steps, deltas)
    target_rgb, target_alpha = sample(images, xy, image_idx)

    # TODO skip when images are RGB and not RGBA
    target_rgb = target_rgb .+ (1f0 - target_alpha) .* background_color

    if composed_steps == steps
        composed_rgb .+= composed_T .* background_color
    end

    # Compute loss gradient.

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

    # Compute envmap gradient.

    if composed_steps == steps
        Δ::SVector{3, Float32} = (scale * composed_T) .* ∇loss
        deposit_envmap_grad!(∇envmap, Δ, envmap_resolution, direction)
    end
end

@inline function alpha_compose!(
    consumer, rgba::R, offset::UInt32, steps::UInt32, deltas::D,
)::Tuple{MVector{3, Float32}, UInt32, Float32} where {
    R <: AbstractMatrix{Float32}, D <: AbstractVector{Float32},
}
    composed_rgb::MVector{3, Float32} = zeros(MVector{3, Float32})
    T::Float32, ϵ::Float32 = 1f0, 1f-4
    step::UInt32 = zero(UInt32)
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
    composed_rgb, step, T
end

@inline function to_rgb_a(x)
    @inbounds SVector{3, Float32}(x[1], x[2], x[3]), x[4]
end
