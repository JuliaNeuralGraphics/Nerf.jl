struct RayBundle{
    R <: AbstractVector{SVector{3, Float32}},
    I <: AbstractVector{UInt32},
    S <: AbstractVector{SVector{3, UInt32}},
}
    directions::R
    image_indices::I
    indices::I
    span::S
    n_samples::UInt32
end

function Adapt.adapt_structure(to, bundle::RayBundle)
    RayBundle(
        adapt(to, bundle.directions), adapt(to, bundle.image_indices),
        adapt(to, bundle.indices), adapt(to, bundle.span), bundle.n_samples)
end

function RayBundle(dev; n_rays::Int)
    directions = similar(dev, SVector{3, Float32}, (n_rays,))
    image_indices = similar(dev, UInt32, (n_rays,))
    indices = similar(dev, UInt32, (n_rays,))
    span = similar(dev, SVector{3, UInt32}, (n_rays,))
    RayBundle(directions, image_indices, indices, span, zero(UInt32))
end

function RayBundle(
    occupancy::OccupancyGrid, cone::Cone, bbox::BBox,
    rotations::R, translations::T, intrinsics::CameraIntrinsics; n_rays::Int,
) where {
    R <: AbstractVector{SMatrix{3, 3, Float32, 9}},
    T <: AbstractVector{SVector{3, Float32}},
}
    dev = get_device(occupancy)
    bundle = RayBundle(dev; n_rays)

    steps_counter = zeros(dev, UInt32, (1,))
    rays_counter = zeros(dev, UInt32, (1,))
    # 3 random number per ray: 2 - ray pixel, 1 - ray time offset.
    Ξ = reinterpret(SVector{3, Float32}, rand(dev, Float32, (3 * n_rays,)))

    resolution::UInt32 = get_resolution(occupancy)
    n_levels::UInt32 = get_n_levels(occupancy)
    wait(generate_ray_bundle!(dev)(
        bundle, steps_counter, rays_counter,
        Ξ, cone, bbox, rotations, translations, intrinsics,
        occupancy.binary, resolution, n_levels; ndrange=n_rays))

    n_samples::UInt32 = Array(steps_counter)[1]
    rc::Int = Array(rays_counter)[1]
    @assert rc > 0

    rc == n_rays && return RayBundle(
        bundle.directions, bundle.image_indices, bundle.indices,
        bundle.span, n_samples)
    return RayBundle(
        bundle.directions[1:rc], bundle.image_indices[1:rc],
        bundle.indices[1:rc], bundle.span[1:rc], n_samples)
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

function materialize(
    bundle::RayBundle, occupancy::OccupancyGrid,
    cone::Cone, bbox::BBox, translations::T,
) where T <: AbstractVector{SVector{3, Float32}}
    dev = get_device(occupancy)
    samples = RaySamples(dev; n_samples=Int(bundle.n_samples))
    resolution::UInt32 = get_resolution(occupancy)
    n_levels::UInt32 = get_n_levels(occupancy)
    # TODO check that number of generated samples is the same as defined in bundle
    wait(materialize_ray_bundle!(dev)(
        samples, bundle, cone, bbox, translations,
        occupancy.binary, n_levels, resolution;
        ndrange=length(bundle.directions)))
    samples
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

    image_idx = bundle.image_indices[i]
    span = bundle.span[i]
    offset, steps, t_start = span[1], span[2], reinterpret(Float32, span[3])

    direction = bundle.directions[i]
    ray = Ray(translations[image_idx], direction)
    trace_ray!(ray, t_start, cone, bbox, binary, n_levels, resolution) do point, δ, step
        write_idx = offset + step + 0x1
        samples.points[write_idx] = relative_position(bbox, point)
        samples.directions[write_idx] = direction
        samples.deltas[write_idx] = δ
    end
end

@kernel function generate_ray_bundle!(
    bundle::RayBundle, steps_counter::C, rays_counter::C,
    Ξ::I, cone::Cone, bbox::BBox,
    rotations::R, translations::T, intrinsics::CameraIntrinsics,
    binary::B, n_levels::UInt32, resolution::UInt32,
) where {
    C <: AbstractVector{UInt32},
    I <: AbstractVector{SVector{3, Float32}},
    R <: AbstractVector{SMatrix{3, 3, Float32, 9}},
    T <: AbstractVector{SVector{3, Float32}},
    B <: AbstractVector{UInt8},
}
    @uniform n_rays::UInt32 = @ndrange()[1]
    @uniform n_images::UInt32 = length(rotations)

    i::UInt32 = @index(Global)
    image_idx = image_index(i, n_rays, n_images)
    ξ = Ξ[i]
    ray = Ray(
        SVector{2, Float32}(ξ[1], ξ[2]), rotations[image_idx],
        translations[image_idx], intrinsics)

    t_start::Float32 = max(0f0, (bbox ∩ ray)[1])
    t_start += delta(cone, t_start) * ξ[3]

    steps = trace_ray!(nothing, ray, t_start, cone, bbox, binary, n_levels, resolution)
    if steps > 0
        offset, _ = @atomic steps_counter[0x1] + steps
        ray_idx, _ = @atomic rays_counter[0x1] + 0x1
        ray_idx += 0x1

        bundle.directions[ray_idx] = ray.direction
        bundle.image_indices[ray_idx] = image_idx
        bundle.indices[ray_idx] = i
        bundle.span[ray_idx] = SVector{3, UInt32}(
            offset, steps, reinterpret(UInt32, t_start))
    end
end

@inline function trace_ray!(
    consumer, ray::Ray, t_start::Float32, cone::Cone, bbox::BBox,
    binary::B, n_levels::UInt32, resolution::UInt32,
) where B <: AbstractVector{UInt8}
    t::Float32 = t_start
    step::UInt32 = zero(UInt32)
    while step < cone.steps
        point = ray(t)
        point ∈ bbox || break

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
    step
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
    t = floor.(p .+ 0.5f0 .+ 0.5f0 .* sign.(direction) .- p) ./ direction
    max(0f0, minimum(t) / level_resolution)
end

@inline function image_index(i::UInt32, n_rays::UInt32, n_images::UInt32)
    ((i - 0x1) * n_images ÷ n_rays) % n_images + 0x1
end
