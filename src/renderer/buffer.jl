mutable struct RenderBuffer{B}
    buffer::B
    accumulator::B
    spp::UInt32
end

function RenderBuffer(dev; width::Int, height::Int)
    buffer = similar(dev, SVector{4, Float32}, (width, height))
    accumulator = similar(dev, SVector{4, Float32}, (width, height))
    fill!(reinterpret(Float32, buffer), 0f0)
    fill!(reinterpret(Float32, accumulator), 0f0)
    RenderBuffer(buffer, accumulator, UInt32(0))
end

function get_device(::RenderBuffer{B}) where B
    device_from_type(B)
end

clear!(b::RenderBuffer) = fill!(reinterpret(Float32, b.buffer), 0f0)

reset_accumulation!(b::RenderBuffer) = b.spp = UInt32(0)

function clear_accumulator!(b::RenderBuffer)
    fill!(reinterpret(Float32, b.accumulator), 0f0)
end

function reset!(b::RenderBuffer)
    clear!(b)
    clear_accumulator!(b)
end

function accumulate!(b::RenderBuffer)
    b.spp == 0 && clear_accumulator!(b)
    wait(accumulate_kernel!(get_device(b))(
        b.accumulator, b.buffer, Float32(b.spp); ndrange=size(b.buffer)))
    b.spp += 1
end

function accumulate!(b::RenderBuffer, tile, resolution::SVector{2, UInt32})
    wait(accumulate_kernel!(get_device(b))(
        b.accumulator, b.buffer, tile, resolution, b.spp;
        ndrange=length(tile)))
end

@kernel function accumulate_kernel!(accumulator, @Const(buffer), spp::UInt32)
    x, y = @index(Global, NTuple)
    color = buffer[x, y]
    tmp = accumulator[x, y]
    accumulator[x, y] = (tmp .* spp .+ color) ./ (spp + 1f0)
end

@kernel function accumulate_kernel!(
    accumulator, @Const(buffer), @Const(tile),
    resolution::SVector{2, UInt32}, spp::UInt32,
)
    idx::UInt32 = tile[@index(Global)] - 0x1
    x::UInt32 = idx % resolution[0x1] + 0x1
    y::UInt32 = idx ÷ resolution[0x1] + 0x1
    tmp = accumulator[x, y]
    accumulator[x, y] = (tmp .* spp .+ buffer[x, y]) ./ (spp + 1f0)
end

function to_image(b::RenderBuffer)
    raw_buffer = reshape(
        reinterpret(Float32, Array(b.accumulator)), 4, size(b.accumulator)...)
    clamp01!(raw_buffer)
    colorview(RGBA, permutedims(raw_buffer, (1, 3, 2)))
end

function to_gl_texture(b::RenderBuffer)
    raw_buffer = reinterpret(Float32, b.accumulator)
    host_buffer = Array(@view(reshape(
        raw_buffer, 4, size(b.accumulator)...)[1:3, :, end:-1:1]))
    clamp01!(host_buffer)
    colorview(RGB{Float32}, host_buffer)
end
