@inline function Ray(
    xy::SVector{2, Float32}, rotation::SMatrix{3, 3, Float32, 9},
    translation::SVector{3, Float32}, intrinsics::CameraIntrinsics{D},
) where D
    origin = translation
    xy =
        (xy .- intrinsics.principal) .*
        intrinsics.resolution ./ intrinsics.focal
    D && (xy = undistort(xy, intrinsics.distortion);)
    # TODO make direction -1f0 at Z?
    direction = normalize(rotation * SVector{3, Float32}(xy[1], xy[2], 1f0))
    Ray(origin, direction)
end

@inline function undistort(
    direction::SVector{2, Float32}, distortion::SVector{4, Float32},
)
    n_iterations::UInt32 = 100
    max_step_norm = 1f-10
    rel_step_size = 1f-6

    x0 = SVector{2, Float32}(direction)
    x = SVector{2, Float32}(direction)

    @inbounds for _ in 1:n_iterations
        δ0 = max(eps(Float32), abs(rel_step_size * x[1]))
        δ1 = max(eps(Float32), abs(rel_step_size * x[2]))

        ∂x = camera_distortion(distortion, x[1], x[2])
        ∂x_0b = camera_distortion(distortion, x[1] - δ0, x[2])
        ∂x_0f = camera_distortion(distortion, x[1] + δ0, x[2])
        ∂x_1b = camera_distortion(distortion, x[1], x[2] - δ1)
        ∂x_1f = camera_distortion(distortion, x[1], x[2] + δ1)

        J = SMatrix{2, 2, Float32, 4}(
            1f0 + (∂x_0f[1] - ∂x_0b[1]) / (2f0 * δ0),
                  (∂x_0f[2] - ∂x_0b[2]) / (2f0 * δ0),
                  (∂x_1f[1] - ∂x_1b[1]) / (2f0 * δ1),
            1f0 + (∂x_1f[2] - ∂x_1b[2]) / (2f0 * δ1))

        Δ = inv(J) * (x .+ ∂x .- x0)
        x = x .- Δ
        (Δ[1]^2 + Δ[2]^2) < max_step_norm && break
    end
    x
end

@inline function camera_distortion(
    distortion::SVector{4, Float32}, u::Float32, v::Float32,
)
    u² = u^2
    v² = v^2
    r² = u² + v²
    uv = u * v

    k1, k2, p1, p2 = distortion
    radial = k1 * r² + k2 * r² * r²

    # (∂u, ∂v)
    SVector{2, Float32}(
        u * radial + 2f0 * p1 * uv + p2 * (r² + 2f0 * u²),
        v * radial + 2f0 * p2 * uv + p1 * (r² + 2f0 * v²))
end
