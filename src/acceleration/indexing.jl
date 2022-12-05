@inline function index_to_point(
    idx::UInt32, resolution::UInt32, level::UInt32, ξ = 0.5f0,
)
    scale = ldexp(1f0, level)
    inv_idx = SVector{3, Float32}(
        morton3D_invert(idx),
        morton3D_invert(idx >> 0x1),
        morton3D_invert(idx >> 0x2)) .+ ξ
    compute_point(inv_idx, resolution, scale)
end

@inline function point_to_index(
    point::SVector{3, Float32}, resolution::UInt32, level::UInt32,
)
    scale = ldexp(1f0, -Int32(level))
    p = compute_point_inv(point, resolution, scale)
    morton3D(p[1], p[2], p[3])
end

@inline function compute_point(
    inv_idx::SVector{3, Float32}, resolution::UInt32, scale::Float32,
)
    scale .* (inv_idx ./ resolution .- 0.5f0) .+ 0.5f0
end

@inline function compute_point_inv(
    point::SVector{3, Float32}, resolution::UInt32, scale::Float32,
)
    p = (point .- 0.5f0) .* scale .+ 0.5f0
    i = floor.(Int32, p .* resolution)
    UInt32.(clamp.(i, UInt32(0), resolution - 0x1))
end

@inline function get_voxel_radius(resolution::UInt32, level::UInt32)
    0.5f0 * sqrt(3f0) * ldexp(1f0, level) / resolution
end

@inline function get_voxel_diameter(resolution::UInt32, level::UInt32)
    2f0 * get_voxel_radius(resolution, level)
end
