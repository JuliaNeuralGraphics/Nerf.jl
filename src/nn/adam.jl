Base.@kwdef mutable struct Adam{D, T}
    dev::D
    μ::Vector{T}
    ν::Vector{T}
    current_step::UInt32 = UInt32(0)

    # Hyperparameters.
    lr::Float32 = 1f-3
    β1::Float32 = 0.9f0
    β2::Float32 = 0.999f0
    ϵ::Float32 = 1f-8
end

function Adam(dev, θ; kwargs...)
    D = type_from_device(dev)
    μ, ν = D{Float32, 1}[], D{Float32, 1}[]
    _add_moments!(μ, ν, θ, dev)
    Adam(; dev, μ, ν, kwargs...)
end

function _add_moments!(μ, ν, θ::T, dev) where T <: Union{Tuple, NamedTuple}
    foreach(θᵢ -> _add_moments!(μ, ν, θᵢ, dev), θ)
end

function _add_moments!(μ, ν, θ, dev)
    push!(μ, zeros(dev, Float32, length(θ)))
    push!(ν, zeros(dev, Float32, length(θ)))
end

function reset!(opt::Adam)
    fill!.(opt.μ, 0f0)
    fill!.(opt.ν, 0f0)
    opt.current_step = 0x0
end

function step!(opt::Adam, θ, ∇)
    length(θ) == length(∇) || error(
        "Number of parameters must be the same as the number of gradients, " *
        "but is instead `$(length(θ))` vs `$(length(∇))`.")

    opt.current_step += 0x1
    _step!(opt, θ, ∇, 1)
    nothing
end

function _step!(opt::Adam, θ::T, ∇::G, i) where {
    T <: Union{Tuple, NamedTuple}, G <: Union{Tuple, NamedTuple},
}
    for (θᵢ, ∇ᵢ) in zip(θ, ∇)
        i = _step!(opt, θᵢ, ∇ᵢ, i)
    end
    i
end

function _step!(opt::Adam, θ::T, ∇::T, i) where T <: AbstractArray
    @assert !any(isnan.(θ)) "NaN parameters of size $(size(θ))"
    @assert !any(isnan.(∇)) "NaN parameters of size $(size(∇))"
    size(θ) == size(∇) || error(
        "Shape of parameters and gradients must be the same, " *
        "but is instead `$(size(θ))` vs `$(size(∇))`.")
    wait(adam_step_kernel!(opt.dev)(
        opt.μ[i], opt.ν[i], θ, ∇, Float32(opt.current_step),
        opt.lr, opt.β1, opt.β2, opt.ϵ; ndrange=length(θ)))
    i + 1
end

@kernel function adam_step_kernel!(
    μ, ν, Θ, @Const(∇), current_step::Float32, lr::Float32,
    β1::Float32, β2::Float32, ϵ::Float32,
)
    i = @index(Global)
    ∇ᵢ = ∇[i]
    ωᵢ = Θ[i]

    ∇ᵢ² = ∇ᵢ * ∇ᵢ
    μᵢ = μ[i] = β1 * μ[i] + (1f0 - β1) * ∇ᵢ
    νᵢ = ν[i] = β2 * ν[i] + (1f0 - β2) * ∇ᵢ²

    # Debiasing.
    lr *= √(1f0 - β2^current_step) / (1f0 - β1^current_step)
    Θ[i] = ωᵢ - (lr * μᵢ) / (√νᵢ + ϵ)
end

