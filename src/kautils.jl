# Supported values are: ROC, CUDA.
const BACKEND_NAME::String = @load_preference("backend", "CUDA")

@static if BACKEND_NAME == "ROC"
    using AMDGPU
    AMDGPU.allowscalar(false)
    const Backend::ROCBackend = ROCBackend()

    Base.rand(::ROCBackend, ::Type{T}, shape) where T = AMDGPU.rand(T, shape)
elseif BACKEND_NAME == "CUDA"
    using CUDA
    CUDA.allowscalar(false)
    const Backend::CUDABackend = CUDABackend()

    Base.rand(::CUDABackend, ::Type{T}, shape) where T = CUDA.rand(T, shape)
end
