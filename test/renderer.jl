@testset "Render cube" begin
    dev = DEVICE
    model = Nerf.BasicModel(Nerf.BasicField(dev))
    dataset = Nerf.Dataset(dev; config_file=DEFAULT_CONFIG_FILE)
    trainer = Nerf.Trainer(model, dataset; n_rays=1024, ray_steps=1024, n_levels=5)

    # Fill occupancy with cube at 0th level.
    resolution = Nerf.get_resolution(trainer.occupancy)
    level_density = zeros(Float32, resolution, resolution, resolution)
    for level in 0:0
        fill!(level_density, 0f0)
        for i in 1:length(level_density)
            point = Nerf.index_to_point(
                UInt32(i - 1), UInt32(resolution), UInt32(level))
            idx = Nerf.point_to_index(point, UInt32(resolution), UInt32(level))
            level_density[idx + 1] = 1f0
        end
        copy!(
            @view(trainer.occupancy.density[:, :, :, level + 1]),
            level_density)
    end
    Nerf.update_binary!(trainer.occupancy)

    camera = Nerf.Camera(MMatrix{3, 4, Float32}(I), dataset.intrinsics)
    renderer = Nerf.Renderer(dev, camera, trainer.bbox, trainer.cone)
    Nerf.set_projection!(renderer.camera, Nerf.get_pose(dataset, 31)...)
    Nerf.render!(renderer, trainer.occupancy, trainer.bbox) do points, directions
        # model(points, directions)
        ones(dev, Float32, (4, size(points, 2))) .* 0.5f0
        # vcat(
        #     rand(dev, Float32, (3, size(points, 2))),
        #     ones(dev, Float32, (1, size(points, 2))),
        # )
    end
    save("image.png", RGB.(Nerf.to_image(renderer.buffer)))
end