using Nerf
using Documenter

function main()
    ci = get(ENV, "CI", "") == "true"

    makedocs(
        sitename="Nerf.jl",
        pages = [
            "Home" => "index.md",
            "Creating Custom Dataset" => "custom.md",
            "Trainer" => "trainer.md",
            "Renderer" => "renderer.md",
        ]
    )
    if ci
        deploydocs(;
            repo="github.com/JuliaNeuralGraphics/Nerf.jl.git",
            push_preview=true)
    end
end
isinteractive() || main()
