struct RenderRay
    ray::Ray
    t::Float32
    idx::UInt32
    steps::UInt32
    alive::Bool
end

function RenderRay(
    r::RenderRay; t::Float32 = r.t,
    steps::UInt32 = r.steps, alive::Bool = r.alive,
)
    RenderRay(r.ray, t, r.idx, steps, alive)
end

mutable struct RenderRayBundle{R, B, I, C}
    rays::NTuple{2, R}
    rgba::NTuple{2, B}
    hit_ids::I
    hit_rgba::B

    hit_counter::C
    alive_counter::C
    alive_idx::UInt32
end

function KernelAbstractions.unsafe_free!(b::RenderRayBundle)
    unsafe_free!(b.rays[1])
    unsafe_free!(b.rays[2])
    unsafe_free!(b.rgba[1])
    unsafe_free!(b.rgba[2])
    unsafe_free!(b.hit_ids)
    unsafe_free!(b.hit_rgba)
    unsafe_free!(b.hit_counter)
    unsafe_free!(b.alive_counter)
    nothing
end

KernelAbstractions.get_backend(rb::RenderRayBundle) = get_backend(rb.rays[1])

function switch_buffers!(b::RenderRayBundle)
    b.alive_idx = (b.alive_idx == 1) ? 2 : 1
end

function alive(b::RenderRayBundle)
    (; alive_rays=b.rays[b.alive_idx], alive_rgba=b.rgba[b.alive_idx])
end

function buffer(b::RenderRayBundle)
    buff_idx = (b.alive_idx == 1) ? 2 : 1
    (; buffer_rays=b.rays[buff_idx], buffer_rgba=b.rgba[buff_idx])
end

function RenderRayBundle(rays::R) where R
    Backend = get_backend(rays)

    rays_buffers = (
        rays, allocate(Backend, RenderRay, length(rays)))
    rgba_buffers = (
        allocate(Backend, SVector{4, Float32}, length(rays)),
        allocate(Backend, SVector{4, Float32}, length(rays)))

    hit_ids = allocate(Backend, UInt32, (length(rays),))
    hit_rgba = allocate(Backend, SVector{4, Float32}, (length(rays),))

    fill!(reinterpret(Float32, hit_rgba), 0f0)
    fill!(reinterpret(Float32, rgba_buffers[1]), 0f0)
    fill!(reinterpret(Float32, rgba_buffers[2]), 0f0)

    hit_counter = KernelAbstractions.zeros(Backend, UInt32, 1)
    alive_counter = KernelAbstractions.zeros(Backend, UInt32, 1)
    RenderRayBundle(
        rays_buffers, rgba_buffers, hit_ids, hit_rgba,
        hit_counter, alive_counter, UInt32(1))
end

function compact!(
    bundle::RenderRayBundle; n_alive::Int, min_transmittance::Float32,
)
    Backend = get_backend(bundle)
    fill!(bundle.alive_counter, UInt32(0))

    switch_buffers!(bundle)
    (; alive_rays, alive_rgba) = alive(bundle)
    (; buffer_rays, buffer_rgba) = buffer(bundle)

    compact_kernel!(Backend)(
        alive_rays, alive_rgba, bundle.hit_ids, bundle.hit_rgba,
        buffer_rays, buffer_rgba, bundle.hit_counter, bundle.alive_counter,
        min_transmittance; ndrange=n_alive)
    return Int(Array(bundle.alive_counter)[1])
end

function materialize(
    bundle::RenderRayBundle, occupancy::OccupancyGrid, cone::Cone;
    train_bbox::BBox, render_bbox::BBox, max_samples::Int,
)
    Backend = get_backend(bundle)
    n_alive = Int(Array(bundle.alive_counter)[1])

    span = allocate(Backend, SVector{3, UInt32}, n_alive)
    steps_counter = KernelAbstractions.zeros(Backend, UInt32, 1)
    rays_counter = KernelAbstractions.zeros(Backend, UInt32, 1)

    (; alive_rays, alive_rgba) = alive(bundle)

    n_levels::UInt32 = get_n_levels(occupancy)
    resolution::UInt32 = get_resolution(occupancy)
    count_render_samples!(Backend)(
        span, steps_counter, rays_counter,
        alive_rays, render_bbox, cone, UInt32(max_samples),
        occupancy.binary, n_levels, resolution; ndrange=n_alive)

    n_samples = Array{Int}(steps_counter)[1]
    samples = RaySamples(Backend; n_samples)
    generate_render_samples!(Backend)(
        samples, span, alive_rays, render_bbox, train_bbox, cone,
        occupancy.binary, n_levels, resolution; ndrange=n_alive)
    samples, span
end

@kernel function count_render_samples!(
    span::S, steps_counter::K, rays_counter::K, @Const(rays),
    bbox::BBox, cone::Cone, max_samples::UInt32,
    @Const(binary), n_levels::UInt32, resolution::UInt32,
) where {
    S <: AbstractVector{SVector{3, UInt32}},
    K <: AbstractVector{UInt32},
}
    i::UInt32 = @index(Global)
    @inbounds rray = rays[i]
    ray = rray.ray

    _, _, steps = trace_ray!(
        nothing, ray, rray.t, max_samples, cone, bbox,
        binary, n_levels, resolution)

    @inbounds begin
        offset, _ = @atomic steps_counter[0x1] + steps
        _, ray_idx = @atomic rays_counter[0x1] + 0x1
        span[ray_idx] = SVector{3, UInt32}(offset, steps, i)
    end
end

@kernel function generate_render_samples!(
    samples::RaySamples, @Const(span), rays::R,
    bbox::BBox, train_bbox::BBox, cone::Cone,
    @Const(binary), n_levels::UInt32, resolution::UInt32,
) where R <: AbstractVector{RenderRay}
    i = @index(Global)
    @inbounds ray_span = span[i]
    offset, steps, idx = ray_span[1], ray_span[2], ray_span[3]

    @inbounds rray = rays[idx]
    ray = rray.ray

    @inline function consumer(point::SVector{3, Float32}, δ::Float32, step::UInt32)
        write_idx = offset + step + 0x1
        @inbounds begin
            samples.points[write_idx] = relative_position(train_bbox, point)
            samples.directions[write_idx] = ray.direction
            samples.deltas[write_idx] = δ
        end
    end
    # If steps == 0, trace the ray anyway, to get new `t` or `alive` status.
    steps = ifelse(steps == 0, UInt32(1), steps)
    alive, t, new_steps = trace_ray!(
        consumer, ray, rray.t, steps, cone, bbox,
        binary, n_levels, resolution)
    @inbounds rays[idx] = RenderRay(rray; alive, t, steps=rray.steps + new_steps)
end

@kernel function compact_kernel!(
    alive_rays::R, alive_rgba::C, hit_ids::H, hit_rgba::C,
    @Const(rays), @Const(rgba), hit_counter::K, alive_counter::K,
    min_transmittance::Float32,
) where {
    R <: AbstractVector{RenderRay},
    C <: AbstractVector{SVector{4, Float32}},
    H <: AbstractVector{UInt32},
    K <: AbstractVector{UInt32},
}
    i::UInt32 = @index(Global)
    @inbounds begin
        ray, c = rays[i], rgba[i]
        if ray.alive
            _, idx = @atomic alive_counter[0x1] + 0x1
            alive_rays[idx] = ray
            alive_rgba[idx] = c
        elseif c[4] > min_transmittance
            _, idx = @atomic hit_counter[0x1] + 0x1
            hit_ids[idx] = ray.idx
            hit_rgba[idx] = c
        end
    end
end
