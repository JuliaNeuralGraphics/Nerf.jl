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
        Dense(64 => 3))
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

function (b::BasicField)(points, directions, θ; mode = Val{:NOIG}())
    # TODO check input dims
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

function density(b::BasicField, points, θ; mode = Val{:NOIG}())
    _check_mode(mode)
    if mode == Val{:NOIG}()
        encoded_points = b.grid_encoding(points, θ.θge)
    elseif mode == Val{:IG}()
        encoded_points = b.grid_encoding(points, θ.θge, mode)
    end
    b.density_mlp(encoded_points, θ.θdensity)[1, :]
end

function batched_density(b::BasicField, points, θ; batch::Int, mode = Val{:NOIG}())
    n = size(points, 2)
    n_iterations = ceil(Int, n / batch)

    σ = similar(get_device(b), Float32, n)
    for i in 1:n_iterations
        i_start = (i - 1) * batch + 1
        i_end = min(n, i * batch)
        σ[i_start:i_end] .= density(b, @view(points[:, i_start:i_end]), θ; mode)
    end
    σ
end
