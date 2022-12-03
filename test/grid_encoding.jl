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

        x = SVector{3, Float32}(0.1f0, 0.5f0, 0.9f0)
        δposition, grid_position, ∂position = Nerf.to_grid_position(
            x, scale, Val{3}())
        @test all(0f0 .≤ δposition .≤ 1f0)
    end
end

@testset "Hashgrid gradients" begin
    ge = GridEncoding(DEVICE; n_dims=3)
    θ = Nerf.init(ge)

    n = 16
    x = rand(DEVICE, Float32, (3, n))

    ∇ = Zygote.gradient(θ) do θ
        sum(ge(x, θ))
    end
    @test size(∇[1]) == size(θ)

    ∇ = Zygote.gradient(θ) do θ
        sum(ge(x, θ, Val{:IG}()))
    end
    @test size(∇[1]) == size(θ)

    ∇ = Zygote.gradient(x) do x
        sum(ge(x, θ, Val{:IG}()))
    end
    @test size(∇[1]) == (3, n)

    ∇ = Zygote.gradient(θ, x) do θ, x
        sum(ge(x, θ, Val{:IG}()))
    end
    @test size(∇[1]) == size(θ)
    @test size(∇[2]) == (3, n)

    y, back = Zygote.pullback(x) do xi
        ge(xi, θ, Val{:IG}())
    end
    ∇ = back(ones(DEVICE, Float32, size(y)))[1]
    @test size(∇) == (3, n)
    @test !any(isnan.(∇))
end
