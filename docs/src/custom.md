# Creating Custom Dataset

By default Nerf.jl and NerfGUI.jl comes with its own Raccoon dataset.

However, it is easy to create custom ones.

## Steps

Nerf.jl uses same input format as [instant-ngp](https://github.com/NVlabs/instant-ngp/).

1. Take a short clip of an object you want to reconstruct.

2. Using `colmap2nerf.py` script reconstruct camera poses
    via [COLMAP](https://github.com/colmap/colmap).
    Below is an example command:

    ```
    ~$ python3 colmap2nerf.py --video_in=input.mp4 --video_fps=2 --run_colmap --aabb_scale=4
    ```

    It will slice video into frames, run COLMAP camera pose reconstruction
    and save the results in `transforms.json` file along with
    images in `images/` directory.

    Make sure paths in `transform.json` point correctly to the images.

3. Open `transforms.json` in NerfGUI.jl application by pasting its path
    in the datasets window.
