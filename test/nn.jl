@testset "Test normalization works correctly" begin
    n = 2
    host_directions = zeros(Float32, 3, n)
    host_directions[:, 1] .= (1, 0, 0)
    host_directions[:, 2] .= (1, 1, 1)
    directions = adapt(Backend, host_directions)

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
    directions = adapt(Backend, rand(Float32, (3, n)))
    directions = Nerf.safe_normalize(directions; dims=1)

    normals = adapt(Backend, rand(Float32, (3, n)))
    normals = Nerf.safe_normalize(normals; dims=1)

    reflections = Nerf.reflect(directions, normals)
    @test all(Nerf.safe_norm(reflections; dims=1) .≈ 1f0)
end
