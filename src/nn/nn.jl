include("common.jl")
include("adam.jl")

struct Dense{T, F}
    activation::F
    in_channels::Int64
    out_channels::Int64

    function Dense{T}(
        mapping::Pair{Int64, Int64}, activation::F = identity,
    ) where {T <: Union{Float16, Float32}, F}
        new{T, F}(activation, first(mapping), last(mapping))
    end

    function Dense(
        mapping::Pair{Int64, Int64}, activation::F = identity,
    ) where F
        new{Float32, F}(activation, first(mapping), last(mapping))
    end
end

function (d::Dense{T, typeof(identity)})(x, θ) where T
    θ * x
end

function (d::Dense{T, F})(x, θ) where {T, F}
    d.activation.(θ * x)
end

function eager_deallocation_eval(d::Dense{T, typeof(identity)}, x, θ) where T
    θ * x
end

function eager_deallocation_eval(d::Dense{T, F}, x, θ) where {T, F}
    y1 = θ * x
    y2 = d.activation.(y1)
    unsafe_free!(y1)
    return y2
end

get_precision(::Dense{T, F}) where {T, F} = T

function init(d::Dense)
    glorot_uniform((d.out_channels, d.in_channels), get_precision(d))
end

function reset!(::Dense, θ)
    copy!(θ, glorot_uniform(size(θ), eltype(θ)))
end

struct Chain{L}
    layers::L
    Chain(layers...) = new{typeof(layers)}(layers)
end

# TODO make inferrable at length > 3
# TODO init on device
function init(c::Chain)
    recursive_init((), first(c.layers), Base.tail(c.layers))
end

function recursive_init(θ, l, c::Tuple)
    recursive_init((θ..., init(l)), first(c), Base.tail(c))
end
function recursive_init(θ, l, ::Tuple{})
    (θ..., init(l))
end

function reset!(c::Chain, θ)
    foreach(l -> reset!(l[1], l[2]), zip(c.layers, θ))
end

function (c::Chain)(x, θ)
    recursive_apply(
        x, first(c.layers), Base.tail(c.layers), first(θ), Base.tail(θ))
end

function recursive_apply(x, l, c::Tuple, θₗ, θ)
    recursive_apply(l(x, θₗ), first(c), Base.tail(c), first(θ), Base.tail(θ))
end
function recursive_apply(x, l, ::Tuple{}, θₗ, ::Tuple{})
    l(x, θₗ)
end

function eager_deallocation_eval(c::Chain, x, θ)
    recursive_apply!(
        x, first(c.layers), Base.tail(c.layers), first(θ), Base.tail(θ);
        free_input=false) # Do not free input, since it might be neede elsewhere.
end

function recursive_apply!(x, l, c::Tuple, θₗ, θ; free_input::Bool)
    y = eager_deallocation_eval(l, x, θₗ)
    if free_input
        BACKEND == "ROC" && AMDGPU.wait!(y)
        unsafe_free!(x)
    end
    recursive_apply!(
        y, first(c), Base.tail(c), first(θ), Base.tail(θ);
        free_input=true) # Free all intermediate inputs.
end
function recursive_apply!(x, l, ::Tuple{}, θₗ, ::Tuple{}; free_input::Bool)
    y = eager_deallocation_eval(l, x, θₗ)
    if free_input
        BACKEND == "ROC" && AMDGPU.wait!(y)
        unsafe_free!(x)
    end
    return y
end

function glorot_uniform(dims, ::Type{T} = Float32; gain = one(T)) where T
    scale::T = gain * √(24f0 / sum(dims))
    (rand(T, dims) .- T(0.5f0)) .* scale
end

function relu(x::T) where T
    ifelse(x < zero(T), zero(T), x)
end

function softplus(x::T) where T
    log1p(exp(-abs(x))) + relu(x)
end

function sigmoid(x::T) where T
    t = exp(-abs(x))
    ifelse(x ≥ zero(T), inv(one(T) + t), t / (one(T) + t))
end
