@kernel function grid_kernel!(
    y, ∂y∂x, @Const(x), @Const(grid), @Const(offset_table),
    npd::Val{NPD}, nfpl::Val{NFPL}, base_resolution::UInt32, log_scale::Float32,
) where {NPD, NFPL}
    i::UInt32, level::UInt32 = @index(Global, NTuple)
    θ = @view(grid[:, (offset_table[level] + 0x1):offset_table[level + 0x1]])
    hashmap_size::UInt32 = size(θ, 2)

    scale = compute_scale(level, log_scale, base_resolution)
    resolution = unsafe_trunc(UInt32, ceil(scale)) + 0x1
    δposition, grid_position, ∇position = to_grid_position(
        extract_npd(@view(x[:, i]), npd), scale)

    result = encode_grid_position(
        θ, hashmap_size, resolution,
        δposition, grid_position, npd, nfpl)
    for f in UnitRange{UInt32}(UInt32(1), UInt32(NFPL))
        @inbounds y[f, level, i] = result[f]
    end

    # Compute gradient w.r.t. input if needed.
    if !isnothing(∂y∂x)
        grads = encoding_∂y∂x(
            θ, hashmap_size, resolution, scale,
            δposition, grid_position, ∇position, npd, nfpl)
        for f in 1:NFPL, d in 1:NPD
            @inbounds ∂y∂x[d, f, level, i] = grads[d, f]
        end
    end
end

@kernel function ∇grid_kernel!(
    ∂grid, @Const(∂L∂y), @Const(x), @Const(offset_table),
    npd::Val{NPD}, ::Val{NFPL},
    base_resolution, log_scale::Float32,
) where {NPD, NFPL}
    i::UInt32, level::UInt32 = @index(Global, NTuple)
    @inbounds offset_start = offset_table[level]
    @inbounds hashmap_size = offset_table[level + 0x1] - offset_start

    scale = compute_scale(level, log_scale, base_resolution)
    grid_resolution = unsafe_trunc(UInt32, ceil(scale)) + 0x1
    δposition, grid_position, _ = to_grid_position(
        extract_npd(@view(x[:, i]), npd), scale)

    s∂L∂y = MVector{NFPL, Float32}(undef)
    for f in UnitRange{UInt32}(UInt32(1), UInt32(NFPL))
        @inbounds s∂L∂y[f] = ∂L∂y[f, level, i]
    end

    grid_pos_local = MVector{NPD, UInt32}(undef)
    for idx in UnitRange{UInt32}(UInt32(0), (UInt32(1) << NPD) - 0x1)
        ω = 1f0
        for dim in UnitRange{UInt32}(UInt32(1), UInt32(NPD))
            if idx & (UInt32(1) << (dim - 0x1)) == 0x0
                ω *= 1f0 - δposition[dim]
                grid_pos_local[dim] = grid_position[dim]
            else
                ω *= δposition[dim]
                grid_pos_local[dim] = grid_position[dim] + 0x1
            end
        end

        hash_index = offset_start + grid_index(
            grid_pos_local, hashmap_size, grid_resolution)
        @inbounds for f in UnitRange{UInt32}(UInt32(1), UInt32(NFPL))
            @atomic ∂grid[f, hash_index] += s∂L∂y[f] * ω
        end
    end
end

@kernel function ∇grid_kernel_input!(
    ∂L∂x, @Const(∂L∂y), @Const(∂y∂x),
    ::Val{NPD}, ::Val{NFPL}, ::Val{L},
) where {NPD, NFPL, L}
    i::UInt32 = @index(Global)
    result = zeros(MVector{NPD, Float32})

    for l in 1:L, f in 1:NFPL
        @inbounds ∂L∂yᵢ = ∂L∂y[f, l, i]
        for dim in 1:NPD
            @inbounds result[dim] += ∂L∂yᵢ * ∂y∂x[dim, f, l, i]
        end
    end
    for dim in 1:NPD
        @inbounds ∂L∂x[dim, i] = result[dim]
    end
end
