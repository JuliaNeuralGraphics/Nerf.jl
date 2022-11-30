include("triangle_table.jl")
include("trace_vertex_colors.jl")
include("mesh_io.jl")

"""
    marching_cubes(
        trainer::NerfTraining, render_bbox::BBox;
        threshold::Float32 = 2.5f0, mesh_resolution::Int = 256)

Compute polygonal surface representation of NeRF using Marching Cubes algorithm.

This is a convenience wrapper around [`marching_cubes`](@ref),
[`get_marching_cubes_resolution`](@ref), [`save_mesh`](@ref),
[`trace_mesh_vertex_colors!`](@ref) methods for [`NerfTraining`](@ref).

# Arguments:

- `threshold::Float32`: Threshold that determines boundary of the surface.
    This threshold is for the *log-space* densities obtained by evaluating the
    model on sampled positions. Default value is `2.5f0`.
- `mesh_resolution::Int`: Defines grid resolution for marching cubes.
    Must be in `[16, 2048]` range. Default is `256`.

# Returns:

`true` if successfully created mesh, `false` otherwise.
It may fail if there are less than `3` vertices of less than `1` triangle.

# References:

<http://paulbourke.net/geometry/polygonise/>
"""
function marching_cubes(
    density_consumer, renderer::Renderer, train_bbox::BBox;
    threshold::Float32 = 2.5f0, mesh_resolution::Int = 256,
)
    16 ≤ mesh_resolution ≤ 2048 || error(
        "`mesh_resolution` must in in `[16, 2048]` range, " *
        "but is instead `$(mesh_resolution)`.")

    mc_resolution = get_marching_cubes_resolution(
        mesh_resolution, renderer.bbox)

    dev, ndrange = get_device(renderer), tuple(mc_resolution...)
    positions = similar(dev, Float32, (3, ndrange...))
    generate_grid_samples_uniform!(
        positions, mc_resolution, train_bbox, renderer.bbox)

    densities = reshape(density_consumer(reshape(positions, 3, :)), ndrange)
    mc_result = marching_cubes(
        densities, threshold, renderer.bbox, mc_resolution)
    isnothing(mc_result) && return nothing

    vertices, indices = mc_result
    normals = mesh_1_ring(vertices, indices)
    return vertices, normals, indices
end

"""
    mesh_1_ring(vertices, indices)

# Arguments:
- `vertices`: Vector of `SVector{3, Float32}` vertex coordinates.
- `indices`: Vector of `UInt32` indices starting from `0`.
"""
function mesh_1_ring(vertices::V, indices::I) where {
    V <: AbstractVector{SVector{3, Float32}}, I <: AbstractVector{UInt32},
}
    length(indices) % 3 == 0 || error(
        "Number of indices must be divisible by 3, " *
        "but is instead `$(length(indices))`")

    n_vertices, n_triangles = length(vertices), length(indices) ÷ 3

    dev = device_from_type(vertices)
    normals = zeros(dev, Float32, (3, n_vertices))
    wait(accumulate_1_ring!(dev)(
        normals, vertices, indices; ndrange=n_triangles))
    # TODO return normalized :/ normals
    reinterpret(SVector{3, Float32}, reshape(normals, length(normals)))
end

@kernel function accumulate_1_ring!(normals, vertices, indices)
    i = @index(Global) - 1
    ia, ib, ic = indices[i * 3 + 1] + 1, indices[i * 3 + 2] + 1, indices[i * 3 + 3] + 1
    pa, pb, pc = vertices[ia], vertices[ib], vertices[ic]

    n = (pb .- pa) × (pa - pc)
    @atomic normals[1, ia] + n[1]
    @atomic normals[2, ia] + n[2]
    @atomic normals[3, ia] + n[3]

    @atomic normals[1, ib] + n[1]
    @atomic normals[2, ib] + n[2]
    @atomic normals[3, ib] + n[3]

    @atomic normals[1, ic] + n[1]
    @atomic normals[2, ic] + n[2]
    @atomic normals[3, ic] + n[3]
end

"""
    marching_cubes(
        log_densities, threshold::Float32, render_bbox::BBox,
        mc_resolution::SVector{3, UInt32})

Given 3D grid of log-densities perform marching cubes on it.

For more details, see [`count_and_generate_vertices!`](@ref) and
[`count_and_generate_faces!`](@ref) methods.

# Arguments:

- `log_densities`: 3D grid of log densities (non-exponentiated, i.e. log-space)
    which will be used to perform marching cubes. It must be of `mc_resolution`
    shape.
- `threshold::Float32`: Log-space density threshold that determines
    boundary-crossing. If for a given point in the grid, log density is
    higher than this `threshold`, it is considered to be inside of a mesh.
- `render_bbox::BBox`: Bounding box that is used for rendering.
    Marching cubes is done in its domain.
- `mc_resolution::SVector{3, UInt32}`: Resolution of the marching cubes
    sampling grid. Can be computed with [`get_marching_cubes_resolution`](@ref).

# Returns:

- Vertex grid - 4D grid of `(3, mc_resolution...)` shape containing vertex ids.
- Vertices - Vector of `SVector{3, Float32}` that contains vertex coordinates.
- Indices - Vector of `UInt32` that contains triangle ids. Number of
    triangles is then `length(indices) ÷ 3`.

# Examples:

```jldoctest
julia> mesh_resolution = 16;

julia> render_bbox = BBox(SVector{3, Float32}(0, 0, 0), SVector{3, Float32}(1, 1, 1));

julia> mc_resolution = INGP.get_marching_cubes_resolution(mesh_resolution, render_bbox);

julia> fake_densities = zeros(CPU(), Float32, tuple(Int64.(mc_resolution)...));

julia> fake_densities[2:3, 2:3, 2] .= 1f0;

julia> vertex_grid, vertices, indices = INGP.marching_cubes(fake_densities, 0.5f0, render_bbox, mc_resolution);

julia> length(vertices), length(indices)
(16, 84)
```

# Raises:

- `ErrorException` if `log_densities` is not a 3D grid.
- `ErrorException` if `log_densities` is not of `mc_resolution` shape.
"""
function marching_cubes(
    log_densities, threshold::Float32, render_bbox::BBox,
    mc_resolution::SVector{3, Int},
)
    ndims(log_densities) != 3 && error(
        "`log_densities` must be a 3D grid, " *
        "but is instead $(ndims(log_densities))")
    ndrange = tuple(mc_resolution...)
    size(log_densities) != ndrange && error(
        "Size of `log_densities` must be equal to `mc_resolution`, " *
        "but is instead $(size(log_densities))")

    dev = device_from_type(log_densities)
    counters = zeros(dev, UInt32, 2)
    generation_counters = zeros(dev, UInt32, 2)
    vertex_grid = fill(dev, Int32(-1), (3, ndrange...))

    wait(count_and_generate_vertices!(dev)(
        nothing, nothing, counters, log_densities, threshold,
        render_bbox, UInt32.(mc_resolution); ndrange))

    triangle_table = to_device(dev, TRIANGLE_TABLE)
    wait(count_and_generate_faces!(dev)(
        nothing, counters, nothing, triangle_table,
        log_densities, threshold; ndrange=ndrange .- 1))

    host_counters = Int64.(Vector{UInt32}(counters))
    if host_counters[1] < 3 || host_counters[2] == 0
        @warn "Less than `3` vertices will be generated or less than 1 face." *
            "Try different threshold, current is `$threshold`."
        return nothing
    end

    n_vertices, n_indices = host_counters
    @assert n_indices % 3 == 0

    vertices = zeros(dev, SVector{3, Float32}, n_vertices)
    wait(count_and_generate_vertices!(dev)(
        vertex_grid, vertices, generation_counters, log_densities, threshold,
        render_bbox, UInt32.(mc_resolution); ndrange))

    indices = similar(dev, UInt32, n_indices)
    wait(count_and_generate_faces!(dev)(
        indices, generation_counters, vertex_grid, triangle_table,
        log_densities, threshold; ndrange=ndrange .- 1))

    host_generation_counters = Int64.(Vector{UInt32}(generation_counters))
    @assert host_counters == host_generation_counters

    vertices, indices
end

"""
    function count_and_generate_faces!(
        indices, counters, @Const(vertex_grid), @Const(triangle_table),
        @Const(log_densities), threshold::Float32)

Given `log_densities` count number of indices that define triangles
and optionally compute actual indices.

# Arguments:

- `indices`: Output array of triangle indices. Pass `nothing` to only count
    number of indices, without generating them.
- `counters`: Array of at least size `2`. Number of indices that will be
    generated is written in the second element of it. Must be initialized
    to `0`.
- `vertex_grid`: 4D vertex grid computed by
    [`count_and_generate_vertices!`](@ref) that contains vertex ids.
- `log_densities`: 3D grid of log-space densities that is used to determine
    face boundaries.
- `threshold::Float32`: Log-space density threshold that defines
    boundary crossing.
"""
@kernel function count_and_generate_faces!(
    indices, counters, @Const(vertex_grid), @Const(triangle_table),
    @Const(log_densities), threshold::Float32,
)
    x, y, z = @index(Global, NTuple)

    cubeindex::UInt32 = 0
    log_densities[x,     y,     z] > threshold && (cubeindex |= 1;)
    log_densities[x + 1, y,     z] > threshold && (cubeindex |= 2;)
    log_densities[x + 1, y + 1, z] > threshold && (cubeindex |= 4;)
    log_densities[x,     y + 1, z] > threshold && (cubeindex |= 8;)
    log_densities[x,     y,     z + 1] > threshold && (cubeindex |= 16;)
    log_densities[x + 1, y,     z + 1] > threshold && (cubeindex |= 32;)
    log_densities[x + 1, y + 1, z + 1] > threshold && (cubeindex |= 64;)
    log_densities[x,     y + 1, z + 1] > threshold && (cubeindex |= 128;)

    if (cubeindex != 0) && (cubeindex != 255)
        ttm = @view(triangle_table[:, cubeindex + 1])

        n_indices::UInt32 = 0
        while n_indices < 15
            ttm[n_indices + 1] < 0 && break
            n_indices += 3
        end

        if n_indices > 0
            index, _ = @atomic counters[2] + n_indices
            if !isnothing(indices)
                local_edges = SVector{12, Int32}(
                    vertex_grid[1, x,     y,     z],
                    vertex_grid[2, x + 1, y,     z],
                    vertex_grid[1, x,     y + 1, z],
                    vertex_grid[2, x,     y,     z],

                    vertex_grid[1, x,     y,     z + 1],
                    vertex_grid[2, x + 1, y,     z + 1],
                    vertex_grid[1, x,     y + 1, z + 1],
                    vertex_grid[2, x,     y,     z + 1],

                    vertex_grid[3, x,     y,     z],
                    vertex_grid[3, x + 1, y,     z],
                    vertex_grid[3, x + 1, y + 1, z],
                    vertex_grid[3, x,     y + 1, z])

                for i in 1:16
                    j = ttm[i]
                    j < 0 && break
                    indices[index + i] = local_edges[j + 1] - 1
                end
            end
        end
    end
end

"""
Given `log_densities` count number of vertices and optionally compute
vertex coordinates contained in the `render_bbox` bounding box.

# How it works:

Given `idx = (x, y, z)` coordinate of a cell in a grid of `resolution` size,
shift it by `1` along each dimension and test if there is
density boundary-crossing between `idx` and shifted coordinate `idxₛ`.

**Boundary crossing** is when
`(log_densities[idx] > threshold) ≠ (log_densities[idxₛ] > threshold)`.
If there is boundary crossing, then add new vertex and its id.
"""
@kernel function count_and_generate_vertices!(
    vertex_grid, vertices, counters, @Const(log_densities),
    threshold::Float32, render_bbox::BBox, resolution::SVector{3, UInt32},
)
    idx = @index(Global, NTuple)
    scale = 1f0 ./ (resolution .- 1)

    d0 = log_densities[idx...]
    is_inside = d0 > threshold

    for dim in 1:3
        if idx[dim] < resolution[dim]
            midx = MVector{3, UInt32}(idx...)
            midx[dim] += 0x1
            d1 = log_densities[midx...]

            if is_inside != (d1 > threshold)
                _, vertex_idx = @atomic counters[1] + 0x1
                if !isnothing(vertices)
                    vertex_grid[dim, idx...] = vertex_idx
                    vertex = MVector{3, Float32}((idx .- 1)...)

                    if abs(d1 - d0) < 1e-5
                    elseif abs(threshold - d0) < 1e-5
                    elseif abs(threshold - d1) < 1e-5
                        vertex[dim] += 1
                    else
                        vertex[dim] += (threshold - d0) / (d1 - d0)
                    end

                    vertices[vertex_idx] = inv_relative_position(
                        render_bbox, vertex .* scale)
                end
            end
        end
    end
end

"""
Generate samples on the grid bounded by `render_bbox`,
but in CS of `train_bbox`, because they are then evaluated using trained model.
Note that `render_bbox` ⊆ `train_bbox`.
"""
function generate_grid_samples_uniform!(
    positions, mc_resolution::SVector{3, Int},
    train_bbox::BBox, render_bbox::BBox,
)
    ndims(positions) != 4 && error(
        "`positions` must be a 4D grid, but is instead $(ndims(positions))")

    ndrange = tuple(Int.(mc_resolution)...)
    size(positions)[2:4] != ndrange && error(
        "Size of `positions` must be equal to `mc_resolution`=$ndrange, " *
        "but is instead $(size(positions))")
    render_bbox ∈ train_bbox || error(
        "`render_bbox` $render_bbox must be inside `train_bbox` $train_bbox.")

    dev = device_from_type(positions)
    wait(generate_grid_samples_uniform_kernel!(dev)(
        positions, UInt32.(mc_resolution),
        render_bbox, train_bbox; ndrange))
    return nothing
end

@kernel function generate_grid_samples_uniform_kernel!(
    positions, resolution::SVector{3, UInt32},
    render_bbox::BBox, train_bbox::BBox,
)
    x, y, z = @index(Global, NTuple)
    position = (SVector{3, Float32}(x, y, z) .- 1f0) ./ (resolution .- 1f0)
    # Transform: render bbox -> global -> train bbox.
    position = inv_relative_position(render_bbox, position)
    position = relative_position(train_bbox, position)
    # TODO use SVector{3, Float32}
    for j in 1:3
        @inbounds positions[j, x, y, z] = position[j]
    end
end

"""
Given mesh resolution and rendering bounding box in which it lies,
compute marching cubes resolution.
"""
function get_marching_cubes_resolution(mesh_resolution::Int, render_bbox::BBox)
    mesh_resolution < 16 &&
        error("Minimal mesh resolution is 16, but given: $mesh_resolution")

    δ = diag(render_bbox)
    scale = mesh_resolution / maximum(δ)
    mc_resolution = floor.(Int, δ .* scale .+ 0.5f0)
    next_multiple.(mc_resolution, 16)
end
