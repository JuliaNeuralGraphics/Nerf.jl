Base.@kwdef mutable struct Adam{T}
    μ::Vector{T}
    ν::Vector{T}
    current_step::UInt32 = UInt32(0)

    # Hyperparameters.
    lr::Float32 = 1f-2
    β1::Float32 = 0.9f0
    β2::Float32 = 0.999f0
    ϵ::Float32 = 1f-8
end

KernelAbstractions.get_backend(opt::Adam) = get_backend(first(opt.μ))

function Adam(Backend, θ; kwargs...)
    μ, ν = [], [] # TODO unstable
    _add_moments!(μ, ν, θ, Backend)
    Adam(; μ, ν, kwargs...)
end

function _add_moments!(μ, ν, θ::T, Backend) where T <: Union{Tuple, NamedTuple}
    foreach(θᵢ -> _add_moments!(μ, ν, θᵢ, Backend), θ)
end

function _add_moments!(μ, ν, θ, Backend)
    push!(μ, KernelAbstractions.zeros(Backend, Float32, length(θ)))
    push!(ν, KernelAbstractions.zeros(Backend, Float32, length(θ)))
end

function reset!(opt::Adam)
    fill!.(opt.μ, 0f0)
    fill!.(opt.ν, 0f0)
    opt.current_step = 0x0
end

"""
    step!(opt::Adam, θ, ∇; dispose::Bool = true)

Apply update rule to parameters `θ` with gradients `∇`.

# Arguments:

- `dispose::Bool`: Free memory taken by gradients `∇` after update.
"""
function step!(opt::Adam, θ, ∇; dispose::Bool)
    length(θ) == length(∇) || error(
        "Number of parameters must be the same as the number of gradients, " *
        "but is instead `$(length(θ))` vs `$(length(∇))`.")

    opt.current_step += 0x1
    _step!(opt, θ, ∇, 1; dispose)
    return
end

function _step!(opt::Adam, θ::T, ∇::G, i; dispose::Bool) where {
    T <: Union{Tuple, NamedTuple}, G <: Union{Tuple, NamedTuple},
}
    for (θᵢ, ∇ᵢ) in zip(θ, ∇)
        i = _step!(opt, θᵢ, ∇ᵢ, i; dispose)
    end
    i
end

function _step!(opt::Adam, θ::T, ∇::T, i; dispose::Bool) where T <: AbstractArray
    # @assert !any(isnan.(θ)) "NaN parameters of size $(size(θ))"
    # @assert !any(isnan.(∇)) "NaN parameters of size $(size(∇))"
    size(θ) == size(∇) || error(
        "Shape of parameters and gradients must be the same, " *
        "but is instead `$(size(θ))` vs `$(size(∇))`.")
    adam_step_kernel!(get_backend(opt))(
        opt.μ[i], opt.ν[i], θ, ∇, Float32(opt.current_step),
        opt.lr, opt.β1, opt.β2, opt.ϵ; ndrange=length(θ))

    dispose && unsafe_free!(∇)

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

