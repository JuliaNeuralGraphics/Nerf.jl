function ld_random_pixel_offset(spp::UInt32)
    offset = SVector{2, Float32}(0.5f0, 0.5f0) .-
        ld_random_val_2d(zero(UInt32), 0xdeadbeef) .+
        ld_random_val_2d(spp, 0xdeadbeef)
    fract.(offset)
end

function ld_random_val(index::UInt32, seed::UInt32)
    s = Float32(1f0 / (1 << 32))
    index = nested_uniform_scramble_base2(index, seed)
    s * Float32(nested_uniform_scramble_base2(
        sobol(index), hash_combine(seed, zero(UInt32))))
end

function ld_random_val_2d(index::UInt32, seed::UInt32)
    s = 1f0 / Float32((1 << 32))
    s .* shuffled_scrambled_sobol2d(index, seed)
end

function shuffled_scrambled_sobol2d(index::UInt32, seed::UInt32)
    index = nested_uniform_scramble_base2(index, seed)
    x = sobol_2d(index)
    SVector{2, UInt32}(
        nested_uniform_scramble_base2(x[1], hash_combine(seed, UInt32(0))),
        nested_uniform_scramble_base2(x[2], hash_combine(seed, UInt32(1))))
end

function nested_uniform_scramble_base2(x::UInt32, seed::UInt32)
    x = reverse_bits(x)
    x = laine_karras_permutation(x, seed)
    reverse_bits(x)
end

function reverse_bits(x::UInt32)
    x = (((x & 0xaaaaaaaa) >> 1) | ((x & 0x55555555) << 1))
    x = (((x & 0xcccccccc) >> 2) | ((x & 0x33333333) << 2))
    x = (((x & 0xf0f0f0f0) >> 4) | ((x & 0x0f0f0f0f) << 4))
    x = (((x & 0xff00ff00) >> 8) | ((x & 0x00ff00ff) << 8))
    (x >> 16) | (x << 16)
end

function laine_karras_permutation(x::UInt32, seed::UInt32)
    x += seed
    x ⊻= x * 0x6c50b47c
    x ⊻= x * 0xb82f1e52
    x ⊻= x * 0xc7afe638
    x ⊻= x * 0x8d22f6e6
    x
end

hash_combine(seed::UInt32, v::UInt32) = seed ⊻ (v + (seed << 6) + (seed >> 2))

function _sobol(index, directions)
    x::UInt32 = 0
    for bit in UnitRange{UInt32}(0, 31)
        mask = (index >> bit) & 0x1
        @inbounds x ⊻= mask * directions[bit + 0x1]
    end
    x
end

function sobol(index::UInt32)
    directions = (
        0x80000000, 0x40000000, 0x20000000, 0x10000000,
        0x08000000, 0x04000000, 0x02000000, 0x01000000,
        0x00800000, 0x00400000, 0x00200000, 0x00100000,
        0x00080000, 0x00040000, 0x00020000, 0x00010000,
        0x00008000, 0x00004000, 0x00002000, 0x00001000,
        0x00000800, 0x00000400, 0x00000200, 0x00000100,
        0x00000080, 0x00000040, 0x00000020, 0x00000010,
        0x00000008, 0x00000004, 0x00000002, 0x00000001)
    _sobol(index, directions)
end

function sobol_2d(index::UInt32)
    directions = (
        0x80000000, 0xc0000000, 0xa0000000, 0xf0000000,
        0x88000000, 0xcc000000, 0xaa000000, 0xff000000,
        0x80800000, 0xc0c00000, 0xa0a00000, 0xf0f00000,
        0x88880000, 0xcccc0000, 0xaaaa0000, 0xffff0000,
        0x80008000, 0xc000c000, 0xa000a000, 0xf000f000,
        0x88008800, 0xcc00cc00, 0xaa00aa00, 0xff00ff00,
        0x80808080, 0xc0c0c0c0, 0xa0a0a0a0, 0xf0f0f0f0,
        0x88888888, 0xcccccccc, 0xaaaaaaaa, 0xffffffff)
    SVector{2, UInt32}(sobol(index), _sobol(index, directions))
end

@inline fract(x) = x - floor(x)
