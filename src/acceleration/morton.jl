"""
    morton3D(x::UInt32, y::UInt32, z::UInt32)

Compute a 30-bit Morton code for the given 3D point located
in the unit cube `[0, 1]³`.
"""
@inline function morton3D(x::UInt32, y::UInt32, z::UInt32)
    xx = expand_bits(x)
    yy = expand_bits(y)
    zz = expand_bits(z)
    xx | (yy << 0x1) | (zz << 0x2)
end

@inline function morton3D_invert(x::UInt32)
    x = x & 0x49249249
    x = (x | (x >> 0x2)) & 0xc30c30c3
    x = (x | (x >> 0x4)) & 0x0f00f00f
    x = (x | (x >> 0x8)) & 0xff0000ff
    (x | (x >> 0x10)) & 0x0000ffff
end

"""
    expand_bits(v::UInt32)

Expand 10-bit integer into 30 bits by inserting 2 zeros after each bit.
"""
@inline function expand_bits(v::UInt32)
    v = (v * 0x00010001) & 0xFF0000FF
    v = (v * 0x00000101) & 0x0F00F00F
    v = (v * 0x00000011) & 0xC30C30C3
    (v * 0x00000005) & 0x49249249
end
