struct Images{I <: AbstractArray{UInt8}}
    data::I
end

Adapt.adapt_structure(to, xs::Images) = Images(adapt(to, xs.data))

function Images(frame_filepaths::Vector{String})
    n_images = length(frame_filepaths)

    first_image = load_image(frame_filepaths[1]; target_size=nothing)
    height, width = size(first_image)
    n_channels = length(eltype(first_image))

    data = Array{UInt8}(undef, n_channels, width, height, n_images)
    data[:, :, :, 1] .= raw_image(first_image)
    for i in 2:n_images
        image = load_image(frame_filepaths[2]; target_size=(height, width))
        data[:, :, :, i] .= raw_image(image)
    end
    Images(data)
end

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
