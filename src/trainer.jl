mutable struct Trainer{M, D <: Dataset, O <: OccupancyGrid}
    model::M
    dataset::D
    occupancy::O
    bbox::BBox
    cone::Cone

    step::Int
    n_rays::Int
    occupancy_update_frequency::Int
    occupancy_decay::Float32

    rng_state::UInt64
end

function Trainer(
    model, dataset::D;
    n_rays::Int = 1024, ray_steps::Int = 1024, n_levels::Int = 5,
    occupancy_update_frequency::Int = 16,
    occupancy_resolution::Int = 128,
    occupancy_decay::Float32 = 0.95f0,
) where D <: Dataset
    dev = get_device(model)
    occupancy = OccupancyGrid(dev; n_levels, resolution=occupancy_resolution)
    cone = Cone(;
        angle=get_cone_angle(dataset), steps=ray_steps,
        resolution=get_resolution(occupancy), n_levels)
    bbox = get_bbox(dataset, n_levels)
    Trainer(
        model, dataset, occupancy, bbox, cone,
        0, n_rays, occupancy_update_frequency, occupancy_decay,
        PCG_STATE)
end

function reset!(t::Trainer)
    reset!(t.model)
    reset!(t.occupancy)
    t.step = 0
    t.rng_state = PCG_STATE
    return nothing
end

function set_dataset!(t::Trainer, dataset::Dataset)
    n_levels = get_n_levels(t.occupancy)
    ray_steps = Int(t.cone.steps)

    cone = Cone(;
        angle=get_cone_angle(dataset), steps=ray_steps,
        resolution=get_resolution(t.occupancy), n_levels)
    bbox = get_bbox(dataset, n_levels)

    t.dataset = dataset
    t.bbox = bbox
    t.cone = cone

    reset!(t)
end

function step!(t::Trainer)
    BACKEND == "ROC" && GC.gc(false) # FIXME
    prepare!(t)

    bundle = RayBundle(
        t.occupancy, t.cone, t.bbox, t.dataset.rotations,
        t.dataset.translations, t.dataset.intrinsics;
        n_rays=t.n_rays, rng_state=t.rng_state)
    samples = materialize(
        bundle, t.occupancy, t.cone, t.bbox, t.dataset.translations)

    raw_points = reshape(reinterpret(Float32, samples.points), 3, :)
    raw_directions = reshape(reinterpret(Float32, samples.directions), 3, :)
    loss = step!(
        t.model, raw_points, raw_directions;
        bundle, samples, images=t.dataset.images,
        n_rays=t.n_rays, rng_state=t.rng_state)

    unsafe_free!(bundle)
    unsafe_free!(samples)

    t.rng_state = advance(t.rng_state)
    t.step += 1
    loss
end

function prepare!(t::Trainer)
    t.step % t.occupancy_update_frequency != 0 && return nothing

    if t.step == 0
        mark_invisible_regions!(
            t.occupancy; intrinsics=t.dataset.intrinsics,
            rotations=t.dataset.rotations, translations=t.dataset.translations)
    end

    t.rng_state = update!(
        t.occupancy; rng_state=t.rng_state, cone=t.cone, bbox=t.bbox,
        step=t.step, update_frequency=t.occupancy_update_frequency,
        n_levels=get_n_levels(t.dataset), decay=t.occupancy_decay,
    ) do points
        batched_density(t.model, points; batch=512 * 512)
    end
    return nothing
end
