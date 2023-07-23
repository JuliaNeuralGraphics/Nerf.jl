# Renderer

Nerf.jl provides a simple renderer which can be used for visualizing trainer NeRF model.

```
using LinearAlgebra
using Nerf: Renderer, Camera
```

To create a renderer, pass camera that uses dataset's intrinsics,
trainer's bounding box and cone:
```
camera = Camera(MMatrix{3, 4, Float32}(I), dataset.intrinsics)
renderer = Renderer(Backend, camera, trainer.bbox, trainer.cone)
```

## Tiled renderer

To allow rendering high-resolution frames, `Renderer` automatically switches
to a tiled mode, once the number of pixels in the frames exceeds `tile_size`
parameter.

Controlling the size of the tile can be done with `tile_size` keyword
when creating `Renderer`:
```
renderer = Renderer(
    Backend, camera, trainer.bbox, trainer.cone;
    tile_size=512 * 512) # 512x512 pixels in each tile.
```

Then, set the position of the camera (here we randomly select a pose from the dataset):
```
pose_idx = clamp(round(Int, rand() * length(dataset)), 1, length(dataset))
Nerf.set_projection!(camera, Nerf.get_pose(dataset, pose_idx)...)
```

And render whole frame in one go:
```
Nerf.render!(renderer, trainer.occupancy, trainer.bbox) do points, directions
    model(points, directions)
end
```

`Nerf.render!` accepts as first argument a function that will return `RGBA` colors
evaluated at each point & direction in  `points` & `directions`.

Thus the rendered does not know anything about the NeRF model and can be used for
generic ray marching visualizations.

`Renderer` writes everything to its internal buffer.
To save the rendering result, convert the buffer to an image and save it:
```
rgba_image = to_image(renderer.buffer)
rgb_image = RGB.(rgba_image)
save("image.png", rgb_image)
```
