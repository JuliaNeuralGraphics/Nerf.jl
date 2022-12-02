@testset "Distance to next voxel" begin
    position = SVector{3, Float32}(0f0, 0f0, 0f0)
    direction = normalize(SVector{3, Float32}(1f0, 1f0, 1f0))
    resolution::UInt32 = 128

    for level in UnitRange{UInt32}(0, 4)
        level_resolution = resolution >> level
        d = Nerf.distance_to_voxel(position, direction, level_resolution)
        @test d ≈ Nerf.get_voxel_diameter(resolution, level)
    end
end

@testset "Advance to next voxel" begin
    position = SVector{3, Float32}(0f0, 0f0, 0f0)
    direction = normalize(SVector{3, Float32}(1f0, 1f0, 1f0))
    resolution::UInt32 = 128
    n_levels = 4

    t = 0f0
    for angle in (0f0, 1f0 / 256f0), level in UnitRange{UInt32}(0, n_levels)
        cone = Nerf.Cone(;
            angle, steps=128, resolution=Int64(resolution), n_levels)
        level_resolution = resolution >> level
        t_adv = Nerf.to_next_voxel(t, cone, position, direction, level_resolution)
        # Advanced t can be slightly bigger.
        s = Nerf.get_voxel_diameter(resolution, level)
        e = s * 2f0
        @test s ≤ t_adv ≤ e
    end
end
