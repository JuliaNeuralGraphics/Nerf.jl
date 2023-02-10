@inline function encode_grid_position(
    θ, hashmap_size::UInt32, resolution::UInt32,
    δposition::MVector{NPD, Float32}, grid_position::MVector{NPD, UInt32},
    ::Val{NPD}, ::Val{NFPL},
) where {NPD, NFPL}
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
            @inbounds result[f] += ω * θ[f, hash_index]
        end
    end
    result
end

@inline function encoding_∂y∂x(
    θ, hashmap_size::UInt32, resolution::UInt32, scale::Float32,
    δposition::MVector{NPD, Float32}, grid_position::MVector{NPD, UInt32},
    ∇position::MVector{NPD, Float32},
    ::Val{NPD}, ::Val{NFPL},
) where {NPD, NFPL}
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
            @inbounds δ = θ[f, hash_index_right] - θ[f, hash_index_left]
            grads[grad_dim, f] += ω * δ * ∇position[grad_dim]
        end
    end
    grads
end

@inline function extract_npd(x, ::Val{NPD}) where NPD
    v = MVector{NPD, Float32}(undef)
    for dim in UnitRange{UInt32}(UInt32(1), UInt32(NPD))
        @inbounds v[dim] = x[dim]
    end
    v
end

@inline smoothstep(x::Float32) = x^2 * (3f0 - 2f0 * x)

@inline ∇smoothstep(x::Float32) = 6f0 * x * (1f0 - x)

@inline function to_grid_position(x::MVector{NPD, Float32}, scale::Float32) where NPD
    δposition = MVector{NPD, Float32}(undef)
    ∇position = MVector{NPD, Float32}(undef)
    grid_position = MVector{NPD, UInt32}(undef)

    for dim in UnitRange{UInt32}(UInt32(1), UInt32(NPD))
        δposition[dim] = x[dim] * scale + 0.5f0
        tmp = floor(δposition[dim])
        δposition[dim] -= tmp
        grid_position[dim] = UInt32(tmp)

        ∇position[dim] = ∇smoothstep(δposition[dim])
        δposition[dim] = smoothstep(δposition[dim])
    end
    δposition, grid_position, ∇position
end

@inline function compute_scale(
    level::UInt32, log_scale::Float32, base_resolution::UInt32,
)::Float32
    exp2((level - 0x1) * log_scale) * base_resolution - 0x1
end

@inline function next_multiple(value::T, divisor) where T
    ceil(T, value / divisor) * divisor
end

@inline function grid_index(
    grid_pos::MVector{NPD, UInt32}, hashmap_size::UInt32, resolution::UInt32,
) where NPD
    stride = UInt32(1)
    index = UInt32(0)

    for dim in UnitRange{UInt32}(UInt32(1), UInt32(NPD))
        stride > hashmap_size && break
        index += grid_pos[dim] * stride
        stride *= resolution
    end

    if stride > hashmap_size
        index = fast_hash(grid_pos)
    end
    (index % hashmap_size) + 0x1
end

@inline function fast_hash(pos_grid::MVector{NPD, UInt32}) where NPD
    primes = (0x00000001, 0x9e3779b1, 0x30025795)
    result = UInt32(0)
    for dim in UnitRange{UInt32}(UInt32(1), UInt32(NPD))
        result ⊻= pos_grid[dim] * primes[dim]
    end
    result
end
