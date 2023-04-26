include("morton.jl")
include("indexing.jl")

mutable struct OccupancyGrid{
    D <: AbstractArray{Float32, 4},
    B <: AbstractVector{UInt8},
}
    density::D
    binary::B
    mean_density::Float32
end

function OccupancyGrid(Backend; n_levels::Int, resolution::Int = 128)
    dim_size = ntuple(i -> resolution, Val{3}())
    density = KernelAbstractions.zeros(Backend, Float32, (dim_size..., n_levels))
    binary = KernelAbstractions.zeros(Backend, UInt8, length(density) ÷ 8)
    OccupancyGrid(density, binary, 0f0)
end

# 0-based level
@inline function offset(oc::OccupancyGrid, level::Integer)
    prod(size(oc.density)[1:3]) * level
end

@inline function offset_binary(oc::OccupancyGrid, level::Integer)
    offset(oc, level) ÷ 8
end

@inline function get_voxel_diameter(oc::OccupancyGrid, level::Integer)
    get_voxel_diameter(UInt32(get_resolution(oc)), level)
end

KernelAbstractions.get_backend(og::OccupancyGrid) = get_backend(og.density)

@inline get_resolution(oc::OccupancyGrid) = size(oc.density, 1)

@inline get_n_levels(oc::OccupancyGrid) = size(oc.density, 4)

function reset!(oc::OccupancyGrid)
    fill!(oc.density, 0f0)
    fill!(oc.binary, 0x0)
    oc.mean_density = 0f0
end

@inline function is_occupied(
    binary::B, point::SVector{3, Float32}, resolution::UInt32, level::UInt32,
) where B <: AbstractVector{UInt8}
    idx = point_to_index(point, resolution, level)
    offset::UInt32 = ((resolution^3) * level) ÷ 0x8
    bidx = idx ÷ 0x8 + offset + 0x1

    mask = 0x1 << (idx % 0x8)
    @inbounds (binary[bidx] & mask) > 0x0
end

# n_levels: 0-based
function update!(
    density_eval_fn, oc::OccupancyGrid; rng_state::UInt64,
    cone::Cone, bbox::BBox, step::Int, update_frequency::Int, n_levels::Int,
    threshold::Float32 = 0.01f0, decay::Float32 = 0.95f0, warmup_steps::Int = 256,
)
    density = @view(oc.density[:, :, :, 1:min(n_levels + 1, get_n_levels(oc))])
    n_samples = length(density)
    if step < warmup_steps
        n_uniform = n_samples
        n_non_uniform = 0
    else
        n_samples ÷= 4
        n_uniform = n_samples
        n_non_uniform = n_samples
        n_samples = n_uniform + n_non_uniform
    end

    step ÷= update_frequency

    Backend = get_backend(oc)
    points = allocate(Backend, SVector{3, Float32}, (n_samples,))
    indices = allocate(Backend, UInt32, (n_samples,))

    gp_kernel = generate_points!(Backend)
    gp_kernel(
        points, indices, rng_state, density, bbox,
        -0.01f0, UInt32(step); ndrange=n_uniform)
    rng_state = advance(rng_state)
    if n_non_uniform > 0
        offset = (n_uniform + 1):n_samples
        gp_kernel(
            @view(points[offset]), @view(indices[offset]), rng_state,
            density, bbox, threshold, UInt32(step); ndrange=n_non_uniform)
    end
    rng_state = advance(rng_state)

    raw_points = reshape(reinterpret(Float32, points), 3, :)
    log_densities = density_eval_fn(raw_points)
    unsafe_free!(points)

    tmp_density = KernelAbstractions.zeros(Backend, Float32, size(oc.density))
    distribute_density!(Backend)(
        reinterpret(UInt32, tmp_density), log_densities,
        indices, cone.min_stepsize; ndrange=length(indices))
    unsafe_free!(indices)
    unsafe_free!(log_densities)

    ema_update!(Backend)(
        oc.density, tmp_density, decay; ndrange=length(oc.density))
    unsafe_free!(tmp_density)

    update_binary!(oc; threshold)
    return rng_state
end

function update_binary!(oc::OccupancyGrid; threshold::Float32 = 0.01f0)
    Backend = get_backend(oc)

    oc.mean_density = mean(x -> max(0f0, x), @view(oc.density[:, :, :, 1]))
    threshold = min(threshold, oc.mean_density)
    distribute_to_binary!(Backend)(
        oc.binary, oc.density, threshold; ndrange=length(oc.binary))

    binary_level_length = offset_binary(oc, 1)
    binary_resolution = UInt32(size(oc.density, 1) ÷ 8)
    ndrange = binary_level_length ÷ 8
    n_levels = size(oc.density, 4)

    bmp_kernel = binary_max_pool!(Backend)
    for l in 1:(n_levels - 1)
        s, m, e = binary_level_length .* ((l - 1), l, (l + 1))
        prev_level = @view(oc.binary[(s + 1):m])
        curr_level = @view(oc.binary[(m + 1):e])
        bmp_kernel(curr_level, prev_level, binary_resolution; ndrange)
    end
end

@kernel function binary_max_pool!(
    curr_level::L, @Const(prev_level), binary_resolution::UInt32,
) where L <: AbstractVector{UInt8}
    i::UInt32 = @index(Global)
    idx = i - 0x1
    offset = idx * 0x8

    # If any bit is set in the previous level, set current level bit.
    bits::UInt8 = 0x0
    @inbounds for j in 0x1:0x8
        bits |= ifelse(prev_level[offset + j] > 0x0, 1 << (j - 0x1), 0x0)
    end

    x = morton3D_invert(idx) + binary_resolution
    y = morton3D_invert(idx >> 0x1) + binary_resolution
    z = morton3D_invert(idx >> 0x2) + binary_resolution
    @inbounds curr_level[morton3D(x, y, z) + 0x1] |= bits
end

@kernel function distribute_to_binary!(
    binary::B, @Const(density), threshold::Float32,
) where B <: AbstractVector{UInt8}
    i::UInt32 = @index(Global)
    offset = (i - 0x1) * 0x8
    bits::UInt8 = 0x0
    @inbounds for j in 0x1:0x8
        bits |= ifelse(density[offset + j] > threshold, 0x1 << (j - 0x1), 0x0)
    end
    @inbounds binary[i] = bits
end

@kernel function ema_update!(
    density::D, @Const(tmp_density), decay::Float32,
) where D <: AbstractArray{Float32, 4}
    i::UInt32 = @index(Global)
    @inbounds p = density[i]
    @inbounds c = tmp_density[i]
    @inbounds density[i] = ifelse(p < 0f0, p, max(p * decay, c))
end

@kernel function distribute_density!(
    density::D, @Const(log_density), @Const(indices), min_cone_stepsize::Float32,
) where D <: AbstractArray{UInt32, 4}
    i::UInt32 = @index(Global)
    @inbounds idx = indices[i]
    @inbounds σ = reinterpret(UInt32, exp(log_density[i]) * min_cone_stepsize)
    @inbounds @atomic max(density[idx], σ)
end

@kernel function generate_points!(
    points::P, indices::I, rng_state::UInt64, density::D,
    bbox::BBox, threshold::Float32, step::UInt32,
) where {
    P <: AbstractVector{SVector{3, Float32}},
    I <: AbstractVector{UInt32},
    D <: AbstractArray{Float32, 4},
}
    @uniform resolution::UInt32 = size(density, 1)
    @uniform level_length::UInt32 = resolution^3
    @uniform n_levels::UInt32 = size(density, 4)
    @uniform n_elements::UInt32 = @ndrange()[1]

    i::UInt32 = @index(Global)
    # 1 for level, 3 for offset, no overlap between threads.
    rng_state = advance(rng_state, (i - 0x1) * 0x4)
    ξ, rng_state = next_float(rng_state)
    δ, rng_state = random_vec3f0(rng_state)

    level::UInt32 = floor(UInt32, ξ * n_levels) % n_levels
    level_offset = level_length * level

    level_idx = zero(UInt32)
    idx = zero(UInt32)
    for j in UnitRange{UInt32}(zero(UInt32), UInt32(9))
        level_idx = lcg(i - 0x1 + step * n_elements, j, level_length)
        idx = level_idx + level_offset + 0x1
        @inbounds density[idx] > threshold && break
    end

    point = index_to_point(level_idx, resolution, level, δ)
    @inbounds points[i] = relative_position(bbox, point)
    @inbounds indices[i] = idx
end

# Linear congruential generator.
@inline function lcg(a::UInt32, b::UInt32, modulo::UInt32)::UInt32
    (a * 0x036499c9 + b * 0x0127409f + 0x05c6f785) % modulo
end

function mark_invisible_regions!(
    oc::OccupancyGrid; intrinsics, rotations, translations,
)
    Backend = get_backend(oc)
    res_scale = 0.5f0 .* intrinsics.resolution ./ intrinsics.focal
    _mark_invisible_regions!(Backend)(
        oc.density, rotations, translations, res_scale;
        ndrange=length(oc.density))
end

@kernel function _mark_invisible_regions!(
    density::D, @Const(rotations), @Const(translations),
    res_scale::SVector{2, Float32},
) where D <: AbstractArray{Float32, 4}
    @uniform resolution::UInt32 = size(density, 1)
    @uniform level_length::UInt32 = resolution^3
    @uniform n_images::UInt32 = length(rotations)

    i::UInt32 = @index(Global)
    level = (i - 0x1) ÷ level_length
    level_idx = (i - 0x1) % level_length

    point = index_to_point(level_idx, resolution, level)
    voxel_radius = get_voxel_radius(resolution, level)

    is_visible = false
    for j in UnitRange{UInt32}(UInt32(1):n_images)
        @inbounds new_point = transpose(rotations[j]) * (point - translations[j])
        if new_point[3] > 0f0
            is_visible = is_in_view(new_point, res_scale, voxel_radius)
            is_visible && break
        end
    end
    @inbounds density[i] = ifelse(is_visible, 0f0, -1f0)
end

@inline function is_in_view(
    point::SVector{3, Float32}, res_scale::SVector{2, Float32},
    voxel_radius::Float32,
)
    x = abs(point[1]) - voxel_radius
    z = point[3] * res_scale[1]
    x < z || return false

    y = abs(point[2]) - voxel_radius
    z = point[3] * res_scale[2]
    y < z
end
