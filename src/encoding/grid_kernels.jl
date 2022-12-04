@kernel function grid_kernel!(
    y, ∂y∂x, @Const(x), @Const(grid), @Const(offset_table),
    npd::Val{NPD}, ::Val{NFPL}, base_resolution::UInt32, log_scale::Float32,
) where {NPD, NFPL}

    i::UInt32, level::UInt32 = @index(Global, NTuple)

    θ = @view(grid[:, (offset_table[level] + 0x1):offset_table[level + 0x1]])
    hashmap_size::UInt32 = size(θ, 2)

    scale = compute_scale(level, log_scale, base_resolution)
    resolution = ceil(UInt32, scale) + 0x1
    δposition, grid_position, ∇position = to_grid_position(
        @view(x[:, i]), scale, npd)

    result = zeros(MVector{NFPL, Float32})
    local_grid_position = MVector{NPD, UInt32}(undef)
    for idx in UnitRange{UInt32}(UInt32(0), (UInt32(1) << NPD) - 0x1)
        ω = 1f0

        for dim in UnitRange{UInt32}(UInt32(1), UInt32(NPD))
            if idx & (UInt32(1) << (dim - 0x1)) == 0x0
                ω *= 1f0 - δposition[dim]
                local_grid_position[dim] = grid_position[dim] # ⎣x⎦
            else
                ω *= δposition[dim]
                local_grid_position[dim] = grid_position[dim] + 0x1 # ⎡x⎤
            end
        end

        hash_index = grid_index(
            local_grid_position, hashmap_size, resolution)
        for f in UnitRange{UInt32}(UInt32(1), UInt32(NFPL))
            result[f] += ω * θ[f, hash_index]
        end
    end
    for f in UnitRange{UInt32}(UInt32(1), UInt32(NFPL))
        y[f, level, i] = result[f]
    end

    # Compute input gradient if needed.
    if !isnothing(∂y∂x)
        grads = zeros(MMatrix{NPD, NFPL, Float32})

        for grad_dim in 1:NPD, idx in 0x0:((UInt32(1) << (NPD - 0x1)) - 0x1)
            ω = scale
            local_grid_position = MVector{NPD, UInt32}(undef)

            for non_grad_dim in 0x1:(NPD - 0x1)
                dim = ifelse(
                    non_grad_dim ≥ grad_dim, non_grad_dim + 0x1, non_grad_dim)
                if idx & (UInt32(1) << (non_grad_dim - 0x1)) == 0x0
                    ω *= 1f0 - δposition[dim]
                    local_grid_position[dim] = grid_position[dim]
                else
                    ω *= δposition[dim]
                    local_grid_position[dim] = grid_position[dim] + 0x1
                end
            end

            local_grid_position[grad_dim] = grid_position[grad_dim]
            hash_index_left = grid_index(
                local_grid_position, hashmap_size, resolution)

            local_grid_position[grad_dim] = grid_position[grad_dim] + 0x1
            hash_index_right = grid_index(
                local_grid_position, hashmap_size, resolution)

            for f in 1:NFPL
                δ = θ[f, hash_index_right] - θ[f, hash_index_left]
                grads[grad_dim, f] += ω * δ * ∇position[grad_dim]
            end
        end

        for f in 1:NFPL, d in 1:NPD
            ∂y∂x[d, f, level, i] = grads[d, f]
        end
    end
end

@kernel function ∇grid_kernel!(
    ∂grid, @Const(∂L∂y), @Const(x), @Const(offset_table),
    npd::Val{NPD}, ::Val{NFPL},
    base_resolution, log_scale::Float32,
) where {NPD, NFPL}
    i::UInt32, level::UInt32 = @index(Global, NTuple)

    offset_start = offset_table[level]
    hashmap_size = offset_table[level + 0x1] - offset_start

    scale = compute_scale(level, log_scale, base_resolution)
    grid_resolution = ceil(UInt32, scale) + 0x1
    δposition, grid_position, _ = to_grid_position(@view(x[:, i]), scale, npd)

    s∂L∂y = MVector{NFPL, Float32}(undef)
    for f in UnitRange{UInt32}(UInt32(1), UInt32(NFPL))
        s∂L∂y[f] = ∂L∂y[f, level, i]
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
        for f in UnitRange{UInt32}(UInt32(1), UInt32(NFPL))
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
        ∂L∂yᵢ = ∂L∂y[f, l, i]
        for dim in 1:NPD
            result[dim] += ∂L∂yᵢ * ∂y∂x[dim, f, l, i]
        end
    end
    for dim in 1:NPD
        ∂L∂x[dim, i] = result[dim]
    end
end
