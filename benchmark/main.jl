using BenchmarkTools
using KernelAbstractions
using Nerf

const Backend = Nerf.Backend

function benchmark_grid_encoding()
    ge = Nerf.GridEncoding(Backend)
    θ = Nerf.init(ge)

    n = 1024 * 1024
    x = KernelAbstractions.ones(Backend, Float32, (3, n))
    y = allocate(Backend, Float32, (Nerf.get_output_shape(ge)..., n))

    @info "GridEncoding benchmark"
    @btime begin
        $ge($y, $x, $θ)
        KernelAbstractions.synchronize(Backend)
    end

    KernelAbstractions.unsafe_free!.((x, y))
    return
end

function benchmark_spherical_harmonics()
    n = 1024 * 1024
    x = allocate(Backend, Float32, (3, n))
    y = allocate(Backend, Float32, (16, n))

    @info "Spherical harmonics benchmark"
    @btime begin
        Nerf.spherical_harmonics!($y, $x)
        KernelAbstractions.synchronize(Backend)
    end

    KernelAbstractions.unsafe_free!.((x, y))
    return
end

function main()
    benchmark_grid_encoding()
    benchmark_spherical_harmonics()
end
main()
