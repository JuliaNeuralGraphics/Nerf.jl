struct Images{I <: AbstractArray{UInt8}}
    data::I
end

Adapt.adapt_structure(to, xs::Images) = Images(adapt(to, xs.data))

function Images(frame_filepaths::Vector{String})
    n_images = length(frame_filepaths)
    first_image = load_image(frame_filepaths[1]; target_size=nothing)
    height, width = size(first_image)

    data = Array{UInt8}(undef, 3, width, height, n_images)
    data[:, :, :, 1] .= raw_image(first_image)
    for i in 2:n_images
        image = load_image(frame_filepaths[i]; target_size=(height, width))
        data[:, :, :, i] .= raw_image(image)
    end
    Images(data)
end

function load_image(filename::String; target_size)
    frame = RGB.(load(filename))
    if target_size ≢ nothing && size(frame) != target_size
        frame = imresize(frame, target_size)
    end
    frame
end

width(i::Images) = size(i.data, 2)

height(i::Images) = size(i.data, 3)

function raw_image(image)
    data = permutedims(Float32.(channelview(image)), (1, 3, 2))
    floor.(UInt8, data .* 255f0)
end

@inline function sample(i::Images, xy::SVector{2, Float32}, image_idx::UInt32)
    width::UInt32, height::UInt32 = size(i.data, 2), size(i.data, 3)
    pixel = to_pixel(xy, width, height)
    SVector{3, Float32}(
        i.data[1, pixel[1], pixel[2], image_idx],
        i.data[2, pixel[1], pixel[2], image_idx],
        i.data[3, pixel[1], pixel[2], image_idx],
    ) .* (1f0 / 255f0)
end

@inline function to_pixel(xy::SVector{2, Float32}, width::UInt32, height::UInt32)
    resolution = SVector{2, UInt32}(width, height)
    p = floor.(UInt32, xy .* resolution)
    min.(p, resolution .- 0x1) .+ 0x1
end
