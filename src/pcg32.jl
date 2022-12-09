"""
Implementation of the PCG32 RNG.

We use stateless implementation as it is not allowed to pass
mutable structs inside to CUDA kernels.
So instead we pass only the initial state to the kernel.

From "PCG: A Family of Simple Fast Space-Efficient Statistically Good Algorithms for Random Number Generation" (2014)
https://www.pcg-random.org/index.html
"""
const PCG_MULT = 0x5851f42d4c957f2d
const PCG_STATE = 0x853c49e6748fea9b
const PCG_INC = 0xda3e39cb94b95bdb

"""
    next_uint(state::UInt64)

Generate uniformly distributed `UInt32` number using PCG32 RNG.

# Arguments:

- `state::UInt64`: State of the RNG.
"""
@inline function next_uint(state::UInt64)
    xor_shifted = (((state >> UInt32(18)) ⊻ state) >> UInt32(27)) % UInt32
    rot = (state >> UInt32(59)) % UInt32

    u::UInt32 = (xor_shifted >> rot) | (xor_shifted << ((~rot + 0x1) & UInt32(31)))
    new_state = state * PCG_MULT + PCG_INC

    u, new_state
end

"""
    next_float(state::UInt64)

Generate uniformly distributed `Float32` number in `[0, 1)` range
using PCG32 RNG.

# Arguments:

- `state::UInt64`: State of the RNG.
"""
@inline function next_float(state::UInt64)
    u, new_state = next_uint(state)
    v = reinterpret(Float32, (u >> 0x9) | 0x3f800000)
    (v - 1f0), new_state
end

"""
    advance(state::UInt64, δ)

Multi-step advance function (jump-ahead, jump-back).

# Arguments:

- `state::UInt64`: State of the RNG.
- `δ`: Integer number representing number of the steps
to perform on the `state`.
"""
@inline function advance(state::UInt64, δ = 1 << 32)
    curr_mult = PCG_MULT
    curr_inc = PCG_INC

    acc_mult::UInt64 = 1
    acc_inc::UInt64 = 0

    Δ = δ % UInt64
    while Δ > 0x0
        if Δ & 0x1 == 0x1
            acc_mult *= curr_mult
            acc_inc = acc_inc * curr_mult + curr_inc
        end
        curr_inc = (curr_mult + 0x1) * curr_inc
        curr_mult *= curr_mult
        Δ ÷= 0x2
    end
    acc_mult * state + acc_inc
end

"""
    random_vec3f0(state::UInt64)

Generate random `SVector{3, Float32}` using PCG32 RNG.

# Arguments:

- `state::UInt64`: State of the RNG.

# Returns:

Vector and the new RNG state.
"""
@inline function random_vec3f0(state::UInt64)
    x, state = next_float(state)
    y, state = next_float(state)
    z, state = next_float(state)
    SVector{3, Float32}(x, y, z), state
end

"""
    random_vec2f0(state::UInt64)

Generate random `SVector{2, Float32}` using PCG32 RNG.

# Arguments:

- `state::UInt64`: State of the RNG.

# Returns:

Vector and the new RNG state.
"""
@inline function random_vec2f0(state::UInt64)
    x, state = next_float(state)
    y, state = next_float(state)
    SVector{2, Float32}(x, y), state
end
