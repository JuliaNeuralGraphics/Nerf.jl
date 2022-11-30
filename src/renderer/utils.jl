struct RenderRay
    ray::Ray
    t::Float32
    idx::UInt32
    steps::UInt32
    alive::Bool
end

@inline function RenderRay(
    r::RenderRay; t::Float32 = r.t,
    steps::UInt32 = r.steps, alive::Bool = r.alive,
)
    RenderRay(r.ray, t, r.idx, steps, alive)
end
