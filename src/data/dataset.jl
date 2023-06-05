include("images.jl")
include("intrinsics.jl")

struct Dataset{
    I <: Images,
    R <: AbstractVector{SMatrix{3, 3, Float32, 9}},
    T <: AbstractVector{SVector{3, Float32}},
}
    images::I
    rotations::R
    translations::T
    intrinsics::CameraIntrinsics

    frame_filenames::Vector{String}
    rotations_host::Vector{SMatrix{3, 3, Float32, 9}}
    translations_host::Vector{SVector{3, Float32}}

    scale::Float32
    offset::SVector{3, Float32}
    bbox_scale::UInt32
end

function Dataset(
    backend; config_file::String,
    scale::Float32 = 0.33f0,
    offset = SVector{3, Float32}(0.5f0, 0.5f0, 0.5f0),
)
    isfile(config_file) || throw(ArgumentError(
        "`config_file`=`$config_file` does not exist."))
    endswith(config_file, ".json") || throw(ArgumentError(
        "`config_file`=`$config_file` must be a JSON file."))

    config = JSON.parse(read(config_file, String))
    config_dir = dirname(config_file)

    has_metadata = (
        "w" in keys(config) && "fl_x" in keys(config) &&
        "cx" in keys(config) && "k1" in keys(config))

    # HACK:
    # config file for synthetic NeRF datasets does not specify file extension,
    # so we assume that for all synthetic datasets.
    image_extension = has_metadata ? "" : ".png"

    frame_filenames = String[]
    frame_filepaths = String[]
    rotations = SMatrix{3, 3, Float32, 9}[]
    translations = SVector{3, Float32}[]

    for frame_config in config["frames"]
        frame_filename = frame_config["file_path"]
        frame_file = joinpath(config_dir, frame_filename)
        has_metadata || (frame_file = frame_file * image_extension;)
        isfile(frame_file) || continue

        push!(frame_filepaths, frame_file)
        push!(frame_filenames, frame_filename)

        projection = Float32.(transpose(
            hcat(frame_config["transform_matrix"][1:(end - 1)]...)))
        nerf_to_ngp!(projection, scale, offset)

        rotation = SMatrix{3, 3, Float32, 9}(@view(projection[1:3, 1:3]))
        translation = SVector{3, Float32}(@view(projection[1:3, 4]))
        push!(rotations, rotation)
        push!(translations, translation)
    end

    isempty(frame_filepaths) && error(
        """
        Dataset failed to load any frame.
        Check that:
            - `.json` format is correct;
            - images exist;
            - image paths are relative to the `.json` file itself.
        """)

    images = Images(frame_filepaths)
    bbox_scale::UInt32 = get(config, "aabb_scale", 1)

    if has_metadata
        intrinsics = CameraIntrinsics(config)
    else
        fov = Float32(config["camera_angle_x"])
        intrinsics = CameraIntrinsics(width(images), height(images), fov)
    end

    device_rotations = adapt(backend, rotations)
    device_translations = adapt(backend, translations)
    device_images = adapt(backend, images)
    Dataset(
        device_images, device_rotations, device_translations, intrinsics,
        frame_filenames, rotations, translations, scale, offset, bbox_scale)
end

function get_pose(d::Dataset, idx::Integer)
    R = d.rotations_host[idx]
    t = d.translations_host[idx]
    R, t
end

function get_pose_camera(d::Dataset, view_id::Integer)
    camera = Camera(MMatrix{3, 4, Float32, 12}(I), d.intrinsics)
    set_projection!(camera, get_pose(d, view_id)...)
    camera
end

Base.length(d::Dataset) = length(d.translations_host)

function nerf_to_ngp!(P, scale, offset)
    # Reflect rotation about CS origin.
    P[1:3, 2] .*= -1f0
    P[1:3, 3] .*= -1f0
    # Cycle axes: xyz -> yzx.
    # Forward: [2, 3, 1]
    # Reverse: [3, 1, 2]
    P[1:3, :] .= P[[2, 3, 1], :]
    # Scale and shift translation.
    P[1:3, 4] .= P[1:3, 4] .* scale .+ offset
end

# Fixed size step in unit-cube scenes, exponential in larger ones.
function get_cone_angle(d::Dataset)
    d.bbox_scale ≤ 1 ? 0f0 : (1f0 / 256f0)
end

# N levels for the occupancy grid.
function get_n_levels(d::Dataset)
    n_levels = 0
    while (1 << n_levels) < d.bbox_scale
        n_levels += 1
    end
    n_levels
end

# Training bbox.
function get_bbox(d::Dataset, n_levels::Int)
    max_bbox_scale = UInt32(1) << (n_levels - 1)
    if d.bbox_scale > max_bbox_scale
        error(
            """
            `aabb_scale`=`$(d.bbox_scale)` must be lower than
            maximum allowed bbox scale, which is `$max_bbox_scale` currently.
            You can increate `n_levels`=`$n_levels` parameter in `Trainer`
            by a factor of `2` and try again.
            """)
    end

    bbox = BBox(SVector{3, Float32}(0.5f0, 0.5f0, 0.5f0))
    inflate(bbox, 0.5f0 * d.bbox_scale)
end
