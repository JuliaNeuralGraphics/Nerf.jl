function linear_to_srgb(x)
    ifelse(
        x ≤ 0.0031308f0,
        12.92f0 * x,
        1.055f0 * max(1f-5, x)^inv(2.4f0) - 0.055f0)
end

"""
Clamp `x` to `[0, 1]` range allowing gradients to push `x` inside the bounds
on its own.
"""
function leaky_clamp01(x)
    δ = @ignore_derivatives(clamp.(x, 0f0, 1f0) .- x)
    x .+ δ
end

function safe_norm(x; dims)
    sqrt.(sum(abs2, x; dims) .+ eps(Float32))
end

function safe_norm_squared(x; dims)
    sum(abs2, x; dims)
end

function safe_normalize(x; dims)
    x ./ safe_norm(x; dims)
end

"""
    reflect(directions, normals)

Reflect `directions` about `normals`.

Reflection equation: `ωᵣ = d + 2(ωₒ⋅n)n`.

Where `ωᵣ` - reflected vector, `n` - normal vector,
`ωₒ = -d` and `d` is `directions`.

# Arguments:

- `directions`: Unit vectors pointing towards the `normals`.
    Meaning `ωₒ = -directions` are unit vectors, pointing from points in space
    (towards the camera, for example), and `normals` are normal vectors
    at these points. Shape is `(3, N)`.
- `normals`: Normal vectors at points in space for respective `directions`.
    Shape is `(3, N)`.

# Returns:

Reflected directions.

!!! note
    It does not check whether `normals` or `directions` are unit vectors.
"""
function reflect(directions, normals)
    2f0 .* sum(normals .* directions; dims=1) .* normals .- directions
end
