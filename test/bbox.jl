@testset "Intersection & union of an empty BBox with non-empty" begin
    b1 = Nerf.BBox()
    b2 = Nerf.BBox(
        SVector{3, Float32}(0f0, 0f0, 0f0),
        SVector{3, Float32}(1f0, 1f0, 1f0))

    b_union = b1 ∪ b2
    @test b_union.min ≈ b2.min
    @test b_union.max ≈ b2.max

    b_intersect = b1 ∩ b2
    @test b_intersect.min ≈ b1.min
    @test b_intersect.max ≈ b1.max
end

@testset "Intersection & union of two non-empty BBoxes" begin
    b1 = Nerf.BBox(
        SVector{3, Float32}(0f0, 0f0, 0f0),
        SVector{3, Float32}(2f0, 2f0, 2f0))
    b2 = Nerf.BBox(
        SVector{3, Float32}(1f0, 1f0, 1f0),
        SVector{3, Float32}(3f0, 3f0, 3f0))

    b_union = b1 ∪ b2
    @test b_union.min ≈ b1.min
    @test b_union.max ≈ b2.max

    b_intersect = b1 ∩ b2
    @test b_intersect.min ≈ b2.min
    @test b_intersect.max ≈ b1.max
end

@testset "Relative position" begin
    bbox = Nerf.BBox(zeros(SVector{3, Float32}), ones(SVector{3, Float32}))
    @test Nerf.relative_position(bbox, bbox.min) ≈ bbox.min
    @test Nerf.relative_position(bbox, bbox.max) ≈ bbox.max

    p = SVector{3, Float32}(0.5f0, 0.5f0, 0.5f0)
    @test Nerf.relative_position(bbox, p) ≈ p
    p = -p
    @test Nerf.relative_position(bbox, p) ≈ p
end

@testset "BBox-Ray Intersection" begin
    bbox = Nerf.BBox(zeros(SVector{3, Float32}), ones(SVector{3, Float32}))

    ray = Nerf.Ray(zeros(SVector{3, Float32}), SVector{3, Float32}(0f0, 0f0, 1f0))
    tmin, tmax = bbox ∩ ray
    @test tmin ≈ 0f0
    @test tmax ≈ 1f0

    ray = Nerf.Ray(zeros(SVector{3, Float32}), SVector{3, Float32}(0f0, 0f0, -1f0))
    tmin, tmax = bbox ∩ ray
    @test tmin ≈ 0f0
    @test tmax ≈ 0f0

    ray = Nerf.Ray(
        SVector{3, Float32}(0.5f0, 0.5f0, -1f0),
        SVector{3, Float32}(0f0, 0f0, 1f0))
    tmin, tmax = bbox ∩ ray
    @test tmin ≈ 1f0
    @test tmax ≈ 2f0

    ray = Nerf.Ray(
        SVector{3, Float32}(0.5f0, 0.5f0, 0.5f0),
        SVector{3, Float32}(0f0, -1f0, 0f0))
    tmin, tmax = bbox ∩ ray
    @test tmin ≈ -0.5f0
    @test tmax ≈ 0.5f0

    ray = Nerf.Ray(
        SVector{3, Float32}(0.5f0, 0.5f0, 0.5f0),
        normalize(SVector{3, Float32}(-0.5f0, -0.5f0, -0.5f0)))
    tmin, tmax = bbox ∩ ray
    h = √(3f0 * 0.5f0^2)
    @test tmin ≈ -h
    @test tmax ≈ h
end

# TODO: write more test cases to ensure full coverage of `Base.intersect(b::BBox, r::Ray)`.
@testset "No BBox-Ray Intersection" begin
    bbox = Nerf.BBox(zeros(SVector{3, Float32}), ones(SVector{3, Float32}))
    ray = Nerf.Ray(
        SVector{3, Float32}(-1f0, -1f0, -1f0),
        SVector{3, Float32}(-1f0, 0f0, 0f0))
    tmin, tmax = bbox ∩ ray
    @test isinf(tmin)
    @test isinf(tmax)
end
