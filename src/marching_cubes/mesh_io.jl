"""
    save_mesh(
        filename::String, vertices, vertex_normals, vertex_colors, indices;
        nerf_offset::SVector{3, Float32}, nerf_scale::Float32)

Save mesh defined by its vertices, indices, vertex normals and vertex colors
to `.obj` file.
`nerf_offset` and `nerf_scale` can be obtained from [`NerfDataset`](@ref).
"""
# TODO
# - add note that `vertices`, `normals`, `colors` should have eltype svec3f0
# - indices is a vec of uint32
function save_mesh(
    filename::String,
    vertices, vertex_normals, vertex_colors, indices;
    nerf_offset::SVector{3, Float32}, nerf_scale::Float32,
)
    endswith(lowercase(filename), ".obj") || error(
        "Only OBJ file format is supported. Given files is instead `$filename`.")
    length(vertices) == length(vertex_colors) || error(
        "Number of `vertex_colors` must be the same as number of `vertices`, " *
        "but is instead: `$(length(vertex_colors))` vertex_colors vs " *
        "`$(length(vertices))` vertices.")
    length(vertices) == length(vertex_normals) || error(
        "Number of `vertex_normals` must be the same as number of `vertices`, " *
        "but is instead: `$(length(vertex_normals))` vertex_normals vs " *
        "`$(length(vertices))` vertices.")

    file = open(filename, "w")
    for (vertex, color) in zip(vertices, vertex_colors)
        c = clamp01.(color)
        p = (vertex .- nerf_offset) ./ nerf_scale
        write(file, "v $(p[1]) $(p[2]) $(p[3]) $(c[1]) $(c[2]) $(c[3])\n")
    end
    for normal in vertex_normals
        n = normalize(normal)
        write(file, "vn $(n[1]) $(n[2]) $(n[3])\n")
    end
    for i in 1:3:length(indices)
        i1, i2, i3 = indices[i + 2] + 1, indices[i + 1] + 1, indices[i] + 1
        write(file, "f $i1 $i2 $i3\n")
    end
    close(file)
    nothing
end
