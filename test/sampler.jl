@testset "Check ray samples span" begin
    n_rays = 1024
    ray_steps = 1024
    n_levels = 5
    resolution = 128

    config_file = "/home/pxl-th/code/INGP.jl/data/raccoon_sofa2/transforms.json"
    dataset = Nerf.Dataset(DEVICE; config_file)
    occupancy = Nerf.OccupancyGrid(DEVICE; n_levels, resolution)
    cone = Nerf.Cone(;
        angle=Nerf.get_cone_angle(dataset), steps=ray_steps,
        resolution=Nerf.get_resolution(occupancy),
        n_levels=Nerf.get_n_levels(occupancy))
    bbox = Nerf.get_bbox(dataset, n_levels)

    Nerf.mark_invisible_regions!(
        occupancy; intrinsics=dataset.intrinsics,
        rotations=dataset.rotations, translations=dataset.translations)
    Nerf.update!(
        occupancy; cone, bbox, step=0, update_frequency=16,
        n_levels=Nerf.get_n_levels(dataset), decay=1f0,
    ) do points
        rand(DEVICE, Float32, (size(points, 2),))
    end

    bundle = Nerf.RayBundle(
        occupancy, cone, bbox,
        dataset.rotations, dataset.translations, dataset.intrinsics; n_rays)
    samples = Nerf.materialize(
        bundle, occupancy, cone, bbox, dataset.translations)

    bundle_host = Nerf.Adapt.adapt(Array, bundle)
    samples_host = Nerf.Adapt.adapt(Array, samples)

    valid_samples = true
    total_steps = 0
    for i in 1:length(bundle_host)
        offset, steps, _ = bundle_host.span[i]
        idx = bundle_host.image_indices[i]
        origin = dataset.translations_host[idx]

        for step in 1:steps
            read_idx = offset + step
            point = Nerf.inv_relative_position(
                bbox, samples_host.points[read_idx])
            direction = samples_host.directions[read_idx]
            t = ((point .- origin) ./ direction)[1]

            valid_samples &= norm(direction) ≈ 1f0
            valid_samples &= t > 0f0
            valid_samples &= isapprox(Nerf.Ray(origin, direction)(t), point; atol=1f-3)
            valid_samples || break

            total_steps += 1
        end
        valid_samples || break
    end
    @test valid_samples
    @test total_steps == bundle.n_samples
end
