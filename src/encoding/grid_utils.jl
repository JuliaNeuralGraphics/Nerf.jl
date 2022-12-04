@inline smoothstep(x::Float32) = x^2 * (3f0 - 2f0 * x)

@inline ∇smoothstep(x::Float32) = 6f0 * x * (1f0 - x)

@inline function to_grid_position(x, scale::Float32, ::Val{NPD}) where NPD
    δposition = MVector{NPD, Float32}(undef)
    ∇position = MVector{NPD, Float32}(undef)
    grid_position = MVector{NPD, UInt32}(undef)

    for dim in UnitRange{UInt32}(one(UInt32), UInt32(NPD))
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
    stride = one(UInt32)
    index = zero(UInt32)

    for dim in UnitRange{UInt32}(one(UInt32), UInt32(NPD))
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
    result = zero(UInt32)
    for dim in UnitRange{UInt32}(one(UInt32), UInt32(NPD))
        result ⊻= pos_grid[dim] * primes[dim]
    end
    result
end
