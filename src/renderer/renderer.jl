@enum RenderMode begin
    AO
    Depth
    Encoding
    Normals
    Color
    Stepsize
end

include("camera.jl")
include("camera_keyframe.jl")
include("buffer.jl")
include("utils.jl")

mutable struct Renderer{D <: RenderRayBundle, B <: RenderBuffer}
    bundle::D
    min_sample_steps::Int
    max_sample_steps::Int

    buffer::B
    camera::Camera
    bbox::BBox
    cone::Cone

    tile_idx::Int
    tile_size::Int
    n_tiles::Int

    mode::RenderMode
end

KernelAbstractions.get_backend(r::Renderer) = get_backend(r.buffer)

function Renderer(
    backend, camera::Camera, bbox::BBox, cone::Cone;
    tile_size::Int = 256 * 256,
    min_sample_steps::Int = 1, max_sample_steps::Int = 8,
)
    width, height = get_resolution(camera)

    bundle = RenderRayBundle(backend; n_rays=tile_size, max_sample_steps)
    buffer = RenderBuffer(backend; width, height)

    n_tiles = cld(width * height, tile_size)
    Renderer(
        bundle, min_sample_steps, max_sample_steps,
        buffer, camera, bbox, cone,
        0, tile_size, n_tiles, Color)
end

function resize!(r::Renderer; width::Int, height::Int)
    r.tile_idx = 0
    r.n_tiles = cld(width * height, r.tile_size)
    set_resolution!(r.camera; width, height)

    r.buffer = RenderBuffer(get_backend(r); width, height) # TODO free buffer
    return nothing
end

function reset!(r::Renderer)
    reset!(r.buffer)
    r.tile_idx = 0
    return nothing
end

function set_dataset!(r::Renderer, dataset::Dataset, cone::Cone, bbox::BBox)
    # TODO use current resolution, but adopt dataset intrinsics
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
    reset!(r)
    for i in 1:spp
        r.tile_idx = 0
        clear!(r.buffer)
        for tile_id in 1:r.n_tiles
            reset!(r.bundle)
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
        # TODO adjust
        rays = init_rays_from_vertices_and_normals!(
            r, occupancy, vertices, normals)
    else
        init_rays!(r, occupancy; near)
    end

    n_hit = trace(
        consumer, r, occupancy, train_bbox;
        max_steps, min_transmittance, normals_consumer)
    n_hit == 0 && return

    (; offset, tile_size) = current_tile(r)
    shade!(get_backend(r.buffer))(
        r.buffer.buffer, r.bundle.hit_ids, r.bundle.hit_rgba,
        offset, r.mode; ndrange=n_hit)
    accumulate!(r.buffer; offset, tile_size)
    return
end

function init_rays!(r::Renderer, occupancy::OccupancyGrid; near::Float32)
    kab = get_backend(r)
    rotation, translation = split_pose(r.camera)
    (; offset, tile_size) = current_tile(r)

    (; alive_rays) = alive(r.bundle)
    _init_rays!(kab)(
        alive_rays, offset, r.bbox, rotation, translation, r.camera.intrinsics,
        near, r.buffer.spp; ndrange=tile_size)

    n_levels::UInt32 = get_n_levels(occupancy)
    resolution::UInt32 = get_resolution(occupancy)
    init_advance!(kab)(
        alive_rays, r.cone, r.bbox, occupancy.binary, n_levels, resolution,
        r.buffer.spp; ndrange=tile_size)
    return nothing
end

function trace(
    consumer, r::Renderer, occupancy::OccupancyGrid, train_bbox::BBox;
    max_steps::Int, min_transmittance::Float32,
    normals_consumer::Union{Nothing, Function} = nothing,
)
    kab = get_backend(r)
    camera_origin, camera_forward = view_pos(r.camera), view_dir(r.camera)
    (; tile_size) = current_tile(r)
    n_alive = n_rays = tile_size

    for step in 1:max_steps
        n_alive = compact!(r.bundle; n_alive, min_transmittance)
        n_alive == 0 && break

        max_samples = clamp(n_rays ÷ n_alive,
            r.min_sample_steps, r.max_sample_steps)
        materialize!(
            r.bundle, occupancy, r.cone;
            train_bbox, render_bbox=r.bbox, max_samples)

        n_samples = r.bundle.n_samples
        n_samples == 0 && continue

        raw_points, raw_directions = raw_samples(r.bundle; n_samples)
        evaluated_rgba = reinterpret(SVector{4, Float32},
            reshape(consumer(raw_points, raw_directions), :))

        ∇n = (r.mode == Normals) ?
            reinterpret(SVector{3, Float32},
                reshape(normals_consumer(raw_points), :)) :
            nothing

        (; alive_rays, alive_rgba) = alive(r.bundle)
        compose!(kab)(
            alive_rgba, r.bundle.span, evaluated_rgba, ∇n,
            alive_rays, r.bundle.samples, r.mode,
            camera_origin, camera_forward,
            r.bbox, min_transmittance, UInt32(max_samples); ndrange=n_alive)
    end
    n_hit = Int(Array(r.bundle.hit_counter)[1])
    n_hit
end

@kernel function _init_rays!(
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
    @inbounds rays[i] = RenderRay(ray, t_start, i, UInt32(0), is_alive)
end

@kernel function init_advance!(
    rays::R, cone::Cone, bbox::BBox,
    @Const(binary), n_levels::UInt32, resolution::UInt32, spp::UInt32,
) where R <: AbstractVector{RenderRay}
    i::UInt32 = @index(Global)
    @inbounds rray = rays[i]
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
        @inbounds rays[i] = RenderRay(rray; t, alive)
    end
end

@kernel function shade!(
    buffer::B, @Const(hit_ids), @Const(hit_rgba), offset::UInt32, mode::RenderMode,
) where {
    B <: AbstractMatrix{SVector{4, Float32}},
    # I <: AbstractVector{UInt32},
    # C <: AbstractVector{SVector{4, Float32}},
}
    i::UInt32 = @index(Global)
    @inbounds idx = hit_ids[i] + offset
    @inbounds rgba = hit_rgba[i]
    if mode == Normals
        rgb, a = to_rgb_a(rgba)
        n = (rgb .* 0.5f0 .+ 0.5f0) .* a
        rgba = SVector{4, Float32}(n[1], n[2], n[3], a)
    end
    @inbounds buffer[idx] = rgba .+ buffer[idx] .* (1f0 - rgba[4])
end

@kernel function compose!(
    rgba::C, @Const(span), @Const(evaluated_rgba), ∇n::N,
    rays::R, samples::RaySamples, mode::RenderMode,
    camera_origin::SVector{3, Float32}, camera_forward::SVector{3, Float32},
    bbox::BBox, min_transmittance::Float32, max_samples::UInt32,
) where {
    C <: AbstractVector{SVector{4, Float32}},
    # TODO docs
    # S <: AbstractVector{SVector{3, UInt32}},
    # G <: AbstractVector{SVector{4, Float32}},
    N <: Union{Nothing, AbstractVector{SVector{3, Float32}}},
    R <: AbstractVector{RenderRay},
}
    i::UInt32 = @index(Global)
    @inbounds ray_span = span[i]
    offset, steps, idx = ray_span[1], ray_span[2], ray_span[3]
    @inbounds rray = rays[idx]

    @inbounds local_rgba = MVector{4, Float32}(rgba[idx])
    step = UInt32(0)
    while step < steps
        read_idx = offset + step + 0x1
        rgb, log_σ = to_rgb_a(evaluated_rgba[read_idx])
        @inbounds point = samples.points[read_idx]
        @inbounds δ = samples.deltas[read_idx]

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
            @inbounds rgb = ∇n[read_idx]
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
        @inbounds rays[idx] = RenderRay(rray; alive=false)
    end
    @inbounds rgba[idx] = local_rgba
end
