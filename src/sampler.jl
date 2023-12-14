struct RaySamples{
    P <: AbstractVector{SVector{3, Float32}},
    D <: AbstractVector{SVector{3, Float32}},
    B <: AbstractVector{Float32},
}
    points::P
    directions::D
    deltas::B
    length::UInt32
end

function Base.sizeof(rs::RaySamples)
    sizeof(rs.points) + sizeof(rs.directions) + sizeof(rs.deltas)
end

function Adapt.adapt_structure(to, samples::RaySamples)
    RaySamples(
        adapt(to, samples.points), adapt(to, samples.directions),
        adapt(to, samples.deltas), samples.length)
end

function RaySamples(backend; n_samples::Int)
    points = allocate(backend, SVector{3, Float32}, n_samples)
    directions = allocate(backend, SVector{3, Float32}, n_samples)
    δ = allocate(backend, Float32, n_samples)
    RaySamples(points, directions, δ, UInt32(n_samples))
end

Base.length(s::RaySamples) = Int(s.length)

function KernelAbstractions.unsafe_free!(s::RaySamples)
    unsafe_free!(s.points)
    unsafe_free!(s.directions)
    unsafe_free!(s.deltas)
end

"""
TODO
"""
Base.@kwdef mutable struct RayBundle{
    R <: AbstractVector{SVector{3, Float32}},
    I <: AbstractVector{UInt32},
    S <: RaySamples,
    P <: AbstractVector{SVector{3, UInt32}},
}
    directions::R
    n_rays::Int = 0

    thread_indices::I
    image_indices::I

    samples::S
    span::P
    n_samples::Int = 0
end

function Adapt.adapt_structure(to, bundle::RayBundle)
    RayBundle(
        adapt(to, bundle.directions), bundle.n_rays,
        adapt(to, bundle.thread_indices), adapt(to, bundle.image_indices),
        adapt(to, bundle.samples), adapt(to, bundle.span), bundle.n_samples)
end

function Base.sizeof(bundle::RayBundle)
    sizeof(bundle.samples) + sizeof(bundle.directions) +
        sizeof(bundle.thread_indices) + sizeof(bundle.image_indices) +
        sizeof(bundle.span)
end

function RayBundle(backend; n_rays::Int, n_steps::Int)
    directions = allocate(backend, SVector{3, Float32}, n_rays)
    thread_indices = allocate(backend, UInt32, n_rays)
    image_indices = allocate(backend, UInt32, n_rays)
    span = allocate(backend, SVector{3, UInt32}, n_rays)

    samples = RaySamples(backend; n_samples=n_rays * n_steps)
    RayBundle(; directions, thread_indices, image_indices, samples, span)
end

function raw_samples(bundle::RayBundle)
    n_samples = bundle.n_samples
    raw_points = reshape(
        reinterpret(Float32, @view(bundle.samples.points[1:n_samples])),
        3, :)
    raw_directions = reshape(
        reinterpret(Float32, @view(bundle.samples.directions[1:n_samples])),
        3, :)
    return raw_points, raw_directions
end

function materialize!(
    bundle::RayBundle, occupancy::OccupancyGrid, cone::Cone, bbox::BBox;
    intrinsics::CameraIntrinsics, rotations::R, translations::T,
    rng_state::UInt64,
) where {
    R <: AbstractVector{SMatrix{3, 3, Float32, 9}},
    T <: AbstractVector{SVector{3, Float32}},
}
    kab = get_backend(occupancy)
    steps_counter = adapt(kab, zeros(UInt32, 1))
    rays_counter = adapt(kab, zeros(UInt32, 1))

    resolution::UInt32 = get_resolution(occupancy)
    n_levels::UInt32 = get_n_levels(occupancy)
    generate_ray_bundle!(kab)(
        bundle.thread_indices, bundle.image_indices,
        bundle.directions, bundle.span,
        steps_counter, rays_counter, rng_state,
        cone, bbox, rotations, translations, intrinsics,
        occupancy.binary, n_levels, resolution; ndrange=length(bundle.directions))

    bundle.n_samples = Array(steps_counter)[1]
    bundle.n_rays = Array(rays_counter)[1]
    @assert bundle.n_rays > 0
    @assert bundle.n_samples > 0

    materialize_ray_bundle!(kab)(
        bundle.samples, bundle.directions, bundle.image_indices, bundle.span,
        cone, bbox, translations, occupancy.binary, n_levels, resolution;
        ndrange=Int(bundle.n_rays))
    return
end

function KernelAbstractions.unsafe_free!(b::RayBundle)
    unsafe_free!(b.samples)
    unsafe_free!(b.span)
    unsafe_free!(b.directions)
    unsafe_free!(b.image_indices)
    unsafe_free!(b.thread_indices)
end

@kernel function generate_ray_bundle!(
    # Output args.
    thread_indices, image_indices, directions, span,
    steps_counter::C, rays_counter::C,
    # Read-only args.
    rng_state::UInt64, cone::Cone, bbox::BBox,
    @Const(rotations), @Const(translations), intrinsics::CameraIntrinsics,
    @Const(binary), n_levels::UInt32, resolution::UInt32,
) where C <: AbstractVector{UInt32}
    @uniform n_rays::UInt32 = @ndrange()[1]
    @uniform n_images::UInt32 = length(rotations)

    i::UInt32 = @index(Global)
    image_idx = image_index(i, n_rays, n_images)

    # 3 random numbers per ray: 2 for pixel, 1 for time offset.
    rng_state = advance(rng_state, (i - 0x1) * max_rng_samples_per_ray())
    xy, rng_state = random_vec2f0(rng_state)
    ξ, rng_state = next_float(rng_state)

    @inbounds ray = Ray(xy, rotations[image_idx], translations[image_idx], intrinsics)
    t_start::Float32 = max(0f0, (bbox ∩ ray)[1])
    t_start += delta(cone, t_start) * ξ

    _, _, steps = trace_ray!(
        nothing, ray, t_start, cone.steps,
        cone, bbox, binary, n_levels, resolution)
    @inbounds if steps > 0
        offset, _ = @atomic steps_counter[0x1] + steps
        _, ray_idx = @atomic rays_counter[0x1] + 0x1

        thread_indices[ray_idx] = i
        image_indices[ray_idx] = image_idx
        directions[ray_idx] = ray.direction
        span[ray_idx] = SVector{3, UInt32}(
            offset, steps, reinterpret(UInt32, t_start))
    end
end

"""
# Arguments:

- `bundle::RayBundle`: Ray bundle.
- `translations:: <: AbstractVector{SVector{3, Float32}}`:
    Vector of translations from the dataset.
"""
@kernel function materialize_ray_bundle!(
    samples::RaySamples,
    @Const(directions), @Const(image_indices), @Const(span), # TODO types?
    cone::Cone, bbox::BBox, @Const(translations),
    @Const(binary), n_levels::UInt32, resolution::UInt32,
)
    i = @index(Global)
    @inbounds direction = directions[i]
    @inbounds image_idx = image_indices[i]
    @inbounds sp = span[i]

    offset, steps, t_start = sp[1], sp[2], reinterpret(Float32, sp[3])
    if steps > 0x0
        ray = Ray(translations[image_idx], direction)

        @inline function consumer(point::SVector{3, Float32}, δ::Float32, step::UInt32)
            write_idx = offset + step + 0x1
            samples.points[write_idx] = relative_position(bbox, point)
            samples.directions[write_idx] = direction
            samples.deltas[write_idx] = δ
        end
        trace_ray!(
            consumer, ray, t_start, steps, cone, bbox,
            binary, n_levels, resolution)
    end
end

@inline function trace_ray!(
    consumer, ray::Ray, t_start::Float32, steps::UInt32, cone::Cone,
    bbox::BBox, binary::B, n_levels::UInt32, resolution::UInt32,
) where B <: AbstractVector{UInt8}
    alive::Bool = true
    t::Float32 = t_start
    step::UInt32 = zero(UInt32)
    while step < steps
        point = ray(t)
        point ∈ bbox || (alive = false; break)

        δ = delta(cone, t)
        level = level_from_delta(δ, point, n_levels, resolution)
        if is_occupied(binary, point, resolution, level)
            isnothing(consumer) || consumer(point, δ, step)
            step += 0x1
            t += δ
        else
            t = to_next_voxel(t, cone, point, ray.direction, resolution >> level)
        end
    end
    alive, t, step
end

@inline function to_next_voxel(
    t::Float32, cone::Cone, point::SVector{3, Float32},
    direction::SVector{3, Float32}, level_resolution::UInt32,
)
    t_target = t + distance_to_voxel(point, direction, level_resolution)
    t += delta(cone, t)
    while t < t_target
        t += delta(cone, t)
    end
    t
end

@inline function distance_to_voxel(
    point::SVector{3, Float32}, direction::SVector{3, Float32},
    level_resolution::UInt32,
)::Float32
    p = point .* level_resolution
    t = (floor.(0.5f0 .+ p .+ 0.5f0 .* sign.(direction)) .- p) ./ direction
    max(0f0, minimum(t) / level_resolution)
end

@inline function image_index(i::UInt32, n_rays::UInt32, n_images::UInt32)
    ((i - 0x1) * n_images ÷ n_rays) % n_images + 0x1
end
