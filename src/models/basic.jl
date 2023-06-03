struct BasicField{G <: GridEncoding, D, C}
    grid_encoding::G
    density_mlp::D
    color_mlp::C
end

function BasicField(Backend; backbone_size::Int = 16, grid_kwargs...)
    ge = GridEncoding(Backend; grid_kwargs...)
    density_mlp_input = prod(get_output_shape(ge))
    color_mlp_input = 16 + backbone_size # 16 for spherical harmonics
    density_mlp = Chain(
        Dense(density_mlp_input => 64, relu),
        Dense(64 => backbone_size))
    color_mlp = Chain(
        Dense(color_mlp_input => 64, relu),
        Dense(64 => 64, relu),
        Dense(64 => 3, sigmoid))
    BasicField(ge, density_mlp, color_mlp)
end

KernelAbstractions.get_backend(b::BasicField) = get_backend(b.grid_encoding)

function init(b::BasicField)
    Backend = get_backend(b)
    θge = init(b.grid_encoding)
    θdensity = map(l -> adapt(Backend, l), init(b.density_mlp))
    θcolor = map(l -> adapt(Backend, l), init(b.color_mlp))
    (; θge, θdensity, θcolor)
end

function reset!(b::BasicField, θ)
    reset!(b.grid_encoding, θ.θge)
    reset!(b.density_mlp, θ.θdensity)
    reset!(b.color_mlp, θ.θcolor)
end

function _check_mode(mode)
    valid = mode == Val{:NOIG}() || mode == Val{:IG}()
    valid || throw(ArgumentError(
        "`mode`=`$mode` must be either `Val{:NOIG}()` or `Val{:IG}()`."))
end

function (b::BasicField)(points::P, directions::D, θ, mode = Val{:NOIG}()) where {
    P <: AbstractMatrix{Float32}, D <: AbstractMatrix{Float32},
}
    _check_mode(mode)
    if mode == Val{:NOIG}()
        encoded_points = b.grid_encoding(points, θ.θge)
    else
        encoded_points = b.grid_encoding(points, θ.θge, mode)
    end
    encoded_directions = spherical_harmonics(directions)
    backbone = b.density_mlp(encoded_points, θ.θdensity)
    rgb = b.color_mlp(vcat(backbone, encoded_directions), θ.θcolor)
    vcat(rgb, reshape(backbone[1, :], 1, :))
end

function density(b::BasicField, points::P, θ, mode = Val{:NOIG}()) where P <: AbstractMatrix{Float32}
    _check_mode(mode)
    if mode == Val{:NOIG}()
        encoded_points = b.grid_encoding(points, θ.θge)
    else
        encoded_points = b.grid_encoding(points, θ.θge, mode)
    end
    b.density_mlp(encoded_points, θ.θdensity)[1, :]
end

function _dealloc_density(b::BasicField, points::P, θ) where P <: AbstractMatrix{Float32}
    Backend = get_backend(b)

    encoded_points = b.grid_encoding(points, θ.θge)
    tmp = b.density_mlp.layers[1](encoded_points, θ.θdensity[1])
    unsafe_free!(encoded_points)
    dst = b.density_mlp.layers[2](tmp, θ.θdensity[2])
    unsafe_free!(tmp)
    y = dst[1, :]
    unsafe_free!(dst)
    return y
end

function batched_density(b::BasicField, points::P, θ; batch::Int) where P <: AbstractMatrix{Float32}
    n = size(points, 2)
    n_iterations = ceil(Int, n / batch)

    Backend = get_backend(b)
    σ = allocate(Backend, Float32, (n,))
    for i in 1:n_iterations
        i_start = (i - 1) * batch + 1
        i_end = min(n, i * batch)

        batch_σ = _dealloc_density(b, @view(points[:, i_start:i_end]), θ)
        σ[i_start:i_end] .= batch_σ
        unsafe_free!(batch_σ)
    end
    σ
end

# TODO eager dealloc density function

struct BasicModel{F, P, O <: Adam}
    field::F
    θ::P
    optimizer::O
end

function BasicModel(field::BasicField)
    θ = init(field)
    BasicModel(field, θ, Adam(get_backend(field), θ; lr=1f-2))
end

KernelAbstractions.get_backend(m::BasicModel) = get_backend(m.field)

# TODO simplify types
function batched_density(m::BasicModel, points::P; batch::Int) where P <: AbstractMatrix
    batched_density(m.field, points, m.θ; batch)
end

function reset!(m::BasicModel)
    reset!(m.field, m.θ)
    reset!(m.optimizer)
end

function (m::BasicModel)(points::P, directions::D) where {
    P <: AbstractMatrix{Float32}, D <: AbstractMatrix{Float32},
}
    m.field(points, directions, m.θ)
end

function ∇normals(m::BasicModel, points::P) where P <: AbstractMatrix{Float32}
    Backend = get_backend(m)
    Y, back = Zygote.pullback(points) do p
        density(m.field, p, m.θ, Val{:IG}())
    end
    Δ = KernelAbstractions.ones(Backend, Float32, size(Y))
    ∇ = back(Δ)[1]
    n⃗ = safe_normalize(-∇; dims=1) # TODO in-place normalization kernel with negation
    unsafe_free!.((Δ, ∇))
    n⃗
end

function step!(
    m::BasicModel, points::P, directions::D;
    bundle::RayBundle, samples::RaySamples, images::Images,
    n_rays::Int, rng_state::UInt64,
) where {
    P <: AbstractMatrix{Float32}, D <: AbstractMatrix{Float32},
}
    loss::Float32 = 0f0
    loss, ∇ = Zygote.withgradient(m.θ) do θ
        rgba = m.field(points, directions, θ)
        photometric_loss(rgba; bundle, samples, images, n_rays, rng_state)
    end
    step!(m.optimizer, m.θ, ∇[1]; dispose=true)

    loss
end
