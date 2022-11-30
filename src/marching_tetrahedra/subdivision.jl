"""
    subdivide_tetrahedra(vertices::V, field::F; indices) where {V, F}

Subdivide tetrahedra mesh.
Each tetrahedron is subdivided into 8 smaller ones.

# Arguments:

- `vertices`:
    Vertices of the tetrahedral mesh of `3xN` shape and `Float32` eltype.
- `field`:
    Optional. Pass `nothing` to subdivide only `vertices` and `indices`.
    Scalar field evaluated at each vertex position
    of `N` length and `Float32` eltype.
- `indices`:
    Tetrahedral mesh topology (face indices)
    of `4xK` shape and `UInt32` eltype.

# Returns:

If `field` is `nothing`, then only subdivided `vertices` and `indices`.
Otherwise `vertices`, `field` and `indices` in the same shape
as the input.

# References:

<https://arxiv.org/abs/2111.04276>
"""
function subdivide_tetrahedra(vertices::V, field::F; indices) where {V, F}
    (ndims(vertices) == 2 && size(vertices, 1) == 3) || throw(ArgumentError(
        "`vertices` must be a 3xN matrix, instead: `$(size(vertices))`."))
    (ndims(indices) == 2 && size(indices, 1) == 4) || throw(ArgumentError(
        "`indices` must be a `4xK` matrix, instead: `$(size(indices))`."))
    if F != Nothing
        if !(ndims(field) == 1 && length(field) == size(vertices, 2))
            throw(ArgumentError(
            """
            `field` must be a vector of values sampled at `vertices` positions, instead:
            - size(field): $(size(field))
            - size(vertices): $(size(vertices))
            """))
        end
    end

    dev = device_from_type(V)

    all_edges = reshape(indices[TET_BASE_EDGES, :], 2, :)
    wait(_sort_edges!(dev)(all_edges; ndrange=size(all_edges, 2)))

    # Select only unique edges.
    all_edges_raw = reshape(reinterpret(UInt64, all_edges), :)
    unique_edges_raw, idx_map = _unique(all_edges_raw; dev)
    unique_edges = reshape(reinterpret(UInt32, unique_edges_raw), 2, :)

    idx_map .+= size(vertices, 2)
    idx_map_batched = reshape(idx_map, 6, :)

    vertex_features = F == Nothing ?
        vertices : vcat(vertices, reshape(field, 1, :))

    mid_vertex_features = mean(reshape(
        vertex_features[:, reshape(unique_edges, :)],
        size(vertex_features, 1), 2, :); dims=2)
    mid_vertex_features = reshape(
        mid_vertex_features, size(mid_vertex_features, 1), :)

    new_vetex_features = hcat(vertex_features, mid_vertex_features)
    new_vertices, new_field = new_vetex_features[1:3, :], new_vetex_features[4:end, :]

    idx_a, idx_b, idx_c, idx_d = map(
        i -> @view(indices[[i], :]), 1:size(indices, 1))
    idx_ab, idx_ac, idx_ad, idx_bc, idx_bd, idx_cd = map(
        i -> @view(idx_map_batched[[i], :]), 1:size(idx_map_batched, 1))

    t1 = vcat(idx_a, idx_ab, idx_ac, idx_ad)
    t2 = vcat(idx_b, idx_bc, idx_ab, idx_bd)
    t3 = vcat(idx_c, idx_ac, idx_bc, idx_cd)
    t4 = vcat(idx_d, idx_ad, idx_cd, idx_bd)
    t5 = vcat(idx_ab, idx_ac, idx_ad, idx_bd)
    t6 = vcat(idx_ab, idx_ac, idx_bd, idx_bc)
    t7 = vcat(idx_cd, idx_ac, idx_bd, idx_ad)
    t8 = vcat(idx_cd, idx_ac, idx_bc, idx_bd)
    new_indices = hcat(t1, t2, t3, t4, t5, t6, t7, t8)

    F == Nothing ?
        (new_vertices, new_indices) :
        (new_vertices, reshape(new_field, :), new_indices)
end
