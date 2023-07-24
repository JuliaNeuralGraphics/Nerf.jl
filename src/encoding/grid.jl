include("grid_utils.jl")
include("grid_kernels.jl")

struct GridEncoding{O}
    offset_table::O
    n_dims::UInt32
    n_features::UInt32
    n_levels::UInt32
    n_params::UInt32
    base_resolution::UInt32
    scale::Float32
end

function GridEncoding(
    Backend; n_levels::Int = 16, scale::Float32 = 1.5f0,
    base_resolution::Int = 16, n_features::Int = 2, hashmap_size::Int = 19,
)
    @assert n_levels < 34 "Too many levels for the offset table."
    n_dims = 3
    max_params = typemax(UInt32) ÷ 0x2
    hashmap_params = one(UInt32) << hashmap_size

    offset_table = Vector{UInt32}(undef, n_levels + 1)
    offset = zero(UInt32)

    log_scale = log2(scale)
    for level in 1:n_levels
        level_scale::Float32 = compute_scale(
            UInt32(level), log_scale, UInt32(base_resolution))
        resolution = ceil(level_scale) + 1

        level_params::UInt32 = min(resolution^n_dims, max_params)
        level_params = next_multiple(level_params, 0x8) # align to 8
        level_params = min(level_params, hashmap_params) # maybe clamp

        offset_table[level] = offset
        offset += level_params
    end

    offset_table[end] = offset
    n_params = offset * n_features
    GridEncoding(
        adapt(Backend, offset_table), UInt32(n_dims), UInt32(n_features),
        UInt32(n_levels), UInt32(n_params), UInt32(base_resolution), scale)
end

KernelAbstractions.get_backend(ge::GridEncoding) = get_backend(ge.offset_table)

function _get_kernel_params(ge)
    NPD = Val{Int64(ge.n_dims)}()
    NFPL = Val{Int64(ge.n_features)}()
    NPD, NFPL
end

function init(ge::GridEncoding)
    shape = Int64.((ge.n_features, ge.n_params ÷ ge.n_features))
    adapt(get_backend(ge), rand(Float32, shape) .* 2f-4 .- 1f-4)
end

function reset!(::GridEncoding, θ)
    copy!(θ, rand(Float32, size(θ)) .* 2f-4 .- 1f-4)
end

function get_output_shape(ge::GridEncoding)
    Int.((ge.n_features, ge.n_levels))
end

function (ge::GridEncoding)(x, θ)
    Backend = get_backend(ge)
    n = size(x, 2)
    y = allocate(Backend, Float32, (get_output_shape(ge)..., n))
    NPD, NFPL = _get_kernel_params(ge)
    @device_code dir="./devcode-post" grid_kernel!(Backend)(
        y, nothing, x, θ, ge.offset_table, NPD, NFPL,
        ge.base_resolution, log2(ge.scale); ndrange=(n, ge.n_levels))
    exit()
    reshape(y, :, n)
end

function (ge::GridEncoding)(x, θ, ::Val{:IG})
    Backend = get_backend(ge)
    n = size(x, 2)
    y = allocate(Backend, Float32, (get_output_shape(ge)..., n))
    ∂y∂x_shape = Int64.((ge.n_dims, get_output_shape(ge)..., n))
    ∂y∂x = KernelAbstractions.zeros(Backend, Float32, ∂y∂x_shape)

    NPD, NFPL = _get_kernel_params(ge)
    grid_kernel!(Backend)(
        y, ∂y∂x, x, θ, ge.offset_table,
        NPD, NFPL, ge.base_resolution,
        log2(ge.scale); ndrange=(n, ge.n_levels))
    reshape(y, :, n), ∂y∂x
end

function ∇(ge::GridEncoding, ∂f∂y, x, θ)
    Backend = get_backend(ge)
    n = size(x, 2)
    NPD, NFPL = _get_kernel_params(ge)
    ∂grid = KernelAbstractions.zeros(Backend, Float32, size(θ))
    ∇grid_kernel!(Backend)(
        ∂grid, ∂f∂y, x, ge.offset_table, NPD, NFPL, ge.base_resolution,
        log2(ge.scale); ndrange=(n, ge.n_levels))
    ∂grid
end

function ∇grid_input(ge::GridEncoding, ∂L∂y, ∂y∂x)
    Backend = get_backend(ge)
    n = size(∂y∂x, 4)
    NPD, NFPL = _get_kernel_params(ge)
    L = Val{ge.n_levels}()
    ∂L∂x = allocate(Backend, Float32, Int64.((ge.n_dims, n)))
    ∇grid_kernel_input!(Backend)(∂L∂x, ∂L∂y, ∂y∂x, NPD, NFPL, L; ndrange=n)
    ∂L∂x
end

function ChainRulesCore.rrule(ge::GridEncoding, x, θ)
    n = size(x, 2)
    function encode_pullback(Δ)
        Δ2 = reshape(unthunk(Δ), (get_output_shape(ge)..., n))
        Tangent{GridEncoding}(), NoTangent(), ∇(ge, Δ2, x, θ)
    end
    ge(x, θ), encode_pullback
end

function ChainRulesCore.rrule(ge::GridEncoding, x, θ, ::Val{:IG})
    n = size(x, 2)
    y, ∂y∂x = ge(x, θ, Val{:IG}())
    function encode_pullback(Δ)
        Δ2 = reshape(unthunk(Δ), (get_output_shape(ge)..., n))
        (
            Tangent{GridEncoding}(), @thunk(∇grid_input(ge, Δ2, ∂y∂x)),
            @thunk(∇(ge, Δ2, x, θ)), NoTangent())
    end
    y, encode_pullback
end
