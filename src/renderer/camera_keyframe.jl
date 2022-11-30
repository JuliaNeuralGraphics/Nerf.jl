struct CameraKeyframe
    q::QuaternionF32
    t::SVector{3, Float32}
end

function CameraKeyframe(R::SMatrix{3, 3, Float32}, t::SVector{3, Float32})
    q = QuatRotation{Float32}(R)
    CameraKeyframe(QuaternionF32(q.w, q.x, q.y, q.z), t)
end

function CameraKeyframe(c::Camera)
    R, t = split_pose(c)
    q = QuatRotation{Float32}(R)
    CameraKeyframe(QuaternionF32(q.w, q.x, q.y, q.z), t)
end

function Base.:*(c::CameraKeyframe, v::Float32)
    CameraKeyframe(c.q * v, c.t .* v)
end

function Base.:+(c1::CameraKeyframe, c2::CameraKeyframe)
    q = c2.q
    θ = c1.q.s * c2.q.s + c1.q.v1 * c2.q.v1 + c1.q.v2 * c2.q.v2 + c1.q.v3 * c2.q.v3
    θ < 0f0 && (q = -q;)
    CameraKeyframe(c1.q + q, c1.t .+ c2.t)
end

# Cubic b-spline.
function spline(
    t::Float32,
    k0::CameraKeyframe, k1::CameraKeyframe,
    k2::CameraKeyframe, k3::CameraKeyframe,
)
    t² = t^2
    t³ = t² * t
    a = (1f0 - t)^3 / 6f0
    b = (3f0 * t³ - 6f0 * t² + 4f0) / 6f0
    c = (-3f0 * t³ + 3f0 * t² + 3f0 * t + 1f0) / 6f0
    d = t³ / 6f0
    k0 * a + k1 * b + k2 * c + k3 * d
end

"""
    lerp(
        k0::CameraKeyframe, k1::CameraKeyframe,
        t::Float32, t0::Float32, t1::Float32)

Lerp between two Camera Keyframes.

# Arguments:

- `k0::CameraKeyframe`: Start keyframe.
- `k1::CameraKeyframe`: End keyframe.
- `t::Float32`: Time value, must be in `[t0, t1]` range.
- `t0::Float32`: Start time.
- `t1::Float32`: End time.

# Returns:

Lerped `CameraKeyframe`.
"""
function lerp(
    k0::CameraKeyframe, k1::CameraKeyframe,
    t::Float32, t0::Float32, t1::Float32,
)
    t = (t - t0) / (t1 - t0)

    q = k1.q
    θ = k0.q.s * k1.q.s + k0.q.v1 * k1.q.v1 + k0.q.v2 * k1.q.v2 + k0.q.v3 * k1.q.v3
    θ < 0 && (q = -q;)

    CameraKeyframe(
        slerp(k0.q, q, t),
        k0.t .+ (k1.t .- k0.t) .* t)
end

function get_rotation(k::CameraKeyframe)
    q = QuatRotation{Float32}(k.q.s, k.q.v1, k.q.v2, k.q.v3)
    SMatrix{3, 3, Float32, 9}(q)
end
