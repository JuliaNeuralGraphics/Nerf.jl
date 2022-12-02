module Nerf

export GridEncoding, spherical_harmonics

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
include("sampler.jl")
include("encoding/grid.jl")
include("encoding/spherical_harmonics.jl")
include("nn/nn.jl")
include("models/basic.jl")
include("loss.jl")

@info "Backend: $BACKEND"
@info "Device: $DEVICE"

function main()
    dev = DEVICE

    config_file = "/home/pxl-th/code/INGP.jl/data/raccoon_sofa2/transforms.json"
    dataset = Dataset(dev; config_file)
    bbox = get_bbox(dataset)
    occupancy = OccupancyGrid(dev; n_levels=get_n_levels(dataset))
    cone = Cone(;
        angle=get_cone_angle(dataset), steps=1024,
        resolution=get_resolution(occupancy),
        n_levels=get_n_levels(occupancy))

    mark_invisible_regions!(
        occupancy; intrinsics=dataset.intrinsics,
        rotations=dataset.rotations, translations=dataset.translations)

    update!(occupancy; bbox, step=1) do points, indices
        ones(dev, Float32, (length(indices),))
    end

    bundle = RayBundle(
        occupancy, cone, bbox, dataset.rotations,
        dataset.translations, dataset.intrinsics; n_rays=1 << 10)
    @show length(bundle)
    samples = materialize(bundle, occupancy, cone, bbox, dataset.translations)
    @show length(samples)

    raw_points = reshape(reinterpret(Float32, samples.points), 3, :)
    raw_directions = reshape(reinterpret(Float32, samples.directions), 3, :)
    model = BasicModel(BasicField(dev))
    rgba = model(raw_points, raw_directions)

    photometric_loss(rgba, bundle, samples, dataset.images)

    nothing
end

end
