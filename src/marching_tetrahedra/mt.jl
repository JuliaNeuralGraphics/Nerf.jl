const TETS_N_TRIANGLES = UInt32[0, 1, 1, 2, 1, 2, 2, 1, 1, 2, 2, 1, 2, 1, 1, 0]
const TET_BASE_EDGES = UInt32[1, 2, 1, 3, 1, 4, 2, 3, 2, 4, 3, 4]
const TET_VERTEX_IDS = UInt32(2) .^ UInt32[0; 1; 2; 3;;]
const TET_TRIANGLE_TABLE = Int32[
    -1; -1; -1; -1; -1; -1;;
     1;  0;  2; -1; -1; -1;;
     4;  0;  3; -1; -1; -1;;
     1;  4;  2;  1;  3;  4;;
     3;  1;  5; -1; -1; -1;;
     2;  3;  0;  2;  5;  3;;
     1;  4;  0;  1;  5;  4;;
     4;  2;  5; -1; -1; -1;;
     4;  5;  2; -1; -1; -1;;
     4;  1;  0;  4;  5;  1;;
     3;  2;  0;  3;  5;  2;;
     1;  3;  5; -1; -1; -1;;
     4;  1;  2;  4;  3;  1;;
     3;  0;  4; -1; -1; -1;;
     2;  0;  1; -1; -1; -1;;
    -1; -1; -1; -1; -1; -1;;]

"""
    marching_tetrahedra(vertices, field; indices)

Convert scalar field encoded on the tetrahedral grid
to triangle mesh using marching tetrahedra algorithm.

# Arguments:

- `vertices`:
    Vertices of the tetrahedral mesh of `3xN` shape and `Float32` eltype.
- `field`:
    Scalar field evaluated at each vertex position
    of `N` length and `Float32` eltype.
- `indices`:
    Tetrahedral mesh topology (face indices)
    of `4xK` shape and `UInt32` eltype.

# Returns:

Vertex coordinates and triangle ids of the produced triangular mesh.
Triangle mesh vertices are in the same coordinate system as input `vertices`
and of `3xN` shape.
Triangle ids are in `3xK` shape.

# References:

<https://arxiv.org/abs/2111.04276>
"""
function marching_tetrahedra(vertices::V, field; indices) where V
    (ndims(vertices) == 2 && size(vertices, 1) == 3) || throw(ArgumentError(
        "`vertices` must be a 3xN matrix, instead: `$(size(vertices))`."))
    (ndims(indices) == 2 && size(indices, 1) == 4) || throw(ArgumentError(
        "`indices` must be a `4xK` matrix, instead: `$(size(indices))`."))
    (ndims(field) == 1 && length(field) == size(vertices, 2)) || throw(ArgumentError(
        """
        `field` must be a vector of values sampled at `vertices` positions, instead:
        - size(field): $(size(field))
        - size(vertices): $(size(vertices))
        """))

    flipper = ChainRulesCore.@ignore_derivatives(to_device(
        device_from_type(V),
        reshape(Float32[1f0, -1f0], (1, 2, 1))))

    interp_v, faces = _mt_prep(indices, field)

    interp_batch = length(interp_v) ÷ 2
    interp_edges = reshape(vertices[:, interp_v], 3, 2, interp_batch)
    interp_field = reshape(field[interp_v], 1, 2, interp_batch) .* flipper

    denom = sum(interp_field; dims=2)
    interp_field_normalized = reverse(interp_field; dims=2) ./ denom
    verts = sum(interp_edges .* interp_field_normalized; dims=2)

    reshape(verts, size(verts, 1), size(verts, 3)), faces
end

function _mt_prep(indices::I, field) where I
    dev = device_from_type(I)

    occupied = field .> 0f0
    sampled_occupancy = occupied[indices]
    sampled_sum = sum(sampled_occupancy; dims=1)
    valid_tets = reshape((sampled_sum .> 0) .&& (sampled_sum .< 4), :)

    # Construct all edges of the tetrahedra.
    valid_indices = indices[:, valid_tets]
    isempty(valid_indices) && error("""
    No valid tetrahedrons, most likely because tetrahedrons do not cross
    `0f0` boundary (i.e. lie completely inside or outside the `field`).
    """)

    all_edges = reshape(valid_indices[TET_BASE_EDGES, :], 2, :)
    wait(_sort_edges!(dev)(all_edges; ndrange=size(all_edges, 2)))

    # Select only unique edges.
    all_edges_raw = reshape(reinterpret(UInt64, all_edges), :)
    unique_edges_raw, idx_map = _unique(all_edges_raw; dev)
    unique_edges = reshape(reinterpret(UInt32, unique_edges_raw), 2, :)

    # Select edges that cross the boundary, using `occupancy`.
    mask_edges = reshape(sum(
        reshape(occupied[reshape(unique_edges, :)], 2, :); dims=1) .== 1, :)
    interpolation_vertices = reshape(unique_edges[:, mask_edges], :)

    mapping = fill(dev, Int32(-1), (size(unique_edges, 2),))
    mapping[mask_edges] .= to_device(dev, 1:sum(mask_edges))
    idx_map = reshape(mapping[idx_map], 6, :)

    tets_indices = reshape(sum(
        sampled_occupancy[:, valid_tets] .* to_device(dev, TET_VERTEX_IDS);
        dims=1), :) .+ 0x1 # + 1 index shift
    n_triangles_table = to_device(dev, TETS_N_TRIANGLES)[tets_indices]
    triangle_table = to_device(dev, TET_TRIANGLE_TABLE)

    faces = similar(dev, UInt32, (3, 0))
    fc_kernel = _face_constructor(dev)
    for (n_triangles, n_vertices) in ((1, 3), (2, 6))
        mask = n_triangles_table .== n_triangles
        indices = idx_map[:, mask]
        if !isempty(indices)
            triangles = triangle_table[1:n_vertices, tets_indices[mask]]
            ndrange = size(indices, 2)
            faces_tmp = similar(dev, UInt32, (n_vertices, ndrange))
            wait(fc_kernel(faces_tmp, indices, triangles; ndrange))
            faces = hcat(faces, reshape(faces_tmp, 3, :))
        end
    end

    interpolation_vertices, faces
end
ChainRulesCore.@non_differentiable _mt_prep(::Any...)

@kernel function _face_constructor(faces, indices, triangles)
    i = @index(Global)
    for j in 1:size(triangles, 1)
        tr = triangles[j, i] + 0x1 # + 1 index shift
        @assert tr >= 0
        idx = indices[tr, i]
        @assert idx > 0
        faces[j, i] = idx - 0x1 # return `0`-based indices.
    end
end

function comparator(x::UInt64, y::UInt64)
    x1 = (x << 32) >> 32
    y1 = (y << 32) >> 32
    if x1 < y1
        return true
    elseif x1 == y1
        x2 = x >> 32
        y2 = y >> 32
        return x2 < y2
    else
        return false
    end
end

# For GPU: accepts tuples(value, index).
function comparator(a::Tuple, b::Tuple)
    comparator(a[1], b[1])
end

function _unique(x; dev)
    perm = Array(sortperm(x; lt=comparator))
    inv_perm = invperm(perm)
    x_sorted = x[perm]

    # NOTE
    #   we `fill` just to fill the last element
    #   which is not covered by the kernel.
    non_equal_ids = fill(dev, UInt32(length(x_sorted) + 1), (length(x_sorted) + 1,))
    mask = fill(dev, true, (length(non_equal_ids),))
    wait(_non_equal_adjacent_elements(dev)(
        non_equal_ids, mask, x_sorted; ndrange=length(x_sorted)))

    non_equal_ids = non_equal_ids[mask]
    @assert !isempty(non_equal_ids)

    x_unique = x_sorted[@view(non_equal_ids[1:end - 1])]

    reverse_ids = similar(dev, UInt32, length(x_sorted))
    deltas = @view(non_equal_ids[2:end]) .- @view(non_equal_ids[1:end - 1])
    offsets = cumsum(deltas)
    wait(_reverse_unique(dev)(
        reverse_ids, offsets, deltas; ndrange=length(x_unique)))

    x_unique, reverse_ids[inv_perm]
end

@kernel function _reverse_unique(ids, offsets, deltas)
    i::UInt32 = @index(Global)
    offset = i == 1 ? zero(UInt32) : offsets[i - 1]
    for j in 0x1:deltas[i]
        ids[offset + j] = i
    end
end

@kernel function _non_equal_adjacent_elements(non_equal_ids, mask, x)
    i::UInt32 = @index(Global)
    is_first = i == 0x1
    if is_first || (x[i] != x[i - 0x1])
        non_equal_ids[i] = i
    else
        mask[i] = false
    end
end

@kernel function _sort_edges!(edges)
    i::UInt32 = @index(Global)
    a, b = edges[1, i], edges[2, i]
    if a > b
        a, b = b, a
    end
    edges[1, i] = a
    edges[2, i] = b
end
