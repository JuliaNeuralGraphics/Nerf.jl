struct Envmap{D <: AbstractArray{Float32, 3}}
    data::D
    resolution::SVector{2, Int32}
end

function Envmap(backend; width::Int, height::Int)
    data = KernelAbstractions.zeros(backend, Float32, (3, width, height))
    Envmap(data, SVector{2, Int32}(width, height))
end

init(env::Envmap) = (env.data,)

function direction_to_spherical(d)
    cosθ = min(1f0, max(-1f0, d[3]))
    θ = acos(cosθ)
    ϕ = atan(d[2], d[1])
    return θ, ϕ
end

function direction_to_spherical_norm(d)
    θ, ϕ = direction_to_spherical(d)
    θ /= π
    ϕ = ϕ / (2f0 * π) + 0.5f0
    return θ, ϕ
end

# TODO @inbounds

# envmap eltype is SVec{3, Float32}
function read_envmap(
    envmap, envmap_resolution::SVector{2, Int32}, direction::SVector{3, Float32},
)
    θ, ϕ = direction_to_spherical_norm(direction)
    ewidth, eheight = envmap_resolution
    envmap_float = (ϕ * (ewidth - Int32(1)), θ * (eheight - Int32(1)))
    texel = floor.(Int32, envmap_float)
    ω = envmap_float .- texel

    @inline function read_val(pos)
        px, py = pos
        if px < 0
            px += ewidth
        elseif px ≥ ewidth
            px -= ewidth
        end
        py = max(0, min(py, eheight - Int32(1)))
        return envmap[px + Int32(1), py + Int32(1)]
    end

    ((1f0 - ω[1]) * (1f0 - ω[2])) * read_val(texel) +
    (ω[1] * (1f0 - ω[2]))         * read_val((texel[1] + Int32(1), texel[2])) +
    ((1f0 - ω[1]) * ω[2])         * read_val((texel[1], texel[2] + Int32(1))) +
    (ω[1] * ω[2])                 * read_val((texel[1] + Int32(1), texel[2] + Int32(1)))
end

function deposit_envmap_grad!(
    ∇, Δ::SVector{3, Float32},
    envmap_resolution::SVector{2, Int32},
    direction::SVector{3, Float32},
)
    θ, ϕ = direction_to_spherical_norm(direction)
    ewidth, eheight = envmap_resolution
    envmap_float = (ϕ * (ewidth - Int32(1)), θ * (eheight - Int32(1)))
    texel = floor.(Int32, envmap_float)
    ω = envmap_float .- texel

    @inline function deposit_val(ω, pos)
        px, py = pos
        if px < 0
            px += ewidth
        elseif px ≥ ewidth
            px -= ewidth
        end
        py = max(0, min(py, eheight - Int32(1)))

        px += Int32(1)
        py += Int32(1)

        for i in 1:3 # TODO get n chennels from array
            @atomic ∇[i, px, py] += Δ[i] * ω
        end
    end

    deposit_val((1f0 - ω[1]) * (1f0 - ω[2]), texel)
    deposit_val(       ω[1]  * (1f0 - ω[2]), (texel[1] + Int32(1), texel[2]))
    deposit_val((1f0 - ω[1]) *        ω[2],  (texel[1],            texel[2] + Int32(1)))
    deposit_val(       ω[1]  *        ω[2],  (texel[1] + Int32(1), texel[2] + Int32(1)))
    return
end
