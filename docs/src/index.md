# Nerf.jl

Real-time Neural Radiance Fields in pure Julia.

## Requirements

- Julia 1.9 or above.
- AMD or Nvidia GPU (check AMDGPU.jl or CUDA.jl for respective device support).
- At least 4-6 GB of VRAM.

## GPU backend

Use `Nerf.set_backend!(name)` to specify which GPU backend to use,
which takes a `String` with backend name:

- AMD GPU: `Nerf.set_backend!("AMDGPU")`;
- Nvidia: `Nerf.set_backend!("CUDA")`.

And then restart your Julia session if returns `true`.

Alternatively, if you cloned Nerf.jl repo, you can create `LocalPreferences.toml`
file and specify backend in it with:

```toml
[Nerf]
backend = "AMDGPU" # or "CUDA"
```

## Quickstart (NerfGUI.jl)

For standalone application check [NerfGUI.jl](https://github.com/JuliaNeuralGraphics/NerfGUI.jl)
package, which provides OpenGL application for real-time interaction.

1. Clone `git clone https://github.com/JuliaNeuralGraphics/NerfGUI.jl.git`.
2. Start Julia repl `julia --project=. --threads=auto`.
3. Instantiate project with `]up` command.
4. Select GPU backend as described above.
5. Launch application:

```julia
julia> using NerfGUI

julia> NerfGUI.main()
```

## References

1. Instant Neural Graphics Primitives with a Multiresolution Hash Encoding:
    <https://nvlabs.github.io/instant-ngp/>.
