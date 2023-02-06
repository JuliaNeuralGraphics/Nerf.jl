@testset "Chain type-stability" begin
    for T in (Float32, Float16)
        @inferred Nerf.Chain(
            Nerf.Dense{T}(3=>64, Nerf.relu),
            Nerf.Dense{T}(64=>64, Nerf.relu),
            Nerf.Dense{T}(64=>3))
        c = Nerf.Chain(
            Nerf.Dense{T}(3=>64, Nerf.relu),
            Nerf.Dense{T}(64=>64, Nerf.relu),
            Nerf.Dense{T}(64=>3))

        # TODO make inferrable at > 3 length
        @inferred Nerf.init(c)
        θ = map(l -> Nerf.to_device(DEVICE, l), Nerf.init(c))

        n = 16
        x = rand(DEVICE, T, (3, n))
        @inferred c(x, θ)
        y = c(x, θ)
        @test eltype(y) == T

        ∇ = Zygote.gradient(θ -> sum(c(x, θ)), θ)
        # TODO look into it?
        # @inferred Zygote.gradient(θ -> sum(c(x, θ)), θ)

        @test eltype(∇[1][1]) == T
    end
end

@testset "Test normalization works correctly" begin
    n = 2
    host_directions = zeros(Float32, 3, n)
    host_directions[:, 1] .= (1, 0, 0)
    host_directions[:, 2] .= (1, 1, 1)
    directions = Nerf.to_device(DEVICE, host_directions)

    norms = Nerf.safe_norm(directions; dims=1)
    @test size(norms) == (1, n)
    @test !all(norms .≈ 1f0)

    normalized_directions = Nerf.safe_normalize(directions; dims=1)
    @test normalized_directions[:, 1] ≈ directions[:, 1]

    norms = Nerf.safe_norm(normalized_directions; dims=1)
    @test size(norms) == (1, n)
    @test all(norms .≈ 1f0)
end

@testset "Test reflection function keeps directions norm" begin
    n = 5
    directions = rand(DEVICE, Float32, (3, n))
    directions = Nerf.safe_normalize(directions; dims=1)

    normals = rand(DEVICE, Float32, (3, n))
    normals = Nerf.safe_normalize(normals; dims=1)

    reflections = Nerf.reflect(directions, normals)
    @test all(Nerf.safe_norm(reflections; dims=1) .≈ 1f0)
end
