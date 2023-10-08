"""
    CameraIntrinsics(config)

Construct CameraIntrinsics from a config file.
"""
function NerfUtils.CameraIntrinsics(config)
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
function NerfUtils.CameraIntrinsics(width, height, fov)
    resolution = SVector{2, UInt32}(width, height)
    principal = SVector{2, Float32}(0.5f0, 0.5f0)
    focal = NerfUtils.fov2focal(resolution, rad2deg(fov))
    distortion = zeros(SVector{4, Float32})
    CameraIntrinsics(distortion, focal, principal, resolution)
end
