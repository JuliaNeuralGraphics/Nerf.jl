include("camera.jl")
include("buffer.jl")
include("utils.jl")

mutable struct Renderer
    buffer::RenderBuffer
    camera::Camera
    bbox::BBox
    cone::Cone
end

get_device(r::Renderer) = get_device(r.buffer)

function Renderer(dev, camera::Camera, bbox::BBox, cone::Cone)
    width, height = get_resolution(camera)
    buffer = RenderBuffer(dev; width, height)
    Renderer(buffer, camera, bbox, cone)
end

function render!(
    r::Renderer, occupancy::OccupancyGrid;
    steps::Int = 1024, near::Float32 = 0.1f0,
    min_transmittance::Float32 = 1f-3,
)
    rays = init_rays(r, occupancy; near)
    trace(r, rays, occupancy; steps, min_transmittance)
    """
    - init rays
    - trace
    - shade
    - accumulate
    """
end

function init_rays(r::Renderer, occupancy::OccupancyGrid; near::Float32)
    dev = get_device(r)
    width, height = get_resolution(r.camera)
    rotation, translation = split_pose(r.camera)

    rays = similar(dev, RenderRay, (width * height,))
    wait(init_rays!(dev)(
        rays, r.bbox, rotation, translation, r.camera.intrinsics, near;
        ndrange=(width, height)))

    n_levels::UInt32 = get_n_levels(occupancy)
    resolution::UInt32 = get_resolution(occupancy)
    wait(init_advance!(dev)(
        rays, translation, r.cone, r.bbox,
        occupancy.binary, n_levels, resolution; ndrange=length(rays)))
    rays
end

function trace(
    r::Renderer, rays::R, occupancy::OccupancyGrid;
    steps::Int, min_transmittance::Float32,
) where R <: AbstractVector{RenderRay}
    dev = get_device(r)
    hit_ids = similar(dev, UInt32, (length(rays),))
    hit_rgba = similar(dev, SVector{4, Float32}, (length(rays),))
    rgba = similar(dev, SVector{4, Float32}, (length(rays),))
    fill!(reinterpret(Float32, hit_rgba), 0f0)
    fill!(reinterpret(Float32, rgba), 0f0)

    hit_counter = zeros(dev, UInt32, (1,))
    max_samples = 8

    for step in 1:steps
        rays, rgba = compact(
            hit_ids, hit_rgba, rays, rgba; hit_counter, min_transmittance)
        @show length(rays)
        length(rays) == 0 && break

        materialize(r, rays, occupancy; max_samples)
        break
    end
end

function compact(
    hit_ids::H, hit_rgba::C, rays::R, rgba::C;
    hit_counter::K, min_transmittance::Float32,
) where {
    H <: AbstractVector{UInt32},
    R <: AbstractVector{RenderRay},
    C <: AbstractVector{SVector{4, Float32}},
    K <: AbstractVector{UInt32},
}
    dev = device_from_type(R)
    alive_counter = zeros(dev, UInt32, (1,))
    alive_rays = similar(dev, RenderRay, (length(rays),))
    alive_rgba = similar(dev, SVector{4, Float32}, (length(rays),))
    wait(_compact!(dev)(
        alive_rays, alive_rgba, hit_ids, hit_rgba, rays, rgba,
        min_transmittance, alive_counter, hit_counter; ndrange=length(rays)))

    n_alive = Array{Int}(alive_counter)[1]
    @show length(rays)
    @show n_alive
    n_alive == length(rays) && return alive_rays, alive_rgba
    return alive_rays[1:n_alive], alive_rgba[1:n_alive]
end

function materialize(
    r::Renderer, rays::R, occupancy::OccupancyGrid; max_samples::Int,
) where R <: AbstractVector{RenderRay}
    dev = device_from_type(R)
    span = similar(dev, SVector{3, UInt32}, (length(rays),))
    steps_counter = zeros(dev, UInt32, (1,))
    rays_counter = zeros(dev, UInt32, (1,))

    _, origin = split_pose(r.camera)

    n_levels::UInt32 = get_n_levels(occupancy)
    resolution::UInt32 = get_resolution(occupancy)
    wait(count_render_samples!(dev)(
        span, steps_counter, rays_counter,
        rays, origin, r.bbox, UInt32(max_samples), r.cone,
        occupancy.binary, n_levels, resolution; ndrange=length(rays)))

    n_samples = Array{Int}(steps_counter)[1]
    @show n_samples
    @assert n_samples > 0

    points = similar(dev, Float32, (3, n_samples))
    directions = similar(dev, Float32, (3, n_samples))
    wait(generate_render_samples!(dev)(
        reinterpret(SVector{3, Float32}, reshape(points, :)),
        reinterpret(SVector{3, Float32}, reshape(directions, :)),
        span, rays, origin, r.bbox, UInt32(max_samples), r.cone,
        occupancy.binary, n_levels, resolution; ndrange=length(rays)))
    # TODO check points directions
end

@kernel function count_render_samples!(
    span::S, steps_counter::K, rays_counter::K,
    rays::R, origin::SVector{3, Float32}, bbox::BBox,
    max_samples::UInt32, cone::Cone,
    binary::B, n_levels::UInt32, resolution::UInt32,
) where {
    S <: AbstractVector{SVector{3, UInt32}},
    K <: AbstractVector{UInt32},
    R <: AbstractVector{RenderRay},
    B <: AbstractVector{UInt8},
}
    i::UInt32 = @index(Global)
    rray = rays[i]

    ray = Ray(origin, rray.direction)
    _, _, steps = trace_ray!(
        nothing, ray, rray.t, max_samples, cone, bbox,
        binary, n_levels, resolution)
    if steps > 0
        offset, _ = @atomic steps_counter[0x1] + steps
        _, ray_idx = @atomic rays_counter[0x1] + 0x1
        span[ray_idx] = SVector{3, UInt32}(offset, steps, i)
    end
end

@kernel function generate_render_samples!(
    points::S, directions::D,
    span::P, rays::R, origin::SVector{3, Float32}, bbox::BBox,
    max_samples::UInt32, cone::Cone,
    binary::B, n_levels::UInt32, resolution::UInt32,
) where {
    S <: AbstractVector{SVector{3, Float32}},
    D <: AbstractVector{SVector{3, Float32}},
    P <: AbstractVector{SVector{3, UInt32}},
    R <: AbstractVector{RenderRay},
    B <: AbstractVector{UInt8},
}
    i = @index(Global)
    ray_span = span[i]
    offset, steps, idx = ray_span[1], ray_span[2], ray_span[3]

    rray = rays[idx]
    ray = Ray(origin, rray.direction)

    @inline function consumer(point::SVector{3, Float32}, δ::Float32, step::UInt32)
        write_idx = offset + step + 0x1
        points[write_idx] = point
        directions[write_idx] = rray.direction
    end
    alive, t, steps = trace_ray!(
        consumer, ray, rray.t, max_samples, cone, bbox,
        binary, n_levels, resolution)
    rays[idx] = RenderRay(rray; alive, t, steps=rray.steps + steps)
end

@kernel function _compact!(
    alive_rays::R, alive_rgba::C, hit_ids::H, hit_rgba::C, rays::R, rgba::C,
    min_transmittance::Float32, alive_counter::K, hit_counter::K,
) where {
    R <: AbstractVector{RenderRay},
    C <: AbstractVector{SVector{4, Float32}},
    H <: AbstractVector{UInt32},
    K <: AbstractVector{UInt32},
}
    i::UInt32 = @index(Global)
    ray, c = rays[i], rgba[i]
    if ray.alive
        _, idx = @atomic alive_counter[0x1] + 0x1
        alive_rays[idx] = ray
        alive_rgba[idx] = c
    elseif c[4] > min_transmittance
        _, idx = @atomic hit_counter[0x1] + 0x1
        hit_ids[idx] = ray.idx
        hit_rgba[idx] = c
    end
end

@kernel function init_rays!(
    rays::R, bbox::BBox,
    rotation::SMatrix{3, 3, Float32, 9}, translation::SVector{3, Float32},
    intrinsics::CameraIntrinsics, near::Float32,
) where R <: AbstractVector{RenderRay}
    x::UInt32, y::UInt32 = @index(Global, NTuple)
    xy = SVector{2, Float32}(x - 0x1, y - 0x1) ./ intrinsics.resolution
    idx = x + (y - 0x1) * intrinsics.resolution[1]

    ray = Ray(xy, rotation, translation, intrinsics)
    t_start = max(0f0, (bbox ∩ ray)[1]) + near

    is_alive = !isinf(t_start) && (ray(t_start) ∈ bbox)
    rays[idx] = RenderRay(ray.direction, t_start, idx, UInt32(0), is_alive)
end

@kernel function init_advance!(
    rays::R, origin::SVector{3, Float32}, cone::Cone, bbox::BBox,
    binary::B, n_levels::UInt32, resolution::UInt32,
) where {R <: AbstractVector{RenderRay}, B <: AbstractVector{UInt8}}
    i::UInt32 = @index(Global)
    rray = rays[i]
    if rray.alive
        ray = Ray(origin, rray.direction)
        t = rray.t + delta(cone, rray.t)
        alive = true

        while true
            point = ray(t)
            point ∈ bbox || (alive = false; break)

            δ = delta(cone, t)
            level = level_from_delta(δ, point, n_levels, resolution)
            is_occupied(binary, point, resolution, level) && break

            t = to_next_voxel(t, cone, point, ray.direction, resolution >> level)
        end
        rays[i] = RenderRay(rray; t, alive)
    end
end
