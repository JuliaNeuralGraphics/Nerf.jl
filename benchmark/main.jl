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

    @btime begin
        $ge($y, $x, $θ)
        KernelAbstractions.synchronize(Backend)
    end
    return
end

function main()
    benchmark_grid_encoding()
end
main()
