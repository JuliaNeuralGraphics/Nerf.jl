using Zygote
using StaticArrays
using Test
using Nerf

const DEVICE = Nerf.DEVICE
@info "Testing on device: $DEVICE"

@testset "Nerf" begin
    @testset "Grid encoding" begin
        include("grid_encoding.jl")
    end
end
