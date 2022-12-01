using KAUtils
using Nerf
using StaticArrays
using Test
using Zygote

const DEVICE = Nerf.DEVICE
@info "Testing on device: $DEVICE"

@testset "Nerf" begin
    @testset "Grid encoding" begin
        include("grid_encoding.jl")
    end
    @testset "Spherical harmonics" begin
        include("spherical_harmonics.jl")
    end
    @testset "NN" begin
        include("nn.jl")
    end
end
