include("mt.jl")
include("subdivision.jl")

function _get_tetrahedra_grid()
    grid = BSON.load(joinpath(
        pkgdir(Nerf), "data/marching_tetrahedra/grid32.bson"))
    grid[:vertices], grid[:indices]
end

function marching_tetrahedra(
    consumer, renderer::Renderer, train_bbox::BBox;
    threshold::Float32, subdivide::Integer = 1,
)
    Backend = get_backend(renderer)

    grid_vertices_host, grid_indices_host = _get_tetrahedra_grid()
    grid_vertices = adapt(Backend, grid_vertices_host)
    grid_indices = adapt(Backend, grid_indices_host)
    for _ in 1:subdivide
        grid_vertices, grid_indices = subdivide_tetrahedra(
            grid_vertices, nothing; indices=grid_indices)
    end

    positions = allocate(Backend, SVector{3, Float32}, size(grid_vertices, 2))
    generate_mt_grid_samples!(Backend)(
        positions, reinterpret(SVector{3, Float32}, grid_vertices),
        renderer.bbox, train_bbox; ndrange=length(positions))

    raw_positions = reshape(reinterpret(Float32, positions), 3, :)
    densities = consumer(raw_positions) .- threshold

    raw_vertices, raw_indices = marching_tetrahedra(
        grid_vertices, densities; indices=grid_indices)
    vertices = reinterpret(SVector{3, Float32}, reshape(raw_vertices, :))
    # Transform vertices global CS.
    mt_to_global_cs!(Backend)(
        vertices, renderer.bbox; ndrange=length(vertices))

    indices = reshape(raw_indices, :)
    @assert maximum(indices) < length(vertices)

    normals = mesh_1_ring(vertices, indices)
    vertices, normals, indices
end

@kernel function generate_mt_grid_samples!(
    positions, grid_vertices, render_bbox::BBox, train_bbox::BBox,
)
    i = @index(Global)
    positions[i] = relative_position(train_bbox,
        inv_relative_position(render_bbox, grid_vertices[i]))
end

@kernel function mt_to_global_cs!(vertices, bbox::BBox)
    i = @index(Global)
    vertices[i] = inv_relative_position(bbox, vertices[i])
end
