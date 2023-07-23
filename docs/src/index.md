# Nerf.jl

Real-time Neural 3D Scene Reconstruction.

## Requirements

- Julia 1.9 or above.
- AMD or Nvidia GPU (check AMDGPU.jl or CUDA.jl for respective device support).
- At least 4-6 GB of VRAM.

## Quickstart (NerfGUI.jl)

For standalone application check [NerfGUI.jl](https://github.com/JuliaNeuralGraphics/NerfGUI.jl)
package, which provides OpenGL application for real-time interaction.

1. Clone `git clone https://github.com/JuliaNeuralGraphics/NerfGUI.jl.git`.
2. Select `ROC` (AMD GPU) or `CUDA` (Nvidia) as GPU backend in `LocalPreferences.toml` file.
3. Start Julia REPL and launch application:
```
NerfGUI.jl$ julia --project=. --threads=auto

julia> using NerfGUI

julia> NerfGUI.main()
```

## References

1. Instant Neural Graphics Primitives with a Multiresolution Hash Encoding:
    <https://nvlabs.github.io/instant-ngp/>.
