using KAUtils
using LinearAlgebra
using Nerf
using StaticArrays
using Test
using Zygote

const DEVICE = Nerf.DEVICE
@info "Testing on device: $DEVICE"

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
end
