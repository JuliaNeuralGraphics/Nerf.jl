include("camera.jl")
include("camera_keyframe.jl")
include("buffer.jl")
include("utils.jl")

@enum RenderMode begin
    AO
    Depth
    Encoding
    Normals
    Color
    Stepsize
end

mutable struct Renderer
    buffer::RenderBuffer
    camera::Camera
    bbox::BBox
    cone::Cone

    tile_idx::Int
    tile_size::Int
    n_tiles::Int

    mode::RenderMode
end

get_device(r::Renderer) = get_device(r.buffer)

function Renderer(
    dev, camera::Camera, bbox::BBox, cone::Cone; tile_size::Int = 256 * 256,
)
    width, height = get_resolution(camera)
    buffer = RenderBuffer(dev; width, height)
    n_tiles = ceil(Int, (width * height) / tile_size)
    Renderer(buffer, camera, bbox, cone, 0, tile_size, n_tiles, Color)
end

function resize!(r::Renderer; width::Int, height::Int)
    dev = get_device(r)
    set_resolution!(r.camera; width, height)
    r.buffer = RenderBuffer(dev; width, height)
    r.n_tiles = ceil(Int, (width * height) / r.tile_size)
    r.tile_idx = 0
    return nothing
end

function reset!(r::Renderer)
    reset!(r.buffer)
    r.tile_idx = 0
    return nothing
end

function set_dataset!(r::Renderer, dataset::Dataset, cone::Cone, bbox::BBox)
    set_intrinsics!(r.camera, dataset.intrinsics)
    r.bbox = bbox
    r.cone = cone
    reset!(r)
    return nothing
end

function advance_tile!(r::Renderer)
    r.tile_idx == r.n_tiles && error(
        "Renderer is already at the last tile: $(r.tile_idx) / $(r.n_tiles).")
    r.tile_idx += 1
    return nothing
end

is_done(r::Renderer) = r.tile_idx == r.n_tiles

function current_tile(r::Renderer)
    offset::UInt32 = r.tile_idx * r.tile_size
    width, height = get_resolution(r.camera)
    n_pixels = width * height
    tile_size = min(r.tile_size, min(n_pixels, n_pixels - offset))
    (; offset, tile_size)
end

function render!(
    consumer, r::Renderer, occupancy::OccupancyGrid, train_bbox::BBox;
    max_steps::Int = 10_000, near::Float32 = 1f-2,
    min_transmittance::Float32 = 1f-3, spp::Int = 1,
    vertices::Union{Nothing, V} = nothing, normals::Union{Nothing, N} = nothing,
    normals_consumer::Union{Nothing, Function} = nothing,
) where {
    V <: AbstractVector{SVector{3, Float32}},
    N <: AbstractVector{SVector{3, Float32}},
}
    GC.gc(false)
    reset!(r)
    for i in 1:spp
        r.tile_idx = 0
        clear!(r.buffer)
        for tile_id in 1:r.n_tiles
            render_tile!(
                consumer, r, occupancy, train_bbox;
                vertices, normals,
                max_steps, near, min_transmittance, normals_consumer)
            advance_tile!(r)
        end
        r.buffer.spp += 1
    end
end

function render_tile!(
    consumer, r::Renderer, occupancy::OccupancyGrid, train_bbox::BBox;
    max_steps::Int = 10_000, near::Float32 = 1f-2,
    min_transmittance::Float32 = 1f-3,
    vertices::Union{Nothing, V} = nothing, normals::Union{Nothing, N} = nothing,
    normals_consumer::Union{Nothing, Function} = nothing,
) where {
    V <: AbstractVector{SVector{3, Float32}},
    N <: AbstractVector{SVector{3, Float32}},
}
    if !(isnothing(vertices) && isnothing(normals))
        @assert r.mode == Color
        rays = init_rays_from_vertices_and_normals!(
            r, occupancy, vertices, normals)
    else
        rays = init_rays(r, occupancy; near)
    end

    hit_ids, hit_rgba = trace(
        consumer, r, rays, occupancy, train_bbox;
        max_steps, min_transmittance, normals_consumer)

    if !isempty(hit_ids)
        (; offset, tile_size) = current_tile(r)
        wait(shade!(get_device(r.buffer))(
            r.buffer.buffer, hit_ids, hit_rgba, offset, r.mode;
            ndrange=length(hit_ids)))
        accumulate!(r.buffer; offset, tile_size)
        unsafe_free!(hit_ids)
        unsafe_free!(hit_rgba)
    end
    unsafe_free!(rays)
    return nothing
end

@kernel function init_rays!(
    rays::R, offset::UInt32, bbox::BBox,
    rotation::SMatrix{3, 3, Float32, 9}, translation::SVector{3, Float32},
    intrinsics::CameraIntrinsics, near::Float32, spp::UInt32,
) where R <: AbstractVector{RenderRay}
    i::UInt32 = @index(Global)
    idx = i - 0x1 + offset
    x::UInt32 = idx % intrinsics.resolution[1]
    y::UInt32 = idx ÷ intrinsics.resolution[1]
    ξ = ld_random_pixel_offset(spp)
    xy = (SVector{2, Float32}(x, y) .+ ξ) ./ intrinsics.resolution

    ray = Ray(xy, rotation, translation, intrinsics)
    t_start = max(near, (bbox ∩ ray)[1]) + 1f-6

    is_alive = !isinf(t_start) && (ray(t_start) ∈ bbox)
    rays[i] = RenderRay(ray, t_start, i, UInt32(0), is_alive)
end

@kernel function init_advance!(
    rays::R, cone::Cone, bbox::BBox,
    binary::B, n_levels::UInt32, resolution::UInt32, spp::UInt32,
) where {R <: AbstractVector{RenderRay}, B <: AbstractVector{UInt8}}
    i::UInt32 = @index(Global)
    rray = rays[i]
    if rray.alive
        ray = rray.ray
        ξ = ld_random_val(spp, (i - 0x1) * 0x000c0001)
        t = rray.t + ξ * delta(cone, rray.t)
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

@kernel function shade!(
    buffer::B, hit_ids::I, hit_rgba::C, offset::UInt32, mode::RenderMode,
) where {
    B <: AbstractMatrix{SVector{4, Float32}},
    I <: AbstractVector{UInt32},
    C <: AbstractVector{SVector{4, Float32}},
}
    i::UInt32 = @index(Global)
    idx = hit_ids[i] + offset
    rgba = hit_rgba[i]
    if mode == Normals
        rgb, a = to_rgb_a(rgba)
        n = (rgb .* 0.5f0 .+ 0.5f0) .* a
        rgba = SVector{4, Float32}(n[1], n[2], n[3], a)
    end
    buffer[idx] = rgba .+ buffer[idx] .* (1f0 - rgba[4])
end

function init_rays(r::Renderer, occupancy::OccupancyGrid; near::Float32)
    dev = get_device(r)
    rotation, translation = split_pose(r.camera)
    (; offset, tile_size) = current_tile(r)

    rays = similar(dev, RenderRay, (tile_size,))
    wait(init_rays!(dev)(
        rays, offset, r.bbox, rotation, translation, r.camera.intrinsics,
        near, r.buffer.spp; ndrange=tile_size))

    n_levels::UInt32 = get_n_levels(occupancy)
    resolution::UInt32 = get_resolution(occupancy)
    wait(init_advance!(dev)(
        rays, r.cone, r.bbox, occupancy.binary, n_levels, resolution,
        r.buffer.spp; ndrange=tile_size))
    rays
end

function trace(
    consumer::Function, r::Renderer, rays::R,
    occupancy::OccupancyGrid, train_bbox::BBox;
    max_steps::Int, min_transmittance::Float32,
    normals_consumer::Union{Nothing, Function} = nothing,
) where R <: AbstractVector{RenderRay}
    dev = get_device(r)
    hit_ids = similar(dev, UInt32, (length(rays),))
    hit_rgba = similar(dev, SVector{4, Float32}, (length(rays),))
    rgba = similar(dev, SVector{4, Float32}, (length(rays),))
    fill!(reinterpret(Float32, hit_rgba), 0f0)
    fill!(reinterpret(Float32, rgba), 0f0)

    camera_origin, camera_forward = view_pos(r.camera), view_dir(r.camera)

    hit_counter = zeros(dev, UInt32, (1,))
    # Maximum number of ray samples before recompaction:
    # alive rays are adjacent.
    max_samples = 8

    for step in 1:max_steps
        GC.gc(false)

        rays, rgba = compact(
            hit_ids, hit_rgba, rays, rgba;
            hit_counter, min_transmittance)
        length(rays) == 0 && break

        samples, span = materialize(r, rays, occupancy, train_bbox; max_samples)
        length(samples) == 0 && continue

        raw_points = reshape(reinterpret(Float32, samples.points), 3, :)
        evaluated_rgba = consumer(raw_points,
            reshape(reinterpret(Float32, samples.directions), 3, :))

        if r.mode == Normals
            # TODO we can evaluate only density without color, with normals
            ∇n = normals_consumer(raw_points)
        else
            ∇n = nothing
        end

        evaluated_rgba_ = reinterpret(SVector{4, Float32}, reshape(evaluated_rgba, :))
        ∇n_ = isnothing(∇n) ? nothing : reinterpret(SVector{3, Float32}, reshape(∇n, :))
        wait(compose!(dev)(
            rgba, span, evaluated_rgba_, ∇n_,
            rays, samples, r.mode,
            camera_origin, camera_forward,
            r.bbox, min_transmittance, UInt32(max_samples);
            ndrange=length(rays)))

        unsafe_free!(samples)
        unsafe_free!(span)
    end

    n_hit = Array{Int}(hit_counter)[1]
    n_hit == length(hit_ids) && return hit_ids, hit_rgba

    trimmed_hit_ids = hit_ids[1:n_hit]
    trimmed_hit_rgba = hit_rgba[1:n_hit]
    return trimmed_hit_ids, trimmed_hit_rgba
end

@kernel function compose!(
    rgba::C, span::S, evaluated_rgba::G, ∇n::N,
    rays::R, samples::RaySamples, mode::RenderMode,
    camera_origin::SVector{3, Float32}, camera_forward::SVector{3, Float32},
    bbox::BBox, min_transmittance::Float32, max_samples::UInt32,
) where {
    C <: AbstractVector{SVector{4, Float32}},
    S <: AbstractVector{SVector{3, UInt32}},
    G <: AbstractVector{SVector{4, Float32}},
    N <: Union{Nothing, AbstractVector{SVector{3, Float32}}},
    R <: AbstractVector{RenderRay},
}
    i::UInt32 = @index(Global)
    ray_span = span[i]
    offset, steps, idx = ray_span[1], ray_span[2], ray_span[3]
    rray = rays[idx]

    local_rgba = MVector{4, Float32}(rgba[idx])
    step = UInt32(0)
    while step < steps
        read_idx = offset + step + 0x1
        rgb, log_σ = to_rgb_a(evaluated_rgba[read_idx])
        point = samples.points[read_idx]
        δ = samples.deltas[read_idx]

        σ = exp(log_σ)
        T = 1f0 - local_rgba[4]
        α = 1f0 - exp(-σ * δ)
        ω = α * T

        if mode == AO
            rgb = SVector{3, Float32}(α, α, α)
        elseif mode == Depth
            world_point = inv_relative_position(bbox, point)
            depth = camera_forward ⋅ (world_point - camera_origin)
            depth /= 2f0 * π # Normalize to [0, 1] range.
            rgb = SVector{3, Float32}(depth, depth, depth)
        elseif mode == Encoding
            rgb = SVector{3, Float32}(point[1], point[2], point[3])
        elseif mode == Normals && ∇n ≢ nothing
            rgb = ∇n[read_idx]
        elseif mode == Stepsize
            rgb = SVector{3, Float32}(δ, δ, δ)
        end

        rgb = rgb .* ω
        local_rgba[1] += rgb[1]
        local_rgba[2] += rgb[2]
        local_rgba[3] += rgb[3]
        local_rgba[4] += ω

        # If visible enough - normalize color
        # and potentially mark ray as not alive later on.
        if local_rgba[4] > (1f0 - min_transmittance)
            local_rgba ./= local_rgba[4]
            break
        end
        step += 0x1
    end
    if step < max_samples
        rays[idx] = RenderRay(rray; alive=false)
    end
    rgba[idx] = local_rgba
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

    n_rays = length(rays)
    n_alive = Array{Int}(alive_counter)[1]
    n_alive == n_rays && return alive_rays, alive_rgba

    trimmed_rays = alive_rays[1:n_alive]
    trimmed_rgba = alive_rgba[1:n_alive]
    return trimmed_rays, trimmed_rgba
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

"""
    materialize(
        r::Renderer, rays::R, occupancy::OccupancyGrid,
        train_bbox::BBox; max_samples::Int,
    ) where R <: AbstractVector{RenderRay}

Generate samples along `rays`.

# Returns:

Tuple of two elements.

**Samples:**


**Span:**

Vector of `SVector{3, UInt32}` elements, where each element contains:
- `offset` - offset from the beginning of the samples vector.
- `steps` - number of steps sampled along the ray.
- `idx` - index of the ray in `rays` vector that was used to generate samples.
"""
function materialize(
    r::Renderer, rays::R, occupancy::OccupancyGrid,
    train_bbox::BBox; max_samples::Int,
) where R <: AbstractVector{RenderRay}
    dev = device_from_type(R)
    span = similar(dev, SVector{3, UInt32}, (length(rays),))
    steps_counter = zeros(dev, UInt32, (1,))
    rays_counter = zeros(dev, UInt32, (1,))

    n_levels::UInt32 = get_n_levels(occupancy)
    resolution::UInt32 = get_resolution(occupancy)
    wait(count_render_samples!(dev)(
        span, steps_counter, rays_counter,
        rays, r.bbox, r.cone, UInt32(max_samples),
        occupancy.binary, n_levels, resolution; ndrange=length(rays)))

    n_samples = Array{Int}(steps_counter)[1]
    samples = RaySamples(dev; n_samples)
    wait(generate_render_samples!(dev)(
        samples, span, rays, r.bbox, train_bbox, r.cone,
        occupancy.binary, n_levels, resolution; ndrange=length(rays)))
    samples, span
end

@kernel function count_render_samples!(
    span::S, steps_counter::K, rays_counter::K, rays::R,
    bbox::BBox, cone::Cone, max_samples::UInt32,
    binary::B, n_levels::UInt32, resolution::UInt32,
) where {
    S <: AbstractVector{SVector{3, UInt32}},
    K <: AbstractVector{UInt32},
    R <: AbstractVector{RenderRay},
    B <: AbstractVector{UInt8},
}
    i::UInt32 = @index(Global)
    rray = rays[i]
    ray = rray.ray

    _, _, steps = trace_ray!(
        nothing, ray, rray.t, max_samples, cone, bbox,
        binary, n_levels, resolution)

    offset, _ = @atomic steps_counter[0x1] + steps
    _, ray_idx = @atomic rays_counter[0x1] + 0x1
    span[ray_idx] = SVector{3, UInt32}(offset, steps, i)
end

@kernel function generate_render_samples!(
    samples::RaySamples, span::P, rays::R,
    bbox::BBox, train_bbox::BBox, cone::Cone,
    binary::B, n_levels::UInt32, resolution::UInt32,
) where {
    P <: AbstractVector{SVector{3, UInt32}},
    R <: AbstractVector{RenderRay},
    B <: AbstractVector{UInt8},
}
    i = @index(Global)
    ray_span = span[i]
    offset, steps, idx = ray_span[1], ray_span[2], ray_span[3]

    rray = rays[idx]
    ray = rray.ray

    @inline function consumer(point::SVector{3, Float32}, δ::Float32, step::UInt32)
        write_idx = offset + step + 0x1
        samples.points[write_idx] = relative_position(train_bbox, point)
        samples.directions[write_idx] = ray.direction
        samples.deltas[write_idx] = δ
    end
    # If steps == 0, trace the ray anyway, to get new `t` or `alive` status.
    steps = ifelse(steps == 0, UInt32(1), steps)
    alive, t, new_steps = trace_ray!(
        consumer, ray, rray.t, steps, cone, bbox,
        binary, n_levels, resolution)
    rays[idx] = RenderRay(rray; alive, t, steps=rray.steps + new_steps)
end
