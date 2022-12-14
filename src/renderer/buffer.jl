struct RenderBuffer{B <: AbstractMatrix{SVector{4, Float32}}}
    buffer::B
end

function RenderBuffer(dev; width::Int, height::Int)
    buffer = similar(dev, SVector{4, Float32}, (width, height))
    fill!(reinterpret(Float32, buffer), 0f0)
    RenderBuffer(buffer)
end

get_device(::RenderBuffer{B}) where B = device_from_type(B)

reset!(b::RenderBuffer) = fill!(reinterpret(Float32, b.buffer), 0f0)

function to_image(b::RenderBuffer)
    raw_buffer = reshape(
        reinterpret(Float32, Array(b.buffer)), 4, size(b.buffer)...)
    clamp01!(raw_buffer)
    colorview(RGBA, permutedims(raw_buffer, (1, 3, 2)))
end

function to_gl_texture(b::RenderBuffer)
    raw_buffer = reinterpret(Float32, Array(b.buffer))
    # Select only RGB channels & flip vertically.
    host_buffer = reshape(raw_buffer, 4, size(b.buffer)...)[1:3, :, end:-1:1]
    clamp01!(host_buffer)
    colorview(RGB{Float32}, host_buffer)
end
