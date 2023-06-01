@testset "Density bitfield update" begin
    resolution = 128
    n_levels = 5
    occupancy = Nerf.OccupancyGrid(Backend; n_levels, resolution)

    # Initially density is 0.
    @test all(Array(occupancy.density) .≈ 0f0)
    # And bitfield as well.
    @test all(Array(occupancy.binary) .== 0x0)

    # Set 0-th level to 1.
    occupancy.density[:, :, :, 1] .= 1f0
    first_level = @view(occupancy.density[:, :, :, 1])
    @test sum(first_level) == length(first_level)
    Nerf.update_binary!(occupancy)
    binary = Array(occupancy.binary)

    # Test that corners of bitfield are occupied at 0th level.
    level = UInt32(0)
    point = Nerf.index_to_point(UInt32(0), UInt32(resolution), level)
    @test Nerf.is_occupied(binary, point, UInt32(resolution), level)
    point = Nerf.index_to_point(UInt32(resolution^3 - 1), UInt32(resolution), level)
    @test Nerf.is_occupied(binary, point, UInt32(resolution), level)

    # Test that corners of bitfield are NOT occupied at 1st level.
    level = UInt32(1)
    point = Nerf.index_to_point(UInt32(0), UInt32(resolution), level)
    @test !Nerf.is_occupied(binary, point, UInt32(resolution), level)
    point = Nerf.index_to_point(UInt32(resolution^3 - 1), UInt32(resolution), level)
    @test !Nerf.is_occupied(binary, point, UInt32(resolution), level)

    # Each next level contains 1/8th bits set from the previous level.
    level_length = resolution^3 ÷ 8
    all_set = 0xff * level_length
    for level in UnitRange{UInt32}(1, n_levels)
        s = level_length * (level - 0x1) + 0x1
        e = level_length * level
        binary_level = @view(binary[s:e])
        @test length(binary_level) == level_length
        @test sum(binary_level) == all_set / (8^(level - 0x1))
    end
end
