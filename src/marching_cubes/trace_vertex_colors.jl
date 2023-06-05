function trace_vertex_colors(
    consumer, renderer::Renderer, occupancy::OccupancyGrid,
    train_bbox::BBox; vertices::V, normals::N,
) where {
    V <: AbstractVector{SVector{3, Float32}},
    N <: AbstractVector{SVector{3, Float32}},
}
    length(vertices) == length(normals) || error(
        "Number of normals `$(length(normals))` should be the same as " *
        "number of vertices `$(length(vertices))`.")

    old_render_mode = renderer.mode
    old_resolution = get_resolution(renderer.camera)

    renderer.mode = Color
    resize!(renderer; width=1, height=length(vertices))
    render!(consumer, renderer, occupancy, train_bbox; vertices, normals)

    rgba = reshape(
        reinterpret(Float32, renderer.buffer.buffer),
        4, size(renderer.buffer.buffer)...)
    rgb = rgba[1:3, :, :]

    # Return visualizer to the previous state.
    renderer.mode = old_render_mode
    resize!(renderer, width=old_resolution[1], height=old_resolution[2])

    return reinterpret(SVector{3, Float32}, reshape(rgb, length(rgb)))
end

function init_rays_from_vertices_and_normals!(
    renderer::Renderer, occupancy::OccupancyGrid, vertices, normals,
)
    kab = get_backend(renderer)
    (; offset, tile_size) = current_tile(renderer)
    (; alive_rays) = alive(renderer.bundle)

    init_rays_from_vertices_and_normals_kernel!(kab)(
        alive_rays, UInt32(offset), renderer.bbox, vertices, normals;
        ndrange=tile_size)

    n_levels::UInt32 = get_n_levels(occupancy)
    resolution::UInt32 = get_resolution(occupancy)
    init_advance!(kab)(
        alive_rays, renderer.cone, renderer.bbox, occupancy.binary,
        n_levels, resolution, UInt32(0); ndrange=tile_size)
    return
end

@kernel function init_rays_from_vertices_and_normals_kernel!(
    rays::R, offset::UInt32, rendering_bbox::BBox, vertices, normals,
) where R <: AbstractVector{RenderRay}
    i::UInt32 = @index(Global)
    idx = i + offset
    ray = Ray(vertices[idx], -normalize(normals[idx]))
    t_start = max((rendering_bbox ∩ ray)[1], 0f0)
    is_alive = !isinf(t_start) && (ray(t_start) ∈ rendering_bbox)
    rays[i] = RenderRay(ray, t_start, i, UInt32(0), is_alive)
end
