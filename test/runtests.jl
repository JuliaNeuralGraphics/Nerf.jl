using Adapt
using FileIO
using ImageCore
using LinearAlgebra
using Nerf
using StaticArrays
using Test
using Zygote
using KernelAbstractions

const Backend = Nerf.Backend
@info "[Nerf.jl] Testing on backend: $Backend"

const DEFAULT_CONFIG_FILE::String = joinpath(
    pkgdir(Nerf), "data", "raccoon_sofa2", "transforms.json")

@testset "Nerf" begin
    @testset "BBox" begin
        include("bbox.jl")
    end
    @testset "Utils" begin
        include("utils.jl")
    end
    @testset "Grid encoding" begin
        include("grid_encoding.jl")
    end
    @testset "Spherical harmonics" begin
        include("spherical_harmonics.jl")
    end
    @testset "NN" begin
        include("nn.jl")
    end
    @testset "Occupancy" begin
        include("occupancy.jl")
    end
    @testset "Sampler" begin
        include("sampler.jl")
    end
    @testset "Renderer" begin
        include("renderer.jl")
    end
end
