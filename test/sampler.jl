@testset "Check ray samples span" begin
    n_rays = 1024
    ray_steps = 1024
    n_levels = 5
    resolution = 128

    config_file = joinpath(pkgdir(Nerf), "data", "raccoon_sofa2", "transforms.json")
    dataset = Nerf.Dataset(Backend; config_file)
    occupancy = Nerf.OccupancyGrid(Backend; n_levels, resolution)
    cone = Nerf.Cone(;
        angle=Nerf.get_cone_angle(dataset), steps=ray_steps,
        resolution=Nerf.get_resolution(occupancy),
        n_levels=Nerf.get_n_levels(occupancy))
    bbox = Nerf.get_bbox(dataset, n_levels)

    Nerf.mark_invisible_regions!(
        occupancy; intrinsics=dataset.intrinsics,
        rotations=dataset.rotations, translations=dataset.translations)
    Nerf.update!(
        occupancy; rng_state=Nerf.PCG_STATE, cone, bbox, step=0,
        update_frequency=16, n_levels=Nerf.get_n_levels(dataset), decay=1f0,
    ) do points
        adapt(Backend, rand(Float32, (size(points, 2),)))
    end

    bundle = Nerf.RayBundle(
        occupancy, cone, bbox,
        dataset.rotations, dataset.translations, dataset.intrinsics;
        n_rays, rng_state=Nerf.PCG_STATE)
    samples = Nerf.materialize(
        bundle, occupancy, cone, bbox, dataset.translations)

    bundle_host = adapt(Array, bundle)
    samples_host = adapt(Array, samples)

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

            np = Nerf.Ray(origin, direction)(t)
            valid_norm = norm(direction) ≈ 1f0
            valid_time = t ≥ 0f0 || isapprox(t, 0f0; atol=1f-6, rtol=1f-6)
            valid_ray_point = isapprox(np, point; atol=1f-2, rtol=1f-2)

            valid_norm || @error "Invalid norm: $(norm(direction))"
            valid_time || @error "Invalid t: $t"
            valid_ray_point || @error "Invalid ray point: $np vs $point"

            valid_samples &= valid_norm && valid_time && valid_ray_point
            valid_samples || break

            total_steps += 1
        end
        valid_samples || break
    end
    @test valid_samples
    @test total_steps == Int(bundle.n_samples)
end
