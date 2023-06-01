module Nerf

using Adapt
using BSON
using ChainRulesCore
using FileIO
using ImageCore
using ImageTransformations
using JSON
using KernelAbstractions
using KernelAbstractions: @atomic, unsafe_free!
using LinearAlgebra
using Preferences
using Quaternions
using Rotations
using StaticArrays
using Statistics
using Zygote

# TODO rand on device

include("kautils.jl")

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

include("rng/pcg32.jl")
include("rng/ld.jl")
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
include("renderer/renderer.jl")
include("models/basic.jl")
include("marching_cubes/marching_cubes.jl")
include("marching_tetrahedra/marching_tetrahedra.jl")

function sync_free!(Backend, args...)
    unsafe_free!.(args)
end

@info "[Nerf.jl] Backend: $BACKEND_NAME"
@info "[Nerf.jl] Device: $Backend"

# TODO
# - use Flux for models
# - non-allocating renderer (except NN part)
# - get rid of sync_free

function main()
    config_file = joinpath(pkgdir(Nerf), "data", "raccoon_sofa2", "transforms.json")
    dataset = Dataset(Backend; config_file)

    model = BasicModel(BasicField(Backend))
    trainer = Trainer(model, dataset; n_rays=512)

    camera = Camera(MMatrix{3, 4, Float32}(I), dataset.intrinsics)
    renderer = Renderer(Backend, camera, trainer.bbox, trainer.cone)

    for i in 1:20_000
        loss = step!(trainer)
        @show i, loss

        i % 250 == 0 || continue

        pose_idx = clamp(round(Int, rand() * length(dataset)), 1, length(dataset))
        set_projection!(camera, get_pose(dataset, pose_idx)...)
        render!(renderer, trainer.occupancy, trainer.bbox) do points, directions
            model(points, directions)
        end
        save("image-$i.png", RGB.(to_image(renderer.buffer)))
    end
    nothing
end

# Benchmark utils.

function trainer_benchmark(trainer::Trainer, n::Int)
    for i in 1:n
        Core.println(i)
        step!(trainer)
    end
end

function render_benchmark(renderer::Renderer, trainer::Trainer, n::Int)
    for i in 1:n
        Core.println(i)
        render!(renderer, trainer.occupancy, trainer.bbox) do points, directions
            trainer.model(points, directions)
        end
    end
end

function benchmark()
    config_file = joinpath(pkgdir(Nerf), "data", "raccoon_sofa2", "transforms.json")
    dataset = Dataset(Backend; config_file)
    model = BasicModel(BasicField(Backend))
    trainer = Trainer(model, dataset; n_rays=512)

    # GC.enable_logging(true)

    Core.println("Trainer benchmark")

    @time trainer_benchmark(trainer, 10)
    @time trainer_benchmark(trainer, 1000)

    return nothing

    camera = Camera(MMatrix{3, 4, Float32}(I), dataset.intrinsics)
    set_projection!(camera, get_pose(dataset, 1)...)
    renderer = Renderer(Backend, camera, trainer.bbox, trainer.cone)

    Core.println("Renderer benchmark")

    @time render_benchmark(renderer, trainer, 2)
    @time render_benchmark(renderer, trainer, 10)

    nothing
end

end
