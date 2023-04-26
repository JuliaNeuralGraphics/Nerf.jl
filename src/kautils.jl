# Supported values are: ROC, CUDA.
const BACKEND_NAME::String = @load_preference("backend", "ROC")

@static if BACKEND_NAME == "ROC"
    using AMDGPU
    AMDGPU.allowscalar(false)
    const Backend::ROCBackend = ROCBackend()

    Base.rand(::ROCBackend, ::Type{T}, shape) where T = AMDGPU.rand(T, shape)
elseif BACKEND_NAME == "CUDA"
    # using CUDA
    # CUDA.allowscalar(false)
    # const DEVICE::CUDADevice = CUDADevice()

    # to_device(::CUDADevice, x) = CuArray(x)
    # type_from_device(::CUDADevice) = CuArray

    # device_from_type(::T) where T <: CuArray = CUDADevice()
    # device_from_type(::Type{T}) where T <: CuArray = CUDADevice()
    # device_from_type(::Type{T}) where T <: SubArray{<:Any, <:Any, <:CuArray, <:Any, <:Any} = CUDADevice()

    # Base.zeros(::CUDADevice, ::Type{T}, shape) where T = CUDA.zeros(T, shape)
    # Base.ones(::CUDADevice, ::Type{T}, shape) where T = CUDA.ones(T, shape)
    # Base.rand(::CUDADevice, ::Type{T}, shape) where T = CUDA.rand(T, shape)
    # Base.similar(::CUDADevice, ::Type{T}, shape) where T = CuArray{T}(undef, shape)
    # Base.fill(::CUDADevice, value, shape) = CUDA.fill(value, shape)

    # unsafe_free!(x::T) where T <: CuArray = CUDA.unsafe_free!(x)
end
