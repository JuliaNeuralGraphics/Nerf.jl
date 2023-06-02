struct BasicField{G <: GridEncoding, D, C}
    grid_encoding::G
    density_mlp::D
    color_mlp::C
end
Flux.@functor BasicField

function BasicField(;
    backbone_size::Int = 16, mlp_hidden_size::Int = 64, grid_kwargs...,
)
    ge = GridEncoding(; grid_kwargs...)
    density_mlp_input = prod(get_output_shape(ge))
    color_mlp_input = 16 + backbone_size # 16 for spherical harmonics
    density_mlp = Chain(
        Dense(density_mlp_input => mlp_hidden_size, relu),
        Dense(mlp_hidden_size => backbone_size))
    color_mlp = Chain(
        Dense(color_mlp_input => mlp_hidden_size, relu),
        Dense(mlp_hidden_size => mlp_hidden_size, relu),
        Dense(mlp_hidden_size => 3, sigmoid))
    BasicField(ge, density_mlp, color_mlp)
end

KernelAbstractions.get_backend(b::BasicField) = get_backend(b.grid_encoding)

function reset!(b::BasicField)
    reset!(b.grid_encoding)
    # TODO reset chain
    reset!(b.density_mlp)
    reset!(b.color_mlp)
end

function _check_mode(mode)
    valid = mode == Val{:NOIG}() || mode == Val{:IG}()
    valid || throw(ArgumentError(
        "`mode`=`$mode` must be either `Val{:NOIG}()` or `Val{:IG}()`."))
end

function (b::BasicField)(points::P, directions::D, mode = Val{:NOIG}()) where {
    P <: AbstractMatrix{Float32}, D <: AbstractMatrix{Float32},
}
    _check_mode(mode)
    if mode == Val{:NOIG}()
        encoded_points = b.grid_encoding(points)
    else
        encoded_points = b.grid_encoding(points, mode)
    end
    encoded_directions = spherical_harmonics(directions)
    backbone = b.density_mlp(encoded_points)
    rgb = b.color_mlp(vcat(backbone, encoded_directions))
    vcat(rgb, reshape(backbone[1, :], 1, :))
end

function density(b::BasicField, points::P, mode = Val{:NOIG}()) where P <: AbstractMatrix{Float32}
    _check_mode(mode)
    if mode == Val{:NOIG}()
        encoded_points = b.grid_encoding(points)
    else
        encoded_points = b.grid_encoding(points, mode)
    end
    b.density_mlp(encoded_points)[1, :]
end

function _dealloc_density(b::BasicField, points::P) where P <: AbstractMatrix{Float32}
    encoded_points = b.grid_encoding(points)
    tmp = b.density_mlp.layers[1](encoded_points)
    unsafe_free!(encoded_points)
    dst = b.density_mlp.layers[2](tmp)
    unsafe_free!(tmp)
    y = dst[1, :]
    unsafe_free!(dst)
    return y
end

function batched_density(b::BasicField, points::P; batch::Int) where P <: AbstractMatrix{Float32}
    n = size(points, 2)
    n_iterations = ceil(Int, n / batch)

    kab = get_backend(b)
    σ = allocate(kab, Float32, (n,))
    for i in 1:n_iterations
        i_start = (i - 1) * batch + 1
        i_end = min(n, i * batch)

        batch_σ = _dealloc_density(b, @view(points[:, i_start:i_end]))
        KernelAbstractions.synchronize(kab)

        σ[i_start:i_end] .= batch_σ
        unsafe_free!(batch_σ)
    end
    σ
end

mutable struct BasicModel{F, O}
    field::F
    optimizer::O
end
Flux.@functor BasicModel

function BasicModel(field::BasicField)
    BasicModel(field, Adam(1f-2))
end

KernelAbstractions.get_backend(m::BasicModel) = get_backend(m.field)

# TODO simplify types
function batched_density(m::BasicModel, points::P; batch::Int) where P <: AbstractMatrix
    batched_density(m.field, points; batch)
end

function reset!(m::BasicModel)
    reset!(m.field, m.θ)
    m.optimizer = Adam(1f-2)
end

function (m::BasicModel)(points::P, directions::D) where {
    P <: AbstractMatrix{Float32}, D <: AbstractMatrix{Float32},
}
    m.field(points, directions)
end

function ∇normals(m::BasicModel, points::P) where P <: AbstractMatrix{Float32}
    kab = get_backend(m)
    Y, back = Zygote.pullback(points) do p
        density(m.field, p, Val{:IG}())
    end
    KernelAbstractions.synchronize(kab)
    GC.gc(false)
    KernelAbstractions.synchronize(kab)

    Δ = KernelAbstractions.ones(Backend, Float32, size(Y))
    ∇ = back(Δ)[1]
    n⃗ = safe_normalize(-∇; dims=1) # TODO in-place normalization kernel with negation

    KernelAbstractions.synchronize(kab)
    unsafe_free!.((Δ, ∇))
    GC.gc(false)
    KernelAbstractions.synchronize(kab)
    n⃗
end

function step!(
    m::BasicModel, points::P, directions::D;
    bundle::RayBundle, samples::RaySamples, images::Images,
    n_rays::Int, rng_state::UInt64,
) where {P <: AbstractMatrix{Float32}, D <: AbstractMatrix{Float32}}
    state = Flux.setup(m.optimizer, m.field) # TODO store state in the model
    loss, ∇ = Zygote.withgradient(m.field) do nn
        rgba = nn(points, directions)
        photometric_loss(rgba; bundle, samples, images, n_rays, rng_state)
    end
    kab = KernelAbstractions.get_backend(m)
    KernelAbstractions.synchronize(kab)
    # Since we can't manually free memory during Zygote AD.
    # Attempt to free it by performing quick GC.
    GC.gc(false)
    KernelAbstractions.synchronize(kab)

    Flux.Optimise.update!(state, m.field, ∇[1]) # TODO replace model from struct?
    KernelAbstractions.synchronize(kab)

    loss
end
