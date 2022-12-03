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

@testset "Occupancy indexing" begin
    resolution::UInt32 = 128

    for level in UnitRange{UInt32}(0, 4)
        point = Nerf.index_to_point(UInt32(0), resolution, level)
        @test Nerf.point_to_index(point, resolution, level) == 0
        point = Nerf.index_to_point(UInt32(resolution^3 - 1), resolution, level)
        @test Nerf.point_to_index(point, resolution, level) == resolution^3 - 1
    end

    level::UInt32 = 0
    point = SVector{3, Float32}(0, 0, 0)
    idx = Nerf.point_to_index(point, resolution, level)
    @test idx == 0

    point = SVector{3, Float32}(1, 1, 1)
    idx = Nerf.point_to_index(point, resolution, level)
    @test idx == resolution^3 - 1
end

@testset "Image index" begin
    n_rays::UInt32 = 1024
    n_images::UInt32 = 16
    @test Nerf.image_index(UInt32(1), n_rays, n_images) == 1
    @test Nerf.image_index(UInt32(2), n_rays, n_images) == 1
    @test Nerf.image_index(UInt32(1023), n_rays, n_images) == n_images
    @test Nerf.image_index(UInt32(1024), n_rays, n_images) == n_images
end

@testset "To pixel" begin
    width::UInt32, height::UInt32 = 1280, 720

    xy = SVector{2, Float32}(0f0, 0f0)
    pixel = Nerf.to_pixel(xy, width, height)
    @test pixel == SVector{2, UInt32}(1, 1)

    xy = SVector{2, Float32}(0.5f0, 0.5f0)
    pixel = Nerf.to_pixel(xy, width, height)
    @test pixel == SVector{2, UInt32}(width ÷ 2 + 1, height ÷ 2 + 1)

    xy = SVector{2, Float32}(1f0, 1f0)
    pixel = Nerf.to_pixel(xy, width, height)
    @test pixel == SVector{2, UInt32}(width, height)
end

@testset "Level from point" begin
    n_levels::UInt32 = 4

    @test Nerf.level_from_point(SVector{3, Float32}(0.01, 0.01, 0.01), n_levels) == 0
    @test Nerf.level_from_point(SVector{3, Float32}(0.99, 0.99, 0.99), n_levels) == 0

    @test Nerf.level_from_point(SVector{3, Float32}(0, 0, 0), n_levels) == 1
    @test Nerf.level_from_point(SVector{3, Float32}(1, 1, 1), n_levels) == 1
    @test Nerf.level_from_point(SVector{3, Float32}(-0.49, -0.49, -0.49), n_levels) == 1
    @test Nerf.level_from_point(SVector{3, Float32}(1.49, 1.49, 1.49), n_levels) == 1

    @test Nerf.level_from_point(SVector{3, Float32}(-0.5, -0.5, -0.5), n_levels) == 2
    @test Nerf.level_from_point(SVector{3, Float32}(1.5, 1.5, 1.5), n_levels) == 2
end
