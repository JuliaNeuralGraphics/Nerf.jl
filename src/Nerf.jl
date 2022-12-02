module Nerf

export GridEncoding, spherical_harmonics
export BBox, Ray

using Adapt
using ChainRulesCore
using FileIO
using ImageCore
using ImageTransformations
using JSON
using KAUtils
using KernelAbstractions
using KernelAbstractions: @atomic
using LinearAlgebra
using StaticArrays
using Statistics
using Zygote

const BACKEND = KAUtils.BACKEND
const DEVICE = KAUtils.DEVICE

@static if BACKEND == "CUDA"
    using CUDA
    using CUDAKernels
    CUDA.allowscalar(false)
elseif BACKEND == "ROC"
    using AMDGPU
    using ROCKernels
    AMDGPU.allowscalar(false)
end

struct Ray
    origin::SVector{3, Float32}
    direction::SVector{3, Float32}
end

@inline function (r::Ray)(t)
    r.origin .+ t .* r.direction
end

struct Cone
    angle::Float32
    steps::UInt32
    min_stepsize::Float32
    max_stepsize::Float32
end

function Cone(; angle::Float32, steps::Int, resolution::Int, n_levels::Int)
    max_level_scale = UInt32(1) << (n_levels - 0x1)
    min_stepsize::Float32 = sqrt(3f0) / steps
    max_stepsize::Float32 = max_level_scale * min_stepsize * steps / resolution
    Cone(angle, steps, min_stepsize, max_stepsize)
end

@inline function delta(cone::Cone, t::Float32)
    clamp(t * cone.angle, cone.min_stepsize, cone.max_stepsize)
end

@inline function level_from_point(
    point::SVector{3, Float32}, n_levels::UInt32,
)::UInt32
    _, exponent = frexp(maximum(abs.(point .- 0.5f0)))
    min(n_levels - 0x1, max(0x0, exponent + 0x1))
end

@inline function level_from_delta(
    δ::Float32, point::SVector{3, Float32},
    n_levels::UInt32, resolution::UInt32,
)
    level = level_from_point(point, n_levels)
    δ *= 2f0 * resolution
    δ < 1f0 && return level

    _, exponent::UInt32 = frexp(δ)
    min(n_levels - 0x1, max(exponent, level))
end

include("bbox.jl")
include("data/dataset.jl")
include("ray.jl")
include("acceleration/occupancy.jl")
include("encoding/grid.jl")
include("encoding/spherical_harmonics.jl")
include("nn/nn.jl")
include("sampler.jl")
include("loss.jl")
include("trainer.jl")
include("models/basic.jl")

@info "Backend: $BACKEND"
@info "Device: $DEVICE"

function main()
    dev = DEVICE

    config_file = "/home/pxl-th/code/INGP.jl/data/raccoon_sofa2/transforms.json"
    dataset = Dataset(dev; config_file)
    model = BasicModel(BasicField(dev))
    trainer = Trainer(model, dataset)
    for i in 1:1000
        l = step!(trainer)
        if i % 10 == 0
            @show i, l
        end
    end

    nothing
end

end
