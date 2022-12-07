struct RenderRay
    direction::SVector{3, Float32}
    t::Float32
    idx::UInt32
    steps::UInt32
    alive::Bool
end

@inline function RenderRay(
    r::RenderRay; t::Float32 = r.t,
    steps::UInt32 = r.steps, alive::Bool = r.alive,
)
    RenderRay(r.direction, t, r.idx, steps, alive)
end
