@testset "Random input" begin
    n = 16
    x = rand(DEVICE, Float32, (3, n))
    y = spherical_harmonics(x)
    @test size(y) == (16, n)

    ∇ = Zygote.gradient(x) do θ
        sum(spherical_harmonics(θ))
    end
    @test size(∇[1]) == size(x)
end
