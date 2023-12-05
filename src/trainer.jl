# TODO docs
@inline max_rng_samples_per_ray() = UInt32(16)

mutable struct Trainer{M, D <: Dataset, O <: OccupancyGrid, B <: RayBundle}
    model::M
    dataset::D
    occupancy::O
    bbox::BBox
    cone::Cone

    bundle::B
    step::Int
    n_rays::Int
    occupancy_update_frequency::Int
    occupancy_decay::Float32

    lr_start::Float32
    lr_end::Float32
    lr_steps::Int
    lr_scheudler::Function

    rng_state::UInt64
end

function Trainer(
    model, dataset::D;
    n_rays::Int = 1024, ray_steps::Int = 1024, n_levels::Int = 5,
    occupancy_update_frequency::Int = 16,
    occupancy_resolution::Int = 128,
    occupancy_decay::Float32 = 0.95f0,
    lr_start::Float32 = 1f-2,
    lr_end::Float32 = 1f-5,
    lr_steps::Int = 20_000,
) where D <: Dataset
    kab = get_backend(model)
    lr_scheudler = NU.exp_scheduler(lr_start, lr_end, lr_steps)
    occupancy = OccupancyGrid(kab; n_levels, resolution=occupancy_resolution)
    cone = Cone(;
        angle=get_cone_angle(dataset), steps=ray_steps,
        resolution=get_resolution(occupancy), n_levels)
    bbox = get_bbox(dataset, n_levels)
    bundle = RayBundle(kab; n_rays, n_steps=ray_steps)
    Trainer(
        model, dataset, occupancy, bbox, cone, bundle,
        0, n_rays, occupancy_update_frequency, occupancy_decay,
        lr_start, lr_end, lr_steps, lr_scheudler,
        PCG_STATE)
end

function reset!(t::Trainer)
    reset!(t.model)
    reset!(t.occupancy)
    t.lr_scheudler = NU.exp_scheduler(lr_start, lr_end, lr_steps)
    t.step = 0
    t.rng_state = PCG_STATE
    return
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
    t.model.optimizer.lr = t.lr_scheudler(t.step)

    prepare!(t)
    materialize!(
        t.bundle, t.occupancy, t.cone, t.bbox;
        rotations=t.dataset.rotations, translations= t.dataset.translations,
        intrinsics=t.dataset.intrinsics, rng_state=t.rng_state)

    raw_points, raw_directions = raw_samples(t.bundle)
    loss = step!(
        t.model, raw_points, raw_directions;
        bundle=t.bundle, images=t.dataset.images, rng_state=t.rng_state)

    t.rng_state = advance(t.rng_state)
    t.step += 1
    loss
end

function prepare!(t::Trainer)
    t.step % t.occupancy_update_frequency != 0 && return

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
    return
end
