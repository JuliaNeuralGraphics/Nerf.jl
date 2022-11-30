struct CameraIntrinsics{D}
    distortion::SVector{4, Float32}
    focal::SVector{2, Float32}
    principal::SVector{2, Float32}
    resolution::SVector{2, UInt32}

    function CameraIntrinsics(distortion, focal, principal, resolution)
        has_distortion = !iszero(distortion)
        new{has_distortion}(distortion, focal, principal, resolution)
    end
end

"""
    CameraIntrinsics(config)

Construct CameraIntrinsics from a config file.
"""
function CameraIntrinsics(config)
    w, h = config["w"], config["h"]
    resolution = SVector{2, UInt32}(w, h)

    focal = SVector{2, Float32}(config["fl_x"], config["fl_y"])
    principal = SVector{2, Float32}(config["cx"] / w, config["cy"] / h)
    distortion = SVector{4, Float32}(
        config["k1"], config["k2"], config["p1"], config["p2"])

    !all(0f0 .≤ principal .≤ 1f0) && throw(ArgumentError(
        """
        Principal point `$principal` should be in `[0, 1]` range,
        i.e. normalized by the resolution.
        """))
    CameraIntrinsics(distortion, focal, principal, resolution)
end

"""
    CameraIntrinsics(width, height, fov)

Construct intrinsics for synthetic dataset.
"""
function CameraIntrinsics(width, height, fov)
    resolution = SVector{2, UInt32}(width, height)
    principal = SVector{2, Float32}(0.5f0, 0.5f0)
    focal = fov2focal(resolution, rad2deg(fov))
    distortion = zeros(SVector{4, Float32})
    CameraIntrinsics(distortion, focal, principal, resolution)
end

# Copy constructor.
function CameraIntrinsics(
    c::CameraIntrinsics; distortion=c.distortion, focal=c.focal,
    principal=c.principal, resolution=c.resolution,
)
    CameraIntrinsics(distortion, focal, principal, resolution)
end

function fov2focal(resolution, degrees::Float32)
    0.5f0 * resolution / tan(0.5f0 * deg2rad(degrees))
end

function focal2fov(resolution, focal_length)
    2f0 * rad2deg(atan(resolution / (focal_length * 2f0)))
end
