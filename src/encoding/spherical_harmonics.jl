function spherical_harmonics(x)
    n_features = 16
    y = similar(x, (n_features, size(x, 2)))
    spherical_harmonics!(y, x)
end

function spherical_harmonics!(y, x)
    _spherical_harmonics!(get_backend(x))(y, x; ndrange=size(x, 2))
    y
end

function ∇spherical_harmonics(∂L∂y::T, x) where T
    ∂L∂x = similar(∂L∂y, size(x))
    ∇spherical_harmonics!(∂L∂x, ∂L∂y, x)
end

function ∇spherical_harmonics!(∂L∂x, ∂L∂y, x)
    _∇spherical_harmonics!(get_backend(x))(∂L∂x, ∂L∂y, x; ndrange=size(x, 2))
    ∂L∂x
end

function ChainRulesCore.rrule(::typeof(spherical_harmonics), x)
    function sh_pullback(Δ)
        NoTangent(), ∇spherical_harmonics(unthunk(Δ), x)
    end
    spherical_harmonics(x), sh_pullback
end

@kernel function _spherical_harmonics!(encodings, @Const(directions))
    i::UInt32 = @index(Global)
    @inbounds x, y, z = directions[1, i], directions[2, i], directions[3, i]

    xy, xz, yz = x * y, x * z, y * z
    x², y², z² = x^2, y^2, z^2

    @inbounds begin
        encodings[1, i] = 0.28209479177387814f0
        encodings[2, i] = -0.48860251190291987f0 * y
        encodings[3, i] = 0.48860251190291987f0 * z
        encodings[4, i] = -0.48860251190291987f0 * x
        encodings[5, i] = 1.0925484305920792f0 * xy
        encodings[6, i] = -1.0925484305920792f0 * yz
        encodings[7, i] = 0.94617469575755997f0 * z² - 0.31539156525251999f0
        encodings[8, i] = -1.0925484305920792f0 * xz
        encodings[9, i] = 0.54627421529603959f0 * x² - 0.54627421529603959f0 * y²
        encodings[10, i] = 0.59004358992664352f0 * y * (-3.0f0 * x² + y²)
        encodings[11, i] = 2.8906114426405538f0 * xy * z
        encodings[12, i] = 0.45704579946446572f0 * y * (1.0f0 - 5.0f0 * z²)
        encodings[13, i] = 0.3731763325901154f0 * z * (5.0f0 * z² - 3.0f0)
        encodings[14, i] = 0.45704579946446572f0 * x * (1.0f0 - 5.0f0 * z²)
        encodings[15, i] = 1.4453057213202769f0 * z * (x² - y²)
        encodings[16, i] = 0.59004358992664352f0 * x * (-x² + 3.0f0 * y²)
    end
end

@kernel function _∇spherical_harmonics!(∂L∂x, @Const(∂L∂y), @Const(directions))
    i::UInt32 = @index(Global)
    @inbounds x, y, z = directions[1, i], directions[2, i], directions[3, i]

    xy, xz, yz = x * y, x * z, y * z
    x², y², z² = x^2, y^2, z^2

    ∂x, ∂y, ∂z = 0f0, 0f0, 0f0
    @inbounds begin
        ∂y += ∂L∂y[2, i] * -0.48860251190291992f0
        ∂z += ∂L∂y[3, i] * 0.48860251190291992f0
        ∂x += ∂L∂y[4, i] * -0.48860251190291992f0
        ∂x += ∂L∂y[5, i] * 1.0925484305920792f0 * y
        ∂y += ∂L∂y[5, i] * 1.0925484305920792f0 * x
        ∂y += ∂L∂y[6, i] * -1.0925484305920792f0 * z
        ∂z += ∂L∂y[6, i] * -1.0925484305920792f0 * y
        ∂z += ∂L∂y[7, i] * 1.8923493915151202f0 * z
        ∂x += ∂L∂y[8, i] * -1.0925484305920792f0 * z
        ∂z += ∂L∂y[8, i] * -1.0925484305920792f0 * x
        ∂x += ∂L∂y[9, i] * 1.0925484305920792f0 * x
        ∂y += ∂L∂y[9, i] * -1.0925484305920792f0 * y
        ∂x += ∂L∂y[10, i] * -3.5402615395598609f0 * xy
        ∂y += ∂L∂y[10, i] * (-1.7701307697799304f0 * x² + 1.7701307697799304f0 * y²)
        ∂x += ∂L∂y[11, i] * 2.8906114426405538f0 * yz
        ∂y += ∂L∂y[11, i] * 2.8906114426405538f0 * xz
        ∂z += ∂L∂y[11, i] * 2.8906114426405538f0 * xy
        ∂y += ∂L∂y[12, i] * (0.45704579946446572f0 - 2.2852289973223288f0 * z²)
        ∂z += ∂L∂y[12, i] * -4.5704579946446566f0 * yz
        ∂z += ∂L∂y[13, i] * (5.597644988851731f0 * z² - 1.1195289977703462f0)
        ∂x += ∂L∂y[14, i] * (0.45704579946446572f0 - 2.2852289973223288f0 * z²)
        ∂z += ∂L∂y[14, i] * -4.5704579946446566f0 * xz
        ∂x += ∂L∂y[15, i] * 2.8906114426405538f0 * xz
        ∂y += ∂L∂y[15, i] * -2.8906114426405538f0 * yz
        ∂z += ∂L∂y[15, i] * (1.4453057213202769f0 * x² - 1.4453057213202769f0 * y²)
        ∂x += ∂L∂y[16, i] * (-1.7701307697799304f0 * x² + 1.7701307697799304f0 * y²)
        ∂y += ∂L∂y[16, i] * 3.5402615395598609f0 * xy

        ∂L∂x[1, i] = ∂x * 2f0
        ∂L∂x[2, i] = ∂y * 2f0
        ∂L∂x[3, i] = ∂z * 2f0
    end
end
