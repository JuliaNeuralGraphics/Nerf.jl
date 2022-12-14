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

include("pcg32.jl")
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

@info "Backend: $BACKEND"
@info "Device: $DEVICE"

# TODO contrain parametric types in struct
# TODO check that correct rngs are used between kernels
# TODO move rng_state into ray bundle?
# TODO lr scheduler

# TODO create test that reconstructs random image
# images = adapt(Array, dataset.images)
# width, height = size(images.data, 2), size(images.data, 3)
# for i in 1:size(images.data, 4)
#     raw_img = similar(CPU(), SVector{3, Float32}, (width, height))
#     for w in 1:width, h in 1:height
#         raw_img[w, h] = sample(
#             images,
#             SVector{2, Float32}((w - 1) / width, (h - 1) / height),
#             UInt32(i))
#     end
#     raw_img = reshape(reinterpret(Float32, raw_img), 3, width, height)
#     img = colorview(RGB{Float32}, permutedims(raw_img, (1, 3, 2)))
#     save("img-$i.png", img)
# end

# # TODO create test out of this
# # Fill occupancy with cube at 0th level.
# resolution = get_resolution(trainer.occupancy)
# level_density = zeros(Float32, resolution, resolution, resolution)
# for level in 0:0
#     fill!(level_density, 0f0)
#     for i in 1:length(level_density)
#         point = index_to_point(
#             UInt32(i - 1), UInt32(resolution), UInt32(level))
#         idx = point_to_index(point, UInt32(resolution), UInt32(level))
#         level_density[idx + 1] = 1f0
#     end
#     copy!(
#         @view(trainer.occupancy.density[:, :, :, level + 1]),
#         level_density)
# end
# update_binary!(trainer.occupancy)

# camera = Camera(MMatrix{3, 4, Float32}(I), dataset.intrinsics)
# set_projection!(
#     camera, dataset.rotations_host[10],
#     dataset.translations_host[10])
# renderer = Renderer(
#     dev, camera, trainer.bbox, trainer.cone; tile_size=256 * 256)
# render!(renderer, trainer.occupancy, trainer.bbox; max_steps=128) do points, directions
#     model(points, directions)
#     # ones(dev, Float32, (4, size(points, 2)))
#     # vcat(
#     #     ones(dev, Float32, (3, size(points, 2))),
#     #     -2f0 .* rand(dev, Float32, (1, size(points, 2))),
#     # )
# end

# save("image.png", RGB.(to_image(renderer.buffer)))

function main()
    dev = DEVICE
    config_file = joinpath(pkgdir(Nerf), "data", "raccoon_sofa2", "transforms.json")
    dataset = Dataset(dev; config_file)

    model = BasicModel(BasicField(dev))
    trainer = Trainer(model, dataset; n_rays=1024, ray_steps=1024, n_levels=5)

    camera = Camera(MMatrix{3, 4, Float32}(I), dataset.intrinsics)
    set_projection!(
        camera, dataset.rotations_host[10],
        dataset.translations_host[10])
    renderer = Renderer(
        dev, camera, trainer.bbox, trainer.cone;
        tile_size=256 * 256)

    for i in 1:(16 * 2000)
        l = step!(trainer)
        @show i, l

        if i % 1000 == 0
            render!(
                renderer, trainer.occupancy, trainer.bbox; max_steps=128,
            ) do points, directions
                model(points, directions)
            end
            save("image-$i.png", RGB.(to_image(renderer.buffer)))
        end
    end
    nothing
end

function bench(trainer::Trainer, n::Int)
    for _ in 1:(16 * n)
        step!(trainer)
    end
end

function main2()
    config_file = "/home/pxl-th/code/nerf-datasets/lego/transforms_train.json"
    dataset = Dataset(DEVICE; config_file)
    model = BasicModel(BasicField(DEVICE))
    trainer = Trainer(model, dataset; n_rays=1024, ray_steps=1024, n_levels=5)

    n = 10
    @time bench(trainer, n)
    n = 1000
    @time bench(trainer, n)
end

end
