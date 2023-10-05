struct Images{I <: AbstractArray{UInt8}}
    data::I
end

Adapt.adapt_structure(to, xs::Images) = Images(adapt(to, xs.data))

function Images(frame_filepaths::Vector{String})
    n_images = length(frame_filepaths)
    first_image = load_image(frame_filepaths[1]; target_size=nothing)
    height, width = size(first_image)
    channels = length(eltype(first_image))

    data = Array{UInt8}(undef, channels, width, height, n_images)
    data[:, :, :, 1] .= raw_image(first_image)
    for i in 2:n_images
        image = load_image(frame_filepaths[i]; target_size=(height, width))
        data[:, :, :, i] .= raw_image(image)
    end
    Images(data)
end

width(i::Images) = size(i.data, 2)

height(i::Images) = size(i.data, 3)

function load_image(filename::String; target_size)
    frame = load(filename)
    if target_size ≢ nothing && size(frame) != target_size
        frame = imresize(frame, target_size)
    end
    frame
end

function raw_image(image)
    data = permutedims(Float32.(channelview(image)), (1, 3, 2))
    floor.(UInt8, data .* 255f0)
end

@inline function sample(images::Images, xy::SVector{2, Float32}, image_idx::UInt32)
    width::UInt32 = unsafe_trunc(UInt32, size(images.data, 2))
    height::UInt32 = unsafe_trunc(UInt32, size(images.data, 3))
    pixel = to_pixel(xy, width, height)

    scale = 1f0 / 255f0
    @inbounds rgb = SVector{3, Float32}(
        images.data[1, pixel[1], pixel[2], image_idx],
        images.data[2, pixel[1], pixel[2], image_idx],
        images.data[3, pixel[1], pixel[2], image_idx],
    ) .* scale

    # TODO parametrize Images type on the number of channels
    a = if size(images.data, 1) == 4
        @inbounds Float32(images.data[4, pixel[1], pixel[2], image_idx]) * scale
    else
        1f0
    end
    return rgb, a
end

@inline function to_pixel(xy::SVector{2, Float32}, width::UInt32, height::UInt32)
    resolution = SVector{2, UInt32}(width, height)
    p = unsafe_trunc.(UInt32, floor.(xy .* resolution))
    min.(p, resolution .- 0x1) .+ 0x1
end
