@testset "Grid Index" begin
    resolution::UInt32 = 16
    hashmap_size::UInt32 = resolution^3

    grid_pos = MVector{3, UInt32}(0, 0, 0)
    idx = Nerf.grid_index(grid_pos, hashmap_size, resolution)
    @test idx == 1

    grid_pos = MVector{3, UInt32}(
        resolution - 1, resolution - 1, resolution - 1)
    idx = Nerf.grid_index(grid_pos, hashmap_size, resolution)
    @test idx == hashmap_size
end

@testset "Fractional position" begin
    base_resolution::UInt32 = 16
    log_scale = 1.5f0

    for level in 1:16
        scale = Nerf.compute_scale(UInt32(level), log_scale, base_resolution)

        x = MVector{3, Float32}(0.1f0, 0.5f0, 0.9f0)
        δposition, grid_position, ∂position = Nerf.to_grid_position(x, scale)
        @test all(0f0 .≤ δposition .≤ 1f0)
    end
end

@testset "Deterministic result" begin
    ge = Nerf.GridEncoding() |> Flux.gpu
    fill!(ge.θ, 1f0)

    x = KernelAbstractions.ones(Backend, Float32, (3, 16))
    y = ge(x)
    @test sum(y) == 512f0
end

@testset "Hashgrid gradients" begin
    ge = Nerf.GridEncoding() |> Flux.gpu

    n = 16
    x = rand(Float32, (3, n)) |> Flux.gpu

    ∇ = Zygote.gradient(ge) do ge
        sum(ge(x))
    end
    @test size(∇[1].θ) == size(ge.θ)

    ∇ = Zygote.gradient(ge) do ge
        sum(ge(x, Val{:IG}()))
    end
    @test size(∇[1].θ) == size(ge.θ)

    ∇ = Zygote.gradient(x) do x
        sum(ge(x, Val{:IG}()))
    end
    @test size(∇[1]) == (3, n)

    ∇ = Zygote.gradient(ge, x) do ge, x
        sum(ge(x, Val{:IG}()))
    end
    @test size(∇[1].θ) == size(ge.θ)
    @test size(∇[2]) == (3, n)

    y, back = Zygote.pullback(x) do x
        ge(x, Val{:IG}())
    end
    Δ = KernelAbstractions.ones(Backend, Float32, size(y))
    ∇ = back(Δ)[1]
    @test size(∇) == (3, n)
    @test !any(isnan.(∇))
end
