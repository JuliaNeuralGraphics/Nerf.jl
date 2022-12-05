struct Camera
    projection::MMatrix{3, 4, Float32, 12}
    intrinsics::CameraIntrinsics
end

function set_projection!(
    c::Camera, rotation::SMatrix{3, 3, Float32, 9},
    translation::SVector{3, Float32},
)
    c.projection[1:3, 1:3] .= rotation
    c.projection[1:3, 4] .= translation
end

function set_resolution!(c::Camera; width::Int, height::Int)
    resolution = SVector{2, UInt32}(width, height)
    scale::Float32 = resolution[2] / c.intrinsics.resolution[2]
    focal = c.intrinsics.focal .* scale
    c.intrinsics = CameraIntrinsics(c.intrinsics; resolution, focal)
end

get_resolution(c::Camera) = Int.(c.intrinsics.resolution)

function split_pose(c::Camera)
    rotation = SMatrix{3, 3, Float32, 9}(c.projection[1:3, 1:3])
    translation = SVector{3, Float32}(c.projection[1:3, 4])
    rotation, translation
end
