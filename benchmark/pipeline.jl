using Nerf
using NerfUtils
using LinearAlgebra
using StaticArrays

const Backend = Nerf.Backend

function trainer_benchmark(trainer::Nerf.Trainer, n::Int)
    for i in 1:n
        Core.println(i)
        Nerf.step!(trainer)
    end
end

function render_benchmark(renderer::Nerf.Renderer, trainer::Nerf.Trainer, n::Int)
    for i in 1:n
        Core.println(i)
        Nerf.render!(trainer.model, renderer, trainer.occupancy, trainer.bbox)
    end
end

function benchmark()
    config_file = joinpath(pkgdir(Nerf), "data", "raccoon_sofa2", "transforms.json")
    dataset = Nerf.Dataset(Backend; config_file)
    model = Nerf.BasicModel(Nerf.BasicField(Backend))
    trainer = Nerf.Trainer(model, dataset; n_rays=1024)

    # GC.enable_logging(true)

    Core.println("Trainer benchmark")

    GC.gc(true)
    GC.gc(false)
    @time trainer_benchmark(trainer, 10)
    GC.gc(true)
    GC.gc(false)
    @time trainer_benchmark(trainer, 1000)

    camera = Camera(MMatrix{3, 4, Float32}(I), dataset.intrinsics)
    NerfUtils.set_projection!(camera, Nerf.get_pose(dataset, 1)...)
    renderer = Nerf.Renderer(Backend, camera, trainer.bbox, trainer.cone)

    Core.println("Renderer benchmark")

    GC.gc(true)
    GC.gc(false)
    @time render_benchmark(renderer, trainer, 2)
    GC.gc(true)
    GC.gc(false)
    @time render_benchmark(renderer, trainer, 10)

    return
end
benchmark()
