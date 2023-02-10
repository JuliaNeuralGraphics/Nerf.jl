"""
Axis-aligned bounding box.

# Parameters:

- `min::SVector{3, Float32}`: Minimum point of the bbox.
- `max::SVector{3, Float32}`: Maximum point of the bbox.
"""
struct BBox
    min::SVector{3, Float32}
    max::SVector{3, Float32}
end

"""
    BBox()

Create an empty/invalid bbox.
By setting `min` and `max` points to `∞` 7 `-∞` we ensure that all
operations on the empty bbox give correct results.
"""
BBox() = BBox(
    SVector{3, Float32}(Inf32, Inf32, Inf32),
    SVector{3, Float32}(-Inf32, -Inf32, -Inf32))

"""
    BBox(b::SVector{3, Float32})

Create BBox that encloses a point in 3D space.

# Arguments:

- `b::SVector{3, Float32}`: 3D point.
"""
BBox(b::SVector{3, Float32}) = BBox(b, b)

function get_corners(b::BBox)
    bmin, bmax = b.min, b.max
    [
        bmin,
        SVector{3, Float32}(bmin[1], bmin[2], bmax[3]),
        SVector{3, Float32}(bmin[1], bmax[2], bmax[3]),
        SVector{3, Float32}(bmin[1], bmax[2], bmin[3]),
        bmax,
        SVector{3, Float32}(bmax[1], bmax[2], bmin[3]),
        SVector{3, Float32}(bmax[1], bmin[2], bmin[3]),
        SVector{3, Float32}(bmax[1], bmin[2], bmax[3])]
end

"""
    diag(b::BBox)

Compute diagonal of the bbox, i.e. the width along each axis.
"""
@inline diag(b::BBox) = b.max - b.min


@inline center(b::BBox) = (b.max + b.min) * 0.5f0

"""
    relative_position(b::BBox, p)

Compute relative position of the point w.r.t. bbox.
If the point is inside the bbox, then the resulting value
would be a 3D vector in `[0, 1]³`.
"""
@inline relative_position(b::BBox, p) = (p - b.min) ./ diag(b)

@inline inv_relative_position(b::BBox, p) = p .* diag(b) .+ b.min

"""
    inflate(b::BBox, amount)

Expand bbox in both directions by the `amount`.
"""
inflate(b::BBox, amount) = BBox(b.min .- amount, b.max .+ amount)

"""
Expand bbox to enclose a point.
"""
enlarge(b::BBox, p) = BBox(min.(b.min, p), max.(b.max, p))

"""
    Base.union(b1::BBox, b2::BBox)

Compute union of the two bounding boxes.
"""
function Base.union(b1::BBox, b2::BBox)
    BBox(min.(b1.min, b2.min), max.(b1.max, b2.max))
end

"""
    Base.intersect(b1::BBox, b2::BBox)

Compute intersection of the two bounding boxes.
"""
function Base.intersect(b1::BBox, b2::BBox)
    BBox(max.(b1.min, b2.min), min.(b1.max, b2.max))
end

"""
    Base.intersect(b::BBox, r::Ray)

Compute intersection of bounding box with the ray.

# Returns:

`tmin`, `tmax` ray parameters.
To obtain actual intersection points, compute point along the ray:
`ray(tmin)` & `ray(tmax)`.

In case when ray does not intersect BBox at all, returns `(Inf32, Inf32)`.
"""
@inline function Base.intersect(b::BBox, r::Ray)
    tmin = (b.min[1] - r.origin[1]) / r.direction[1]
    tmax = (b.max[1] - r.origin[1]) / r.direction[1]
    isnan(tmin) && (tmin = 0f0;)
    isnan(tmax) && (tmax = 0f0;)
    if tmin > tmax
        tmin, tmax = tmax, tmin
    end

    tymin = (b.min[2] - r.origin[2]) / r.direction[2]
    tymax = (b.max[2] - r.origin[2]) / r.direction[2]
    isnan(tymin) && (tymin = 0f0;)
    isnan(tymax) && (tymax = 0f0;)
    if tymin > tymax
        tymin, tymax = tymax, tymin
    end
    (tmin > tymax || tymin > tmax) && return (Inf32, Inf32)

    tymin > tmin && (tmin = tymin;)
    tymax < tmax && (tmax = tymax;)

    tzmin = (b.min[3] - r.origin[3]) / r.direction[3]
    tzmax = (b.max[3] - r.origin[3]) / r.direction[3]
    isnan(tzmin) && (tzmin = 0f0;)
    isnan(tzmax) && (tzmax = 0f0;)
    if tzmin > tzmax
        tzmin, tzmax = tzmax, tzmin
    end
    (tmin > tzmax || tzmin > tmax) && return (Inf32, Inf32)

    tzmin > tmin && (tmin = tzmin;)
    tzmax < tmax && (tmax = tzmax;)

    tmin, tmax
end

@inline function Base.in(v, b::BBox)
    b.min[1] ≤ v[1] ≤ b.max[1] &&
    b.min[2] ≤ v[2] ≤ b.max[2] &&
    b.min[3] ≤ v[3] ≤ b.max[3]
end

@inline function Base.in(q::BBox, b::BBox)
    q.min ∈ b && q.max ∈ b
end
