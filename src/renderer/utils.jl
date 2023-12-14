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

Base.@kwdef mutable struct RenderRayBundle{
    R <: AbstractVector{RenderRay},
    B <: AbstractVector{SVector{4, Float32}},
    I <: AbstractVector{UInt32},
    S <: RaySamples,
    P <: AbstractVector{SVector{3, UInt32}},
    C <: AbstractVector{UInt32},
}
    rays::NTuple{2, R}
    rgba::NTuple{2, B}
    hit_ids::I
    hit_rgba::B

    samples::S
    span::P
    n_samples::Int = 0

    hit_counter::C
    alive_counter::C
    alive_idx::Int = 1
end

function KernelAbstractions.unsafe_free!(b::RenderRayBundle)
    unsafe_free!(b.rays[1])
    unsafe_free!(b.rays[2])
    unsafe_free!(b.rgba[1])
    unsafe_free!(b.rgba[2])
    unsafe_free!(b.samples)
    unsafe_free!(b.span)
    unsafe_free!(b.hit_ids)
    unsafe_free!(b.hit_rgba)
    unsafe_free!(b.hit_counter)
    unsafe_free!(b.alive_counter)
    nothing
end

function Base.sizeof(rb::RenderRayBundle)
    sizeof(rb.rays[1]) + sizeof(rb.rays[2]) +
        sizeof(rb.rgba[1]) + sizeof(rb.rgba[2]) +
        sizeof(rb.hit_ids) + sizeof(rb.hit_rgba) +
        sizeof(rb.samples) + sizeof(rb.span) +
        sizeof(rb.hit_counter) + sizeof(rb.alive_counter)
end

function raw_samples(rb::RenderRayBundle; n_samples::Int)
    raw_points = reshape(
        reinterpret(Float32, @view(rb.samples.points[1:n_samples])),
        3, :)
    raw_directions = reshape(
        reinterpret(Float32, @view(rb.samples.directions[1:n_samples])),
        3, :)
    return raw_points, raw_directions
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

function RenderRayBundle(backend; n_rays::Int, max_sample_steps::Int)
    rays = (
        allocate(backend, RenderRay, n_rays),
        allocate(backend, RenderRay, n_rays))
    rgba = (
        allocate(backend, SVector{4, Float32}, n_rays),
        allocate(backend, SVector{4, Float32}, n_rays))

    # Each ray can take at most `max_sample_steps` per `step`.
    samples = RaySamples(backend; n_samples=n_rays * max_sample_steps)
    span = allocate(backend, SVector{3, UInt32}, n_rays)

    hit_ids = allocate(backend, UInt32, (n_rays,))
    hit_rgba = allocate(backend, SVector{4, Float32}, (n_rays,))
    hit_counter = allocate(backend, UInt32, 1)
    alive_counter = allocate(backend, UInt32, 1)
    rb = RenderRayBundle(;
        rays, rgba, hit_ids, hit_rgba,
        samples, span, hit_counter, alive_counter)

    reset!(rb)
    return rb
end

function reset!(rb::RenderRayBundle)
    fill!(reinterpret(Float32, rb.hit_rgba), 0f0)
    fill!(reinterpret(Float32, rb.rgba[1]), 0f0)
    fill!(reinterpret(Float32, rb.rgba[2]), 0f0)

    fill!(rb.hit_counter, UInt32(0))
    fill!(rb.alive_counter, UInt32(0))
    return
end

function compact!(
    bundle::RenderRayBundle; n_alive::Int, min_transmittance::Float32,
)
    fill!(bundle.alive_counter, UInt32(0))

    switch_buffers!(bundle)
    (; alive_rays, alive_rgba) = alive(bundle)
    (; buffer_rays, buffer_rgba) = buffer(bundle)

    compact_kernel!(get_backend(bundle))(
        alive_rays, alive_rgba, bundle.hit_ids, bundle.hit_rgba,
        buffer_rays, buffer_rgba, bundle.hit_counter, bundle.alive_counter,
        min_transmittance; ndrange=n_alive)
    return Int(Array(bundle.alive_counter)[1])
end

function materialize!(
    bundle::RenderRayBundle, occupancy::OccupancyGrid, cone::Cone;
    train_bbox::BBox, render_bbox::BBox, max_samples::Int,
)
    kab = get_backend(bundle)
    n_alive = Int(Array(bundle.alive_counter)[1])

    steps_counter = adapt(kab, zeros(UInt32, 1))
    rays_counter = adapt(kab, zeros(UInt32, 1))

    (; alive_rays) = alive(bundle)
    n_levels::UInt32 = get_n_levels(occupancy)
    resolution::UInt32 = get_resolution(occupancy)

    count_render_samples!(kab)(
        bundle.span, steps_counter, rays_counter,
        alive_rays, render_bbox, cone, UInt32(max_samples),
        occupancy.binary, n_levels, resolution; ndrange=n_alive)

    bundle.n_samples = Array{Int}(steps_counter)[1]
    generate_render_samples!(kab)(
        bundle.samples, bundle.span, alive_rays, render_bbox, train_bbox, cone,
        occupancy.binary, n_levels, resolution; ndrange=n_alive)
    return
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
