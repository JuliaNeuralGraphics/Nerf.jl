mutable struct Trainer{M}
    model::M
    dataset::Dataset
    occupancy::OccupancyGrid
    bbox::BBox
    cone::Cone

    step::Int
    n_rays::Int
    occupancy_update_frequency::Int
    occupancy_decay::Float32
end

function Trainer(
    model, dataset::Dataset;
    n_rays::Int = 1024, ray_steps::Int = 1024,
    occupancy_update_frequency::Int = 16,
    occupancy_resolution::Int = 128,
    occupancy_decay::Float32 = 0.95f0,
)
    dev = get_device(model)
    occupancy = OccupancyGrid(
        dev; n_levels=get_n_levels(dataset),
        resolution=occupancy_resolution)
    cone = Cone(;
        angle=get_cone_angle(dataset), steps=ray_steps,
        resolution=get_resolution(occupancy),
        n_levels=get_n_levels(occupancy))
    bbox = get_bbox(dataset)
    Trainer(
        model, dataset, occupancy, bbox, cone,
        0, n_rays, occupancy_update_frequency, occupancy_decay)
end

function reset!(t::Trainer)
    reset!(t.model)
    reset!(t.occupancy)
    t.n_steps = 0
end

function step!(t::Trainer)
    if t.step % t.occupancy_update_frequency == 0
        if t.step == 0
            mark_invisible_regions!(
                t.occupancy; intrinsics=t.dataset.intrinsics,
                rotations=t.dataset.rotations, translations=t.dataset.translations)
        end
        decay = t.occupancy_decay^(t.step / 16f0)
        update!(t.occupancy; bbox=t.bbox, step=t.step, decay) do points
            batched_density(t.model, points; batch=512 * 512)
        end
    end

    bundle = RayBundle(
        t.occupancy, t.cone, t.bbox,
        t.dataset.rotations, t.dataset.translations, t.dataset.intrinsics;
        n_rays=t.n_rays)
    samples = materialize(bundle, t.occupancy, t.cone, t.bbox, t.dataset.translations)

    raw_points = reshape(reinterpret(Float32, samples.points), 3, :)
    raw_directions = reshape(reinterpret(Float32, samples.directions), 3, :)
    loss = step!(
        t.model, raw_points, raw_directions;
        bundle, samples, images=t.dataset.images)
    t.step += 1
    loss
end
