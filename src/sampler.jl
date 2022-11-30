struct RayBundle{
    R <: AbstractVector{SVector{3, Float32}},
    I <: AbstractVector{UInt32},
    S <: AbstractVector{SVector{3, UInt32}},
}
    directions::R
    thread_indices::I
    image_indices::I
    span::S
    n_samples::UInt32
end

function Adapt.adapt_structure(to, bundle::RayBundle)
    RayBundle(
        adapt(to, bundle.directions), adapt(to, bundle.thread_indices),
        adapt(to, bundle.image_indices), adapt(to, bundle.span),
        bundle.n_samples)
end

function RayBundle(dev; n_rays::Int)
    directions = similar(dev, SVector{3, Float32}, (n_rays,))
    thread_indices = similar(dev, UInt32, (n_rays,))
    image_indices = similar(dev, UInt32, (n_rays,))
    span = similar(dev, SVector{3, UInt32}, (n_rays,))
    RayBundle(directions, thread_indices, image_indices, span, zero(UInt32))
end

function RayBundle(
    occupancy::OccupancyGrid, cone::Cone, bbox::BBox,
    rotations::R, translations::T, intrinsics::CameraIntrinsics;
    n_rays::Int, rng_state::UInt64,
) where {
    R <: AbstractVector{SMatrix{3, 3, Float32, 9}},
    T <: AbstractVector{SVector{3, Float32}},
}
    dev = get_device(occupancy)
    bundle = RayBundle(dev; n_rays)

    steps_counter = zeros(dev, UInt32, (1,))
    rays_counter = zeros(dev, UInt32, (1,))

    resolution::UInt32 = get_resolution(occupancy)
    n_levels::UInt32 = get_n_levels(occupancy)
    wait(generate_ray_bundle!(dev)(
        bundle, steps_counter, rays_counter, rng_state,
        cone, bbox, rotations, translations, intrinsics,
        occupancy.binary, n_levels, resolution; ndrange=n_rays))

    n_samples::UInt32 = Array(steps_counter)[1]
    rc::Int = Array(rays_counter)[1]
    @assert rc > 0

    if rc != n_rays
        trimmed_bundle = RayBundle(
            bundle.directions[1:rc], bundle.thread_indices[1:rc],
            bundle.image_indices[1:rc], bundle.span[1:rc], n_samples)
        unsafe_free!(bundle)
    else
        trimmed_bundle = RayBundle(
            bundle.directions, bundle.thread_indices, bundle.image_indices,
            bundle.span, n_samples)
    end
    trimmed_bundle
end

Base.length(b::RayBundle) = length(b.directions)

function KAUtils.unsafe_free!(b::RayBundle)
    unsafe_free!(b.span)
    unsafe_free!(b.directions)
    unsafe_free!(b.image_indices)
    unsafe_free!(b.thread_indices)
end

struct RaySamples{
    P <: AbstractVector{SVector{3, Float32}},
    D <: AbstractVector{SVector{3, Float32}},
    B <: AbstractVector{Float32},
}
    points::P
    directions::D
    deltas::B
end

function Adapt.adapt_structure(to, samples::RaySamples)
    RaySamples(
        adapt(to, samples.points), adapt(to, samples.directions),
        adapt(to, samples.deltas))
end

function RaySamples(dev; n_samples::Int)
    RaySamples(
        similar(dev, SVector{3, Float32}, (n_samples,)),
        similar(dev, SVector{3, Float32}, (n_samples,)),
        similar(dev, Float32, (n_samples,)))
end

Base.length(s::RaySamples) = length(s.points)

function KAUtils.unsafe_free!(s::RaySamples)
    unsafe_free!(s.points)
    unsafe_free!(s.directions)
    unsafe_free!(s.deltas)
end

function materialize(
    bundle::RayBundle, occupancy::OccupancyGrid,
    cone::Cone, bbox::BBox, translations::T,
) where T <: AbstractVector{SVector{3, Float32}}
    dev = get_device(occupancy)
    samples = RaySamples(dev; n_samples=Int(bundle.n_samples))

    resolution::UInt32 = get_resolution(occupancy)
    n_levels::UInt32 = get_n_levels(occupancy)
    wait(materialize_ray_bundle!(dev)(
        samples, bundle, cone, bbox, translations,
        occupancy.binary, n_levels, resolution; ndrange=length(bundle)))
    samples
end

@kernel function generate_ray_bundle!(
    bundle::RayBundle, steps_counter::C, rays_counter::C,
    rng_state::UInt64, cone::Cone, bbox::BBox,
    rotations::R, translations::T, intrinsics::CameraIntrinsics,
    binary::B, n_levels::UInt32, resolution::UInt32,
) where {
    C <: AbstractVector{UInt32},
    R <: AbstractVector{SMatrix{3, 3, Float32, 9}},
    T <: AbstractVector{SVector{3, Float32}},
    B <: AbstractVector{UInt8},
}
    @uniform n_rays::UInt32 = @ndrange()[1]
    @uniform n_images::UInt32 = length(rotations)

    i::UInt32 = @index(Global)
    image_idx = image_index(i, n_rays, n_images)

    # 3 random numbers per ray: 2 for pixel, 1 for time offset.
    rng_state = advance(rng_state, (i - 0x1) * 0x3)
    xy, rng_state = random_vec2f0(rng_state)
    ξ, rng_state = next_float(rng_state)

    ray = Ray(xy, rotations[image_idx], translations[image_idx], intrinsics)
    t_start::Float32 = max(0f0, (bbox ∩ ray)[1])
    t_start += delta(cone, t_start) * ξ

    _, _, steps = trace_ray!(
        nothing, ray, t_start, cone.steps,
        cone, bbox, binary, n_levels, resolution)
    if steps > 0
        offset, _ = @atomic steps_counter[0x1] + steps
        _, ray_idx = @atomic rays_counter[0x1] + 0x1

        bundle.thread_indices[ray_idx] = i
        bundle.image_indices[ray_idx] = image_idx
        bundle.directions[ray_idx] = ray.direction
        bundle.span[ray_idx] = SVector{3, UInt32}(
            offset, steps, reinterpret(UInt32, t_start))
    end
end

@kernel function materialize_ray_bundle!(
    samples::RaySamples, bundle::RayBundle,
    cone::Cone, bbox::BBox, translations::T,
    binary::B, n_levels::UInt32, resolution::UInt32,
) where {
    T <: AbstractVector{SVector{3, Float32}},
    B <: AbstractVector{UInt8},
}
    i::UInt32 = @index(Global)

    direction = bundle.directions[i]
    image_idx = bundle.image_indices[i]
    span = bundle.span[i]

    offset, steps, t_start = span[1], span[2], reinterpret(Float32, span[3])
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
