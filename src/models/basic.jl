struct BasicField{G, D, C}
    grid_encoding::G
    density_mlp::D
    color_mlp::C
end

function BasicField(dev; backbone_size::Int = 16, grid_kwargs...)
    ge = GridEncoding(dev; n_dims=3, grid_kwargs...)
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

get_device(b::BasicField) = get_device(b.grid_encoding)

function init(b::BasicField)
    dev = get_device(b)
    θge = init(b.grid_encoding)
    θdensity = map(l -> to_device(dev, l), init(b.density_mlp))
    θcolor = map(l -> to_device(dev, l), init(b.color_mlp))
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

function (b::BasicField)(
    points::P, directions::D, θ; mode = Val{:NOIG}(),
) where {
    P <: AbstractMatrix{Float32}, D <: AbstractMatrix{Float32},
}
    _check_mode(mode)
    if mode == Val{:NOIG}()
        encoded_points = b.grid_encoding(points, θ.θge)
    elseif mode == Val{:IG}()
        encoded_points = b.grid_encoding(points, θ.θge, mode)
    end
    encoded_directions = spherical_harmonics(directions)
    backbone = b.density_mlp(encoded_points, θ.θdensity)
    rgb = b.color_mlp(vcat(backbone, encoded_directions), θ.θcolor)
    vcat(rgb, backbone[[1], :])
end

function density(b::BasicField, points::P, θ; mode = Val{:NOIG}()) where P <: AbstractMatrix{Float32}
    _check_mode(mode)
    if mode == Val{:NOIG}()
        encoded_points = b.grid_encoding(points, θ.θge)
    elseif mode == Val{:IG}()
        encoded_points = b.grid_encoding(points, θ.θge, mode)
    end
    b.density_mlp(encoded_points, θ.θdensity)[1, :]
end

function batched_density(b::BasicField, points::P, θ; batch::Int) where P <: AbstractMatrix{Float32}
    n = size(points, 2)
    n_iterations = ceil(Int, n / batch)

    σ = similar(get_device(b), Float32, n)
    for i in 1:n_iterations
        i_start = (i - 1) * batch + 1
        i_end = min(n, i * batch)
        σ[i_start:i_end] .= density(b, @view(points[:, i_start:i_end]), θ)
    end
    σ
end

struct BasicModel{F, P}
    field::F
    θ::P
    optimizer::Adam
end

function BasicModel(field::BasicField)
    θ = init(field)
    BasicModel(field, θ, Adam(get_device(field), θ; lr=1f-2))
end

get_device(m::BasicModel) = get_device(m.field)

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
    Y, back = Zygote.pullback(points) do p
        density(m.field, p, m.θ; mode=Val{:IG}())
    end
    ∇ = back(ones(get_device(m), Float32, size(Y)))[1]
    safe_normalize(-∇; dims=1)
end

function step!(
    m::BasicModel, points::P, directions::D;
    bundle::RayBundle, samples::RaySamples, images::Images,
) where {
    P <: AbstractMatrix{Float32}, D <: AbstractMatrix{Float32},
}
    l = 0f0
    ∇ = Zygote.gradient(m.θ) do θ
        rgba = m.field(points, directions, θ)
        loss = photometric_loss(rgba; bundle, samples, images)
        l = loss
        loss
    end
    step!(m.optimizer, m.θ, ∇[1])
    l
end
