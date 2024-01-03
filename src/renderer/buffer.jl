mutable struct RenderBuffer{B <: AbstractMatrix{SVector{4, Float32}}}
    buffer::B
    accumulator::B
    spp::UInt32
end

function RenderBuffer(kab; width::Int, height::Int)
    buffer = allocate(kab, SVector{4, Float32}, (width, height))
    accumulator = allocate(kab, SVector{4, Float32}, (width, height))
    fill!(reinterpret(Float32, buffer), 0f0)
    fill!(reinterpret(Float32, accumulator), 0f0)
    RenderBuffer(buffer, accumulator, UInt32(0))
end

KernelAbstractions.get_backend(b::RenderBuffer) = get_backend(b.buffer)

reset_spp!(b::RenderBuffer) = b.spp = 0

clear!(b::RenderBuffer) = fill!(reinterpret(Float32, b.buffer), 0f0)

clear_accumulator!(b::RenderBuffer) = fill!(reinterpret(Float32, b.accumulator), 0f0)

function reset!(b::RenderBuffer)
    clear!(b)
    clear_accumulator!(b)
    reset_spp!(b)
end

function accumulate!(b::RenderBuffer; offset::UInt32, tile_size::Int)
    accumulate_kernel!(get_backend(b))(
        b.accumulator, b.buffer, offset, Float32(b.spp); ndrange=tile_size)
    return
end

@kernel function accumulate_kernel!(
    accumulator::B, @Const(buffer), offset::UInt32, spp::Float32,
) where B <: AbstractMatrix{SVector{4, Float32}}
    i::UInt32 = @index(Global)
    idx = i + offset
    @inbounds tmp = accumulator[idx]
    @inbounds accumulator[idx] = (tmp .* spp .+ buffer[idx]) ./ (spp + 1f0)
end

function to_image(b::RenderBuffer)
    raw_buffer = reinterpret(Float32, Array(b.accumulator))
    host_buffer = reshape(raw_buffer, 4, size(b.accumulator)...)
    clamp01!(host_buffer)
    colorview(RGBA{Float32}, permutedims(host_buffer, (1, 3, 2)))
end

function to_gl_texture(b::RenderBuffer)
    raw_buffer = reinterpret(Float32, Array(b.accumulator))
    # Select only RGB channels & flip vertically.
    host_buffer = reshape(raw_buffer, 4, size(b.accumulator)...)[1:3, :, end:-1:1]
    clamp01!(host_buffer)
    colorview(RGB{Float32}, host_buffer)
end
