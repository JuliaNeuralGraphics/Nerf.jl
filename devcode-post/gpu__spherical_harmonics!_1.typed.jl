CodeInfo(
      @ none within `gpu__spherical_harmonics!`
     ┌ @ /home/pxl-th/.julia/packages/KernelAbstractions/cWlFz/src/KernelAbstractions.jl:395 within `constify`
     │┌ @ /home/pxl-th/.julia/packages/Adapt/UtItS/src/Adapt.jl:40 within `adapt`
     ││┌ @ /home/pxl-th/.julia/packages/Adapt/UtItS/src/Adapt.jl:57 within `adapt_structure`
     │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/ROCKernels.jl:189 within `adapt_storage`
     ││││┌ @ Base.jl:37 within `getproperty`
1 ───│││││ %1    = Base.getfield(directions, :shape)::Tuple{Int64, Int64}
│    │││││ %2    = Base.getfield(directions, :ptr)::Core.LLVMPtr{Float32, 1}
│    ││││└
│    ││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:121 within `addrspacecast`
│    │││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:121 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
│    ││││││ %3    = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i8 addrspace(4)* @entry(i8 addrspace(1)* %0) #0 {\nentry:\n  %1 = addrspacecast i8 addrspace(1)* %0 to i8 addrspace(4)*\n  ret i8 addrspace(4)* %1\n}\n\nattributes #0 = { alwaysinline }\n", "entry")::Tuple{String, String}
│    ││││││ %4    = Base.llvmcall(%3, Core.LLVMPtr{Float32, 4}, Tuple{Core.LLVMPtr{Float32, 1}}, %2)::Core.LLVMPtr{Float32, 4}
│    ││││└└
│    ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:48 within `ROCDeviceArray` @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:35
│    │││││┌ @ tuple.jl:571 within `prod`
│    ││││││ %5    = Core.getfield(%1, 1)::Int64
│    ││││││ %6    = Core.getfield(%1, 2)::Int64
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %7    = Base.mul_int(%5, %6)::Int64
│    │││││└└
│    │││││ %8    = %new(AMDGPU.Device.ROCDeviceMatrix{Float32, 4}, %1, %4, %7)::AMDGPU.Device.ROCDeviceMatrix{Float32, 4}
│    └└└└└
│     @ /home/pxl-th/.julia/packages/KernelAbstractions/cWlFz/src/macros.jl:89 within `gpu__spherical_harmonics!`
│    ┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/ROCKernels.jl:145 within `#__validindex`
│    │┌ @ /home/pxl-th/.julia/packages/KernelAbstractions/cWlFz/src/compiler.jl:23 within `__iterspace`
│    ││┌ @ Base.jl:37 within `getproperty`
│    │││ %9    = Base.getfield(__ctx__, :iterspace)::KernelAbstractions.NDIteration.NDRange{1, KernelAbstractions.NDIteration.DynamicSize, KernelAbstractions.NDIteration.DynamicSize, CartesianIndices{1, Tuple{Base.OneTo{Int64}}}, CartesianIndices{1, Tuple{Base.OneTo{Int64}}}}
│    │└└
│    │┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:172 within `blockIdx`
│    ││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:95 within `blockIdx_x`
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:93 within `workgroupIdx_x`
│    ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:3 within `_index`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
│    ││││││ %10   = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workgroup.id.x(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nounwind readnone speculatable willreturn\ndeclare i32 @llvm.amdgcn.workgroup.id.x() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nounwind readnone speculatable willreturn }\n\n!0 = !{i32 0, i32 -2}\n", "entry")::Tuple{String, String}
│    ││││││ %11   = Base.llvmcall(%10, UInt32, Tuple{})::UInt32
│    ││││└└
│    ││││┌ @ int.jl:1042 within `+` @ int.jl:87
│    │││││ %12   = Base.add_int(%11, 0x00000001)::UInt32
│    ││└└└
│    ││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:95 within `blockIdx_y`
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:93 within `workgroupIdx_y`
│    ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:3 within `_index`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
│    ││││││ %13   = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workgroup.id.y(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nounwind readnone speculatable willreturn\ndeclare i32 @llvm.amdgcn.workgroup.id.y() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nounwind readnone speculatable willreturn }\n\n!0 = !{i32 0, i32 -2}\n", "entry")::Tuple{String, String}
│    ││││││         Base.llvmcall(%13, UInt32, Tuple{})::UInt32
│    ││└└└└
│    ││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:95 within `blockIdx_z`
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:93 within `workgroupIdx_z`
│    ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:3 within `_index`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
│    ││││││ %15   = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workgroup.id.z(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nounwind readnone speculatable willreturn\ndeclare i32 @llvm.amdgcn.workgroup.id.z() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nounwind readnone speculatable willreturn }\n\n!0 = !{i32 0, i32 -2}\n", "entry")::Tuple{String, String}
│    ││││││         Base.llvmcall(%15, UInt32, Tuple{})::UInt32
│    │└└└└└
│    │┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:164 within `threadIdx`
│    ││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:89 within `threadIdx_x`
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
│    ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:3 within `_index`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
│    ││││││ %17   = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workitem.id.x(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nounwind readnone speculatable willreturn\ndeclare i32 @llvm.amdgcn.workitem.id.x() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nounwind readnone speculatable willreturn }\n\n!0 = !{i32 0, i32 1023}\n", "entry")::Tuple{String, String}
│    ││││││ %18   = Base.llvmcall(%17, UInt32, Tuple{})::UInt32
│    ││││└└
│    ││││┌ @ int.jl:1042 within `+` @ int.jl:87
│    │││││ %19   = Base.add_int(%18, 0x00000001)::UInt32
│    ││└└└
│    ││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:89 within `threadIdx_y`
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
│    ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:3 within `_index`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
│    ││││││ %20   = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workitem.id.y(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nounwind readnone speculatable willreturn\ndeclare i32 @llvm.amdgcn.workitem.id.y() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nounwind readnone speculatable willreturn }\n\n!0 = !{i32 0, i32 1023}\n", "entry")::Tuple{String, String}
│    ││││││         Base.llvmcall(%20, UInt32, Tuple{})::UInt32
│    ││└└└└
│    ││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:89 within `threadIdx_z`
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
│    ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:3 within `_index`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
│    ││││││ %22   = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workitem.id.z(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nounwind readnone speculatable willreturn\ndeclare i32 @llvm.amdgcn.workitem.id.z() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nounwind readnone speculatable willreturn }\n\n!0 = !{i32 0, i32 1023}\n", "entry")::Tuple{String, String}
│    ││││││         Base.llvmcall(%22, UInt32, Tuple{})::UInt32
│    │└└└└└
│    │┌ @ /home/pxl-th/.julia/packages/KernelAbstractions/cWlFz/src/nditeration.jl:84 within `expand`
│    ││┌ @ /home/pxl-th/.julia/packages/KernelAbstractions/cWlFz/src/nditeration.jl:64 within `blocks`
│    │││┌ @ Base.jl:37 within `getproperty`
│    ││││ %24   = Base.getfield(%9, :blocks)::CartesianIndices{1, Tuple{Base.OneTo{Int64}}}
│    ││└└
│    ││┌ @ abstractarray.jl:1294 within `getindex`
│    │││┌ @ indices.jl:350 within `to_indices` @ indices.jl:354
│    ││││┌ @ indices.jl:359 within `_to_indices1`
│    │││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    ││││││┌ @ number.jl:7 within `convert`
│    │││││││┌ @ boot.jl:784 within `Int64`
│    ││││││││┌ @ boot.jl:708 within `toInt64`
│    │││││││││ %25   = Core.zext_int(Core.Int64, %12)::Int64
│    │││└└└└└└
│    │││┌ @ abstractarray.jl:1344 within `_getindex`
│    ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/quirks.jl:55 within `#getindex`
└────│││││         goto #6 if not false
     │││││┌ @ abstractarray.jl:707 within `checkbounds`
2 ───││││││ %27   = Core.tuple(%25)::Tuple{Int64}
│    ││││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│    ││││││┌ @ abstractarray.jl:382 within `eachindex`
│    │││││││┌ @ abstractarray.jl:133 within `axes1`
│    ││││││││┌ @ multidimensional.jl:336 within `axes`
│    │││││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││││ %28   = Base.getfield(%24, :indices)::Tuple{Base.OneTo{Int64}}
│    │││││││││└
│    │││││││││┌ @ tuple.jl:273 within `map`
│    ││││││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││││││ %29   = Base.getfield(%28, 1, true)::Base.OneTo{Int64}
│    ││││││││││└
│    ││││││││││┌ @ abstractarray.jl:133 within `axes1`
│    │││││││││││┌ @ range.jl:696 within `axes`
│    ││││││││││││┌ @ range.jl:769 within `length`
│    │││││││││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││││││││ %30   = Base.getfield(%29, :stop)::Int64
│    ││││││││││││└└
│    ││││││││││││┌ @ range.jl:459 within `oneto`
│    │││││││││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││││││││┌ @ int.jl:83 within `<`
│    ││││││││││││││││ %31   = Base.slt_int(%30, 0)::Bool
│    │││││││││││││││└
│    │││││││││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││││││││ %32   = Core.ifelse(%31, 0, %30)::Int64
│    ││││││└└└└└└└└└└
│    ││││││┌ @ abstractarray.jl:768 within `checkindex`
│    │││││││┌ @ int.jl:488 within `<=`
│    ││││││││ %33   = Base.sle_int(1, %25)::Bool
│    ││││││││ %34   = Base.sle_int(%25, %32)::Bool
│    │││││││└
│    │││││││┌ @ bool.jl:38 within `&`
│    ││││││││ %35   = Base.and_int(%33, %34)::Bool
│    ││││││└└
│    ││││││ @ abstractarray.jl:709 within `checkbounds`
└────││││││         goto #4 if not %35
     ││││││ @ abstractarray.jl:710 within `checkbounds`
3 ───││││││         goto #5
     ││││││ @ abstractarray.jl:709 within `checkbounds`
4 ───││││││         invoke Base.throw_boundserror(%24::CartesianIndices{1, Tuple{Base.OneTo{Int64}}}, %27::Tuple{Int64})::Union{}
└────││││││         unreachable
5 ───││││││         nothing::Nothing
     │││││└
     │││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/quirks.jl:56 within `#getindex`
     │││││┌ @ Base.jl:37 within `getproperty`
6 ┄──││││││ %41   = Base.getfield(%24, :indices)::Tuple{Base.OneTo{Int64}}
│    │││││└
│    │││││┌ @ tuple.jl:298 within `map`
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %42   = Base.getfield(%41, 1, true)::Base.OneTo{Int64}
│    ││││││└
│    ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/quirks.jl:57 within `#45`
│    │││││││┌ @ range.jl:922 within `getindex`
└────││││││││         goto #10 if not false
     ││││││││┌ @ operators.jl:369 within `>`
     │││││││││┌ @ int.jl:83 within `<`
7 ───││││││││││ %44   = Base.slt_int(0, %25)::Bool
│    ││││││││└└
│    ││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││ %45   = Base.getfield(%42, :stop)::Int64
│    ││││││││└
│    ││││││││┌ @ int.jl:488 within `<=`
│    │││││││││ %46   = Base.sle_int(%25, %45)::Bool
│    ││││││││└
│    ││││││││┌ @ bool.jl:38 within `&`
│    │││││││││ %47   = Base.and_int(%44, %46)::Bool
│    ││││││││└
└────││││││││         goto #9 if not %47
8 ───││││││││         goto #10
9 ───││││││││         invoke Base.throw_boundserror(%42::Base.OneTo{Int64}, %25::Int64)::Union{}
└────││││││││         unreachable
     ││││││││ @ range.jl:923 within `getindex`
10 ┄─││││││││         goto #11
     │││││││└
11 ──│││││││         goto #12
     ││││││└
12 ──││││││         goto #13
     │││││└
     │││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/quirks.jl:59 within `#getindex`
13 ──│││││         goto #14
     ││││└
14 ──││││         goto #15
     │││└
15 ──│││         goto #16
     ││└
     ││┌ @ /home/pxl-th/.julia/packages/KernelAbstractions/cWlFz/src/nditeration.jl:62 within `workitems`
     │││┌ @ Base.jl:37 within `getproperty`
16 ──││││ %58   = Base.getfield(%9, :workitems)::CartesianIndices{1, Tuple{Base.OneTo{Int64}}}
│    ││└└
│    ││┌ @ abstractarray.jl:1294 within `getindex`
│    │││┌ @ indices.jl:350 within `to_indices` @ indices.jl:354
│    ││││┌ @ indices.jl:359 within `_to_indices1`
│    │││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    ││││││┌ @ number.jl:7 within `convert`
│    │││││││┌ @ boot.jl:784 within `Int64`
│    ││││││││┌ @ boot.jl:708 within `toInt64`
│    │││││││││ %59   = Core.zext_int(Core.Int64, %19)::Int64
│    │││└└└└└└
│    │││┌ @ abstractarray.jl:1344 within `_getindex`
│    ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/quirks.jl:55 within `#getindex`
└────│││││         goto #21 if not false
     │││││┌ @ abstractarray.jl:707 within `checkbounds`
17 ──││││││ %61   = Core.tuple(%59)::Tuple{Int64}
│    ││││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│    ││││││┌ @ abstractarray.jl:382 within `eachindex`
│    │││││││┌ @ abstractarray.jl:133 within `axes1`
│    ││││││││┌ @ multidimensional.jl:336 within `axes`
│    │││││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││││ %62   = Base.getfield(%58, :indices)::Tuple{Base.OneTo{Int64}}
│    │││││││││└
│    │││││││││┌ @ tuple.jl:273 within `map`
│    ││││││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││││││ %63   = Base.getfield(%62, 1, true)::Base.OneTo{Int64}
│    ││││││││││└
│    ││││││││││┌ @ abstractarray.jl:133 within `axes1`
│    │││││││││││┌ @ range.jl:696 within `axes`
│    ││││││││││││┌ @ range.jl:769 within `length`
│    │││││││││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││││││││ %64   = Base.getfield(%63, :stop)::Int64
│    ││││││││││││└└
│    ││││││││││││┌ @ range.jl:459 within `oneto`
│    │││││││││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││││││││┌ @ int.jl:83 within `<`
│    ││││││││││││││││ %65   = Base.slt_int(%64, 0)::Bool
│    │││││││││││││││└
│    │││││││││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││││││││ %66   = Core.ifelse(%65, 0, %64)::Int64
│    ││││││└└└└└└└└└└
│    ││││││┌ @ abstractarray.jl:768 within `checkindex`
│    │││││││┌ @ int.jl:488 within `<=`
│    ││││││││ %67   = Base.sle_int(1, %59)::Bool
│    ││││││││ %68   = Base.sle_int(%59, %66)::Bool
│    │││││││└
│    │││││││┌ @ bool.jl:38 within `&`
│    ││││││││ %69   = Base.and_int(%67, %68)::Bool
│    ││││││└└
│    ││││││ @ abstractarray.jl:709 within `checkbounds`
└────││││││         goto #19 if not %69
     ││││││ @ abstractarray.jl:710 within `checkbounds`
18 ──││││││         goto #20
     ││││││ @ abstractarray.jl:709 within `checkbounds`
19 ──││││││         invoke Base.throw_boundserror(%58::CartesianIndices{1, Tuple{Base.OneTo{Int64}}}, %61::Tuple{Int64})::Union{}
└────││││││         unreachable
20 ──││││││         nothing::Nothing
     │││││└
     │││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/quirks.jl:56 within `#getindex`
     │││││┌ @ Base.jl:37 within `getproperty`
21 ┄─││││││ %75   = Base.getfield(%58, :indices)::Tuple{Base.OneTo{Int64}}
│    │││││└
│    │││││┌ @ tuple.jl:298 within `map`
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %76   = Base.getfield(%75, 1, true)::Base.OneTo{Int64}
│    ││││││└
│    ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/quirks.jl:57 within `#45`
│    │││││││┌ @ range.jl:922 within `getindex`
└────││││││││         goto #25 if not false
     ││││││││┌ @ operators.jl:369 within `>`
     │││││││││┌ @ int.jl:83 within `<`
22 ──││││││││││ %78   = Base.slt_int(0, %59)::Bool
│    ││││││││└└
│    ││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││ %79   = Base.getfield(%76, :stop)::Int64
│    ││││││││└
│    ││││││││┌ @ int.jl:488 within `<=`
│    │││││││││ %80   = Base.sle_int(%59, %79)::Bool
│    ││││││││└
│    ││││││││┌ @ bool.jl:38 within `&`
│    │││││││││ %81   = Base.and_int(%78, %80)::Bool
│    ││││││││└
└────││││││││         goto #24 if not %81
23 ──││││││││         goto #25
24 ──││││││││         invoke Base.throw_boundserror(%76::Base.OneTo{Int64}, %59::Int64)::Union{}
└────││││││││         unreachable
     ││││││││ @ range.jl:923 within `getindex`
25 ┄─││││││││         goto #26
     │││││││└
26 ──│││││││         goto #27
     ││││││└
27 ──││││││         goto #28
     │││││└
     │││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/quirks.jl:59 within `#getindex`
28 ──│││││         goto #29
     ││││└
29 ──││││         goto #30
     │││└
30 ──│││         goto #31
     ││└
     ││ @ /home/pxl-th/.julia/packages/KernelAbstractions/cWlFz/src/nditeration.jl:84 within `expand` @ /home/pxl-th/.julia/packages/KernelAbstractions/cWlFz/src/nditeration.jl:74
     ││┌ @ ntuple.jl:48 within `ntuple`
     │││┌ @ /home/pxl-th/.julia/packages/KernelAbstractions/cWlFz/src/nditeration.jl:76 within `#1`
     ││││┌ @ /home/pxl-th/.julia/packages/KernelAbstractions/cWlFz/src/nditeration.jl:62 within `workitems`
     │││││┌ @ Base.jl:37 within `getproperty`
31 ──││││││ %92   = Base.getfield(%9, :workitems)::CartesianIndices{1, Tuple{Base.OneTo{Int64}}}
│    ││││└└
│    ││││┌ @ abstractarray.jl:42 within `size` @ multidimensional.jl:447
│    │││││┌ @ Base.jl:37 within `getproperty`
│    ││││││ %93   = Base.getfield(%92, :indices)::Tuple{Base.OneTo{Int64}}
│    │││││└
│    │││││┌ @ tuple.jl:273 within `map`
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %94   = Base.getfield(%93, 1, true)::Base.OneTo{Int64}
│    ││││││└
│    ││││││┌ @ range.jl:769 within `length`
│    │││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││ %95   = Base.getfield(%94, :stop)::Int64
│    ││││└└└└
│    ││││ @ /home/pxl-th/.julia/packages/KernelAbstractions/cWlFz/src/nditeration.jl:78 within `#1`
│    ││││┌ @ int.jl:86 within `-`
│    │││││ %96   = Base.sub_int(%25, 1)::Int64
│    ││││└
│    ││││┌ @ int.jl:88 within `*`
│    │││││ %97   = Base.mul_int(%96, %95)::Int64
│    ││││└
│    ││││┌ @ int.jl:87 within `+`
│    │││││ %98   = Base.add_int(%97, %59)::Int64
│    ││└└└
│    ││ @ /home/pxl-th/.julia/packages/KernelAbstractions/cWlFz/src/nditeration.jl:84 within `expand`
└────││         goto #32
     │└
     │ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/ROCKernels.jl:146 within `#__validindex`
     │┌ @ /home/pxl-th/.julia/packages/KernelAbstractions/cWlFz/src/compiler.jl:28 within `__ndrange`
     ││┌ @ Base.jl:37 within `getproperty`
32 ──│││ %100  = Base.getfield(__ctx__, :ndrange)::CartesianIndices{1, Tuple{Base.OneTo{Int64}}}
│    │└└
│    │┌ @ multidimensional.jl:465 within `in`
│    ││┌ @ Base.jl:37 within `getproperty`
│    │││ %101  = Base.getfield(%100, :indices)::Tuple{Base.OneTo{Int64}}
│    ││└
│    ││┌ @ tuple.jl:298 within `map`
│    │││┌ @ tuple.jl:29 within `getindex`
│    ││││ %102  = Base.getfield(%101, 1, true)::Base.OneTo{Int64}
│    │││└
│    │││┌ @ range.jl:1413 within `in`
│    ││││┌ @ int.jl:488 within `<=`
│    │││││ %103  = Base.sle_int(1, %98)::Bool
│    ││││└
│    ││││┌ @ range.jl:829 within `last`
│    │││││┌ @ Base.jl:37 within `getproperty`
│    ││││││ %104  = Base.getfield(%102, :stop)::Int64
│    ││││└└
│    ││││┌ @ int.jl:488 within `<=`
│    │││││ %105  = Base.sle_int(%98, %104)::Bool
│    ││││└
│    ││││┌ @ bool.jl:38 within `&`
│    │││││ %106  = Base.and_int(%103, %105)::Bool
│    │└└└└
└────│         goto #33
     └
33 ──         goto #328 if not %106
      @ /home/pxl-th/.julia/packages/KernelAbstractions/cWlFz/src/macros.jl:90 within `gpu__spherical_harmonics!`
     ┌ @ /home/pxl-th/code/Nerf.jl/src/encoding/spherical_harmonics.jl:30 within `macro expansion`
     │┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/ROCKernels.jl:126 within `#__index_Global_Linear`
     ││┌ @ /home/pxl-th/.julia/packages/KernelAbstractions/cWlFz/src/compiler.jl:23 within `__iterspace`
     │││┌ @ Base.jl:37 within `getproperty`
34 ──││││ %109  = Base.getfield(__ctx__, :iterspace)::KernelAbstractions.NDIteration.NDRange{1, KernelAbstractions.NDIteration.DynamicSize, KernelAbstractions.NDIteration.DynamicSize, CartesianIndices{1, Tuple{Base.OneTo{Int64}}}, CartesianIndices{1, Tuple{Base.OneTo{Int64}}}}
│    ││└└
│    ││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:172 within `blockIdx`
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:95 within `blockIdx_x`
│    ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:93 within `workgroupIdx_x`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:3 within `_index`
│    ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
│    │││││││ %110  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workgroup.id.x(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nounwind readnone speculatable willreturn\ndeclare i32 @llvm.amdgcn.workgroup.id.x() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nounwind readnone speculatable willreturn }\n\n!0 = !{i32 0, i32 -2}\n", "entry")::Tuple{String, String}
│    │││││││ %111  = Base.llvmcall(%110, UInt32, Tuple{})::UInt32
│    │││││└└
│    │││││┌ @ int.jl:1042 within `+` @ int.jl:87
│    ││││││ %112  = Base.add_int(%111, 0x00000001)::UInt32
│    │││└└└
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:95 within `blockIdx_y`
│    ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:93 within `workgroupIdx_y`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:3 within `_index`
│    ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
│    │││││││ %113  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workgroup.id.y(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nounwind readnone speculatable willreturn\ndeclare i32 @llvm.amdgcn.workgroup.id.y() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nounwind readnone speculatable willreturn }\n\n!0 = !{i32 0, i32 -2}\n", "entry")::Tuple{String, String}
│    │││││││         Base.llvmcall(%113, UInt32, Tuple{})::UInt32
│    │││└└└└
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:95 within `blockIdx_z`
│    ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:93 within `workgroupIdx_z`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:3 within `_index`
│    ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
│    │││││││ %115  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workgroup.id.z(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nounwind readnone speculatable willreturn\ndeclare i32 @llvm.amdgcn.workgroup.id.z() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nounwind readnone speculatable willreturn }\n\n!0 = !{i32 0, i32 -2}\n", "entry")::Tuple{String, String}
│    │││││││         Base.llvmcall(%115, UInt32, Tuple{})::UInt32
│    ││└└└└└
│    ││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:164 within `threadIdx`
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:89 within `threadIdx_x`
│    ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:87 within `workitemIdx_x`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:3 within `_index`
│    ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
│    │││││││ %117  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workitem.id.x(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nounwind readnone speculatable willreturn\ndeclare i32 @llvm.amdgcn.workitem.id.x() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nounwind readnone speculatable willreturn }\n\n!0 = !{i32 0, i32 1023}\n", "entry")::Tuple{String, String}
│    │││││││ %118  = Base.llvmcall(%117, UInt32, Tuple{})::UInt32
│    │││││└└
│    │││││┌ @ int.jl:1042 within `+` @ int.jl:87
│    ││││││ %119  = Base.add_int(%118, 0x00000001)::UInt32
│    │││└└└
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:89 within `threadIdx_y`
│    ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:87 within `workitemIdx_y`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:3 within `_index`
│    ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
│    │││││││ %120  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workitem.id.y(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nounwind readnone speculatable willreturn\ndeclare i32 @llvm.amdgcn.workitem.id.y() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nounwind readnone speculatable willreturn }\n\n!0 = !{i32 0, i32 1023}\n", "entry")::Tuple{String, String}
│    │││││││         Base.llvmcall(%120, UInt32, Tuple{})::UInt32
│    │││└└└└
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:89 within `threadIdx_z`
│    ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:87 within `workitemIdx_z`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:3 within `_index`
│    ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/indexing.jl:3 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
│    │││││││ %122  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine i32 @entry() #0 {\nentry:\n  %0 = call i32 @llvm.amdgcn.workitem.id.z(), !range !0\n  ret i32 %0\n}\n\n; Function Attrs: nounwind readnone speculatable willreturn\ndeclare i32 @llvm.amdgcn.workitem.id.z() #1\n\nattributes #0 = { alwaysinline }\nattributes #1 = { nounwind readnone speculatable willreturn }\n\n!0 = !{i32 0, i32 1023}\n", "entry")::Tuple{String, String}
│    │││││││         Base.llvmcall(%122, UInt32, Tuple{})::UInt32
│    ││└└└└└
│    ││┌ @ /home/pxl-th/.julia/packages/KernelAbstractions/cWlFz/src/nditeration.jl:84 within `expand`
│    │││┌ @ /home/pxl-th/.julia/packages/KernelAbstractions/cWlFz/src/nditeration.jl:64 within `blocks`
│    ││││┌ @ Base.jl:37 within `getproperty`
│    │││││ %124  = Base.getfield(%109, :blocks)::CartesianIndices{1, Tuple{Base.OneTo{Int64}}}
│    │││└└
│    │││┌ @ abstractarray.jl:1294 within `getindex`
│    ││││┌ @ indices.jl:350 within `to_indices` @ indices.jl:354
│    │││││┌ @ indices.jl:359 within `_to_indices1`
│    ││││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││││┌ @ number.jl:7 within `convert`
│    ││││││││┌ @ boot.jl:784 within `Int64`
│    │││││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││││ %125  = Core.zext_int(Core.Int64, %112)::Int64
│    ││││└└└└└└
│    ││││┌ @ abstractarray.jl:1344 within `_getindex`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/quirks.jl:55 within `#getindex`
└────││││││         goto #39 if not false
     ││││││┌ @ abstractarray.jl:707 within `checkbounds`
35 ──│││││││ %127  = Core.tuple(%125)::Tuple{Int64}
│    │││││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│    │││││││┌ @ abstractarray.jl:382 within `eachindex`
│    ││││││││┌ @ abstractarray.jl:133 within `axes1`
│    │││││││││┌ @ multidimensional.jl:336 within `axes`
│    ││││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││││ %128  = Base.getfield(%124, :indices)::Tuple{Base.OneTo{Int64}}
│    ││││││││││└
│    ││││││││││┌ @ tuple.jl:273 within `map`
│    │││││││││││┌ @ tuple.jl:29 within `getindex`
│    ││││││││││││ %129  = Base.getfield(%128, 1, true)::Base.OneTo{Int64}
│    │││││││││││└
│    │││││││││││┌ @ abstractarray.jl:133 within `axes1`
│    ││││││││││││┌ @ range.jl:696 within `axes`
│    │││││││││││││┌ @ range.jl:769 within `length`
│    ││││││││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││││││││ %130  = Base.getfield(%129, :stop)::Int64
│    │││││││││││││└└
│    │││││││││││││┌ @ range.jl:459 within `oneto`
│    ││││││││││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    │││││││││││││││┌ @ promotion.jl:510 within `max`
│    ││││││││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││││││││ %131  = Base.slt_int(%130, 0)::Bool
│    ││││││││││││││││└
│    ││││││││││││││││┌ @ essentials.jl:575 within `ifelse`
│    │││││││││││││││││ %132  = Core.ifelse(%131, 0, %130)::Int64
│    │││││││└└└└└└└└└└
│    │││││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││││┌ @ int.jl:488 within `<=`
│    │││││││││ %133  = Base.sle_int(1, %125)::Bool
│    │││││││││ %134  = Base.sle_int(%125, %132)::Bool
│    ││││││││└
│    ││││││││┌ @ bool.jl:38 within `&`
│    │││││││││ %135  = Base.and_int(%133, %134)::Bool
│    │││││││└└
│    │││││││ @ abstractarray.jl:709 within `checkbounds`
└────│││││││         goto #37 if not %135
     │││││││ @ abstractarray.jl:710 within `checkbounds`
36 ──│││││││         goto #38
     │││││││ @ abstractarray.jl:709 within `checkbounds`
37 ──│││││││         invoke Base.throw_boundserror(%124::CartesianIndices{1, Tuple{Base.OneTo{Int64}}}, %127::Tuple{Int64})::Union{}
└────│││││││         unreachable
38 ──│││││││         nothing::Nothing
     ││││││└
     ││││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/quirks.jl:56 within `#getindex`
     ││││││┌ @ Base.jl:37 within `getproperty`
39 ┄─│││││││ %141  = Base.getfield(%124, :indices)::Tuple{Base.OneTo{Int64}}
│    ││││││└
│    ││││││┌ @ tuple.jl:298 within `map`
│    │││││││┌ @ tuple.jl:29 within `getindex`
│    ││││││││ %142  = Base.getfield(%141, 1, true)::Base.OneTo{Int64}
│    │││││││└
│    │││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/quirks.jl:57 within `#45`
│    ││││││││┌ @ range.jl:922 within `getindex`
└────│││││││││         goto #43 if not false
     │││││││││┌ @ operators.jl:369 within `>`
     ││││││││││┌ @ int.jl:83 within `<`
40 ──│││││││││││ %144  = Base.slt_int(0, %125)::Bool
│    │││││││││└└
│    │││││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││││ %145  = Base.getfield(%142, :stop)::Int64
│    │││││││││└
│    │││││││││┌ @ int.jl:488 within `<=`
│    ││││││││││ %146  = Base.sle_int(%125, %145)::Bool
│    │││││││││└
│    │││││││││┌ @ bool.jl:38 within `&`
│    ││││││││││ %147  = Base.and_int(%144, %146)::Bool
│    │││││││││└
└────│││││││││         goto #42 if not %147
41 ──│││││││││         goto #43
42 ──│││││││││         invoke Base.throw_boundserror(%142::Base.OneTo{Int64}, %125::Int64)::Union{}
└────│││││││││         unreachable
     │││││││││ @ range.jl:923 within `getindex`
43 ┄─│││││││││         goto #44
     ││││││││└
44 ──││││││││         goto #45
     │││││││└
45 ──│││││││         goto #46
     ││││││└
     ││││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/quirks.jl:59 within `#getindex`
46 ──││││││         goto #47
     │││││└
47 ──│││││         goto #48
     ││││└
48 ──││││         goto #49
     │││└
     │││┌ @ /home/pxl-th/.julia/packages/KernelAbstractions/cWlFz/src/nditeration.jl:62 within `workitems`
     ││││┌ @ Base.jl:37 within `getproperty`
49 ──│││││ %158  = Base.getfield(%109, :workitems)::CartesianIndices{1, Tuple{Base.OneTo{Int64}}}
│    │││└└
│    │││┌ @ abstractarray.jl:1294 within `getindex`
│    ││││┌ @ indices.jl:350 within `to_indices` @ indices.jl:354
│    │││││┌ @ indices.jl:359 within `_to_indices1`
│    ││││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││││┌ @ number.jl:7 within `convert`
│    ││││││││┌ @ boot.jl:784 within `Int64`
│    │││││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││││ %159  = Core.zext_int(Core.Int64, %119)::Int64
│    ││││└└└└└└
│    ││││┌ @ abstractarray.jl:1344 within `_getindex`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/quirks.jl:55 within `#getindex`
└────││││││         goto #54 if not false
     ││││││┌ @ abstractarray.jl:707 within `checkbounds`
50 ──│││││││ %161  = Core.tuple(%159)::Tuple{Int64}
│    │││││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│    │││││││┌ @ abstractarray.jl:382 within `eachindex`
│    ││││││││┌ @ abstractarray.jl:133 within `axes1`
│    │││││││││┌ @ multidimensional.jl:336 within `axes`
│    ││││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││││ %162  = Base.getfield(%158, :indices)::Tuple{Base.OneTo{Int64}}
│    ││││││││││└
│    ││││││││││┌ @ tuple.jl:273 within `map`
│    │││││││││││┌ @ tuple.jl:29 within `getindex`
│    ││││││││││││ %163  = Base.getfield(%162, 1, true)::Base.OneTo{Int64}
│    │││││││││││└
│    │││││││││││┌ @ abstractarray.jl:133 within `axes1`
│    ││││││││││││┌ @ range.jl:696 within `axes`
│    │││││││││││││┌ @ range.jl:769 within `length`
│    ││││││││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││││││││ %164  = Base.getfield(%163, :stop)::Int64
│    │││││││││││││└└
│    │││││││││││││┌ @ range.jl:459 within `oneto`
│    ││││││││││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    │││││││││││││││┌ @ promotion.jl:510 within `max`
│    ││││││││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││││││││ %165  = Base.slt_int(%164, 0)::Bool
│    ││││││││││││││││└
│    ││││││││││││││││┌ @ essentials.jl:575 within `ifelse`
│    │││││││││││││││││ %166  = Core.ifelse(%165, 0, %164)::Int64
│    │││││││└└└└└└└└└└
│    │││││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││││┌ @ int.jl:488 within `<=`
│    │││││││││ %167  = Base.sle_int(1, %159)::Bool
│    │││││││││ %168  = Base.sle_int(%159, %166)::Bool
│    ││││││││└
│    ││││││││┌ @ bool.jl:38 within `&`
│    │││││││││ %169  = Base.and_int(%167, %168)::Bool
│    │││││││└└
│    │││││││ @ abstractarray.jl:709 within `checkbounds`
└────│││││││         goto #52 if not %169
     │││││││ @ abstractarray.jl:710 within `checkbounds`
51 ──│││││││         goto #53
     │││││││ @ abstractarray.jl:709 within `checkbounds`
52 ──│││││││         invoke Base.throw_boundserror(%158::CartesianIndices{1, Tuple{Base.OneTo{Int64}}}, %161::Tuple{Int64})::Union{}
└────│││││││         unreachable
53 ──│││││││         nothing::Nothing
     ││││││└
     ││││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/quirks.jl:56 within `#getindex`
     ││││││┌ @ Base.jl:37 within `getproperty`
54 ┄─│││││││ %175  = Base.getfield(%158, :indices)::Tuple{Base.OneTo{Int64}}
│    ││││││└
│    ││││││┌ @ tuple.jl:298 within `map`
│    │││││││┌ @ tuple.jl:29 within `getindex`
│    ││││││││ %176  = Base.getfield(%175, 1, true)::Base.OneTo{Int64}
│    │││││││└
│    │││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/quirks.jl:57 within `#45`
│    ││││││││┌ @ range.jl:922 within `getindex`
└────│││││││││         goto #58 if not false
     │││││││││┌ @ operators.jl:369 within `>`
     ││││││││││┌ @ int.jl:83 within `<`
55 ──│││││││││││ %178  = Base.slt_int(0, %159)::Bool
│    │││││││││└└
│    │││││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││││ %179  = Base.getfield(%176, :stop)::Int64
│    │││││││││└
│    │││││││││┌ @ int.jl:488 within `<=`
│    ││││││││││ %180  = Base.sle_int(%159, %179)::Bool
│    │││││││││└
│    │││││││││┌ @ bool.jl:38 within `&`
│    ││││││││││ %181  = Base.and_int(%178, %180)::Bool
│    │││││││││└
└────│││││││││         goto #57 if not %181
56 ──│││││││││         goto #58
57 ──│││││││││         invoke Base.throw_boundserror(%176::Base.OneTo{Int64}, %159::Int64)::Union{}
└────│││││││││         unreachable
     │││││││││ @ range.jl:923 within `getindex`
58 ┄─│││││││││         goto #59
     ││││││││└
59 ──││││││││         goto #60
     │││││││└
60 ──│││││││         goto #61
     ││││││└
     ││││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/quirks.jl:59 within `#getindex`
61 ──││││││         goto #62
     │││││└
62 ──│││││         goto #63
     ││││└
63 ──││││         goto #64
     │││└
     │││ @ /home/pxl-th/.julia/packages/KernelAbstractions/cWlFz/src/nditeration.jl:84 within `expand` @ /home/pxl-th/.julia/packages/KernelAbstractions/cWlFz/src/nditeration.jl:74
     │││┌ @ ntuple.jl:48 within `ntuple`
     ││││┌ @ /home/pxl-th/.julia/packages/KernelAbstractions/cWlFz/src/nditeration.jl:76 within `#1`
     │││││┌ @ /home/pxl-th/.julia/packages/KernelAbstractions/cWlFz/src/nditeration.jl:62 within `workitems`
     ││││││┌ @ Base.jl:37 within `getproperty`
64 ──│││││││ %192  = Base.getfield(%109, :workitems)::CartesianIndices{1, Tuple{Base.OneTo{Int64}}}
│    │││││└└
│    │││││┌ @ abstractarray.jl:42 within `size` @ multidimensional.jl:447
│    ││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││ %193  = Base.getfield(%192, :indices)::Tuple{Base.OneTo{Int64}}
│    ││││││└
│    ││││││┌ @ tuple.jl:273 within `map`
│    │││││││┌ @ tuple.jl:29 within `getindex`
│    ││││││││ %194  = Base.getfield(%193, 1, true)::Base.OneTo{Int64}
│    │││││││└
│    │││││││┌ @ range.jl:769 within `length`
│    ││││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││││ %195  = Base.getfield(%194, :stop)::Int64
│    │││││└└└└
│    │││││ @ /home/pxl-th/.julia/packages/KernelAbstractions/cWlFz/src/nditeration.jl:78 within `#1`
│    │││││┌ @ int.jl:86 within `-`
│    ││││││ %196  = Base.sub_int(%125, 1)::Int64
│    │││││└
│    │││││┌ @ int.jl:88 within `*`
│    ││││││ %197  = Base.mul_int(%196, %195)::Int64
│    │││││└
│    │││││┌ @ int.jl:87 within `+`
│    ││││││ %198  = Base.add_int(%197, %159)::Int64
│    │││└└└
│    │││ @ /home/pxl-th/.julia/packages/KernelAbstractions/cWlFz/src/nditeration.jl:84 within `expand`
└────│││         goto #65
     ││└
     ││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/ROCKernels.jl:128 within `#__index_Global_Linear`
     ││┌ @ /home/pxl-th/.julia/packages/KernelAbstractions/cWlFz/src/compiler.jl:28 within `__ndrange`
     │││┌ @ Base.jl:37 within `getproperty`
65 ──││││ %200  = Base.getfield(__ctx__, :ndrange)::CartesianIndices{1, Tuple{Base.OneTo{Int64}}}
│    ││└└
│    ││┌ @ multidimensional.jl:548 within `LinearIndices`
│    │││┌ @ Base.jl:37 within `getproperty`
│    ││││ %201  = Base.getfield(%200, :indices)::Tuple{Base.OneTo{Int64}}
│    │││└
│    │││ @ multidimensional.jl:548 within `LinearIndices` @ indices.jl:476
│    │││ %202  = %new(LinearIndices{1, Tuple{Base.OneTo{Int64}}}, %201)::LinearIndices{1, Tuple{Base.OneTo{Int64}}}
│    ││└
│    ││┌ @ abstractarray.jl:1294 within `getindex`
│    │││┌ @ abstractarray.jl:1322 within `_getindex`
│    ││││┌ @ indices.jl:509 within `getindex`
└────│││││         goto #70 if not false
     │││││┌ @ abstractarray.jl:707 within `checkbounds`
66 ──││││││ %204  = Core.tuple(%198)::Tuple{Int64}
│    ││││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│    ││││││┌ @ abstractarray.jl:382 within `eachindex`
│    │││││││┌ @ abstractarray.jl:133 within `axes1`
│    ││││││││┌ @ indices.jl:505 within `axes`
│    │││││││││┌ @ tuple.jl:273 within `map`
│    ││││││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││││││ %205  = Base.getfield(%201, 1, true)::Base.OneTo{Int64}
│    ││││││││││└
│    ││││││││││┌ @ abstractarray.jl:133 within `axes1`
│    │││││││││││┌ @ range.jl:696 within `axes`
│    ││││││││││││┌ @ range.jl:769 within `length`
│    │││││││││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││││││││ %206  = Base.getfield(%205, :stop)::Int64
│    ││││││││││││└└
│    ││││││││││││┌ @ range.jl:459 within `oneto`
│    │││││││││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││││││││┌ @ int.jl:83 within `<`
│    ││││││││││││││││ %207  = Base.slt_int(%206, 0)::Bool
│    │││││││││││││││└
│    │││││││││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││││││││ %208  = Core.ifelse(%207, 0, %206)::Int64
│    ││││││└└└└└└└└└└
│    ││││││┌ @ abstractarray.jl:768 within `checkindex`
│    │││││││┌ @ int.jl:488 within `<=`
│    ││││││││ %209  = Base.sle_int(1, %198)::Bool
│    ││││││││ %210  = Base.sle_int(%198, %208)::Bool
│    │││││││└
│    │││││││┌ @ bool.jl:38 within `&`
│    ││││││││ %211  = Base.and_int(%209, %210)::Bool
│    ││││││└└
│    ││││││ @ abstractarray.jl:709 within `checkbounds`
└────││││││         goto #68 if not %211
     ││││││ @ abstractarray.jl:710 within `checkbounds`
67 ──││││││         goto #69
     ││││││ @ abstractarray.jl:709 within `checkbounds`
68 ──││││││         invoke Base.throw_boundserror(%202::LinearIndices{1, Tuple{Base.OneTo{Int64}}}, %204::Tuple{Int64})::Union{}
└────││││││         unreachable
69 ──││││││         nothing::Nothing
     │││││└
     │││││ @ indices.jl:510 within `getindex`
70 ┄─│││││         goto #71
     ││││└
71 ──││││         goto #72
     │││└
72 ──│││         goto #73
     ││└
73 ──││         goto #74
     │└
     │┌ @ number.jl:7 within `convert`
     ││┌ @ boot.jl:788 within `UInt32`
     │││┌ @ boot.jl:748 within `toUInt32`
     ││││┌ @ boot.jl:662 within `checked_trunc_uint`
74 ──│││││ %221  = Core.trunc_int(UInt32, %198)::UInt32
│    │││││ @ boot.jl:663 within `checked_trunc_uint`
│    │││││ %222  = Core.zext_int(Int64, %221)::Int64
│    │││││ @ boot.jl:664 within `checked_trunc_uint`
│    │││││ %223  = Core.eq_int(%198, %222)::Bool
└────│││││         goto #76 if not %223
     │││││ @ boot.jl:665 within `checked_trunc_uint`
75 ──│││││         goto #77
     │││││ @ boot.jl:664 within `checked_trunc_uint`
76 ──│││││         invoke Core.throw_inexacterror(:trunc::Symbol, UInt32::Type{UInt32}, %198::Int64)::Union{}
└────│││││         unreachable
     ││││└
77 ──││││         goto #78
     │││└
78 ──│││         goto #79
     ││└
79 ──││         goto #80
     │└
     │ @ /home/pxl-th/code/Nerf.jl/src/encoding/spherical_harmonics.jl:31 within `macro expansion`
     │┌ @ abstractarray.jl:1294 within `getindex`
     ││┌ @ indices.jl:350 within `to_indices` @ indices.jl:354
     │││┌ @ indices.jl:359 within `_to_indices1`
     ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
     │││││┌ @ number.jl:7 within `convert`
     ││││││┌ @ boot.jl:784 within `Int64`
     │││││││┌ @ boot.jl:708 within `toInt64`
80 ──││││││││ %231  = Core.zext_int(Core.Int64, 0x00000001)::Int64
│    │││└└└└└
│    │││ @ indices.jl:350 within `to_indices` @ indices.jl:355 @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %232  = Core.zext_int(Core.Int64, %221)::Int64
│    ││└└└└└└
│    ││┌ @ abstractarray.jl:1326 within `_getindex`
└────│││         goto #85 if not false
     │││┌ @ abstractarray.jl:707 within `checkbounds`
81 ──││││ %234  = Core.tuple(%231, %232)::Tuple{Int64, Int64}
│    ││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:688
│    ││││┌ @ abstractarray.jl:98 within `axes`
│    │││││┌ @ tuple.jl:274 within `map`
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %235  = Base.getfield(%1, 1, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %236  = Base.slt_int(%235, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %237  = Core.ifelse(%236, 0, %235)::Int64
│    ││││││└└└└
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %238  = Base.getfield(%1, 2, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %239  = Base.slt_int(%238, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %240  = Core.ifelse(%239, 0, %238)::Int64
│    ││││└└└└└└
│    ││││┌ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %241  = Base.sle_int(1, %231)::Bool
│    │││││││ %242  = Base.sle_int(%231, %237)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %243  = Base.and_int(%241, %242)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices` @ abstractarray.jl:735
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %244  = Base.sle_int(1, %232)::Bool
│    │││││││ %245  = Base.sle_int(%232, %240)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %246  = Base.and_int(%244, %245)::Bool
│    │││││└└
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %247  = Base.and_int(%246, true)::Bool
│    │││││└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %248  = Base.and_int(%243, %247)::Bool
│    ││││└└
│    ││││ @ abstractarray.jl:709 within `checkbounds`
└────││││         goto #83 if not %248
     ││││ @ abstractarray.jl:710 within `checkbounds`
82 ──││││         goto #84
     ││││ @ abstractarray.jl:709 within `checkbounds`
83 ──││││         invoke Base.throw_boundserror(%8::AMDGPU.Device.ROCDeviceMatrix{Float32, 4}, %234::Tuple{Int64, Int64})::Union{}
└────││││         unreachable
84 ──││││         nothing::Nothing
     │││└
     │││ @ abstractarray.jl:1327 within `_getindex`
     │││┌ @ abstractarray.jl:1333 within `_to_linear_index`
     ││││┌ @ abstractarray.jl:2933 within `_sub2ind`
     │││││┌ @ abstractarray.jl:98 within `axes`
     ││││││┌ @ tuple.jl:274 within `map`
     │││││││┌ @ tuple.jl:29 within `getindex`
85 ┄─││││││││ %254  = Base.getfield(%1, 1, true)::Int64
│    │││││││└
│    │││││││┌ @ range.jl:459 within `oneto`
│    ││││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    │││││││││┌ @ promotion.jl:510 within `max`
│    ││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││ %255  = Base.slt_int(%254, 0)::Bool
│    ││││││││││└
│    ││││││││││┌ @ essentials.jl:575 within `ifelse`
│    │││││││││││ %256  = Core.ifelse(%255, 0, %254)::Int64
│    │││││└└└└└└
│    │││││ @ abstractarray.jl:2933 within `_sub2ind` @ abstractarray.jl:2949
│    │││││┌ @ abstractarray.jl:2965 within `_sub2ind_recurse`
│    ││││││┌ @ abstractarray.jl:2969 within `nextL`
│    │││││││┌ @ int.jl:88 within `*`
│    ││││││││ %257  = Base.mul_int(1, %256)::Int64
│    ││││││└└
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %258  = Base.sub_int(%231, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %259  = Base.mul_int(%258, 1)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %260  = Base.add_int(1, %259)::Int64
│    ││││││└
│    ││││││ @ abstractarray.jl:2965 within `_sub2ind_recurse` @ abstractarray.jl:2965
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %261  = Base.sub_int(%232, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %262  = Base.mul_int(%261, %257)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %263  = Base.add_int(%260, %262)::Int64
│    │││└└└└
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:82 within `#getindex`
└────││││         goto #90 if not false
     ││││┌ @ abstractarray.jl:707 within `checkbounds`
86 ──│││││ %265  = Core.tuple(%263)::Tuple{Int64}
│    │││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│    │││││┌ @ abstractarray.jl:381 within `eachindex`
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %266  = Base.slt_int(%7, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %267  = Core.ifelse(%266, 0, %7)::Int64
│    │││││└└└└└
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %268  = Base.sle_int(1, %263)::Bool
│    │││││││ %269  = Base.sle_int(%263, %267)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %270  = Base.and_int(%268, %269)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:709 within `checkbounds`
└────│││││         goto #88 if not %270
     │││││ @ abstractarray.jl:710 within `checkbounds`
87 ──│││││         goto #89
     │││││ @ abstractarray.jl:709 within `checkbounds`
88 ──│││││         invoke Base.throw_boundserror(%8::AMDGPU.Device.ROCDeviceMatrix{Float32, 4}, %265::Tuple{Int64})::Union{}
└────│││││         unreachable
89 ──│││││         nothing::Nothing
     ││││└
     ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:84 within `#getindex`
     ││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:85 within `unsafe_load`
     │││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:9 within `pointerref`
     ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:9 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
90 ┄─│││││││ %276  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine float @entry(i8 addrspace(4)* %0, i64 %1) #0 {\nentry:\n  %2 = bitcast i8 addrspace(4)* %0 to float addrspace(4)*\n  %3 = getelementptr inbounds float, float addrspace(4)* %2, i64 %1\n  %4 = load float, float addrspace(4)* %3, align 4, !tbaa !0\n  ret float %4\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(4)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %277  = Base.sub_int(%263, 1)::Int64
│    │││││││└
│    │││││││ %278  = Base.llvmcall(%276, Float32, Tuple{Core.LLVMPtr{Float32, 4}, Int64}, %4, %277)::Float32
│    ││││└└└
└────││││         goto #91
     │││└
     │││ @ abstractarray.jl:1328 within `_getindex`
91 ──│││         goto #92
     ││└
92 ──││         goto #93
     ││┌ @ indices.jl:350 within `to_indices` @ indices.jl:354
     │││┌ @ indices.jl:359 within `_to_indices1`
     ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
     │││││┌ @ number.jl:7 within `convert`
     ││││││┌ @ boot.jl:784 within `Int64`
     │││││││┌ @ boot.jl:708 within `toInt64`
93 ──││││││││ %282  = Core.zext_int(Core.Int64, 0x00000002)::Int64
│    │││└└└└└
│    │││ @ indices.jl:350 within `to_indices` @ indices.jl:355 @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %283  = Core.zext_int(Core.Int64, %221)::Int64
│    ││└└└└└└
│    ││┌ @ abstractarray.jl:1326 within `_getindex`
└────│││         goto #98 if not false
     │││┌ @ abstractarray.jl:707 within `checkbounds`
94 ──││││ %285  = Core.tuple(%282, %283)::Tuple{Int64, Int64}
│    ││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:688
│    ││││┌ @ abstractarray.jl:98 within `axes`
│    │││││┌ @ tuple.jl:274 within `map`
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %286  = Base.getfield(%1, 1, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %287  = Base.slt_int(%286, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %288  = Core.ifelse(%287, 0, %286)::Int64
│    ││││││└└└└
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %289  = Base.getfield(%1, 2, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %290  = Base.slt_int(%289, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %291  = Core.ifelse(%290, 0, %289)::Int64
│    ││││└└└└└└
│    ││││┌ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %292  = Base.sle_int(1, %282)::Bool
│    │││││││ %293  = Base.sle_int(%282, %288)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %294  = Base.and_int(%292, %293)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices` @ abstractarray.jl:735
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %295  = Base.sle_int(1, %283)::Bool
│    │││││││ %296  = Base.sle_int(%283, %291)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %297  = Base.and_int(%295, %296)::Bool
│    │││││└└
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %298  = Base.and_int(%297, true)::Bool
│    │││││└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %299  = Base.and_int(%294, %298)::Bool
│    ││││└└
│    ││││ @ abstractarray.jl:709 within `checkbounds`
└────││││         goto #96 if not %299
     ││││ @ abstractarray.jl:710 within `checkbounds`
95 ──││││         goto #97
     ││││ @ abstractarray.jl:709 within `checkbounds`
96 ──││││         invoke Base.throw_boundserror(%8::AMDGPU.Device.ROCDeviceMatrix{Float32, 4}, %285::Tuple{Int64, Int64})::Union{}
└────││││         unreachable
97 ──││││         nothing::Nothing
     │││└
     │││ @ abstractarray.jl:1327 within `_getindex`
     │││┌ @ abstractarray.jl:1333 within `_to_linear_index`
     ││││┌ @ abstractarray.jl:2933 within `_sub2ind`
     │││││┌ @ abstractarray.jl:98 within `axes`
     ││││││┌ @ tuple.jl:274 within `map`
     │││││││┌ @ tuple.jl:29 within `getindex`
98 ┄─││││││││ %305  = Base.getfield(%1, 1, true)::Int64
│    │││││││└
│    │││││││┌ @ range.jl:459 within `oneto`
│    ││││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    │││││││││┌ @ promotion.jl:510 within `max`
│    ││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││ %306  = Base.slt_int(%305, 0)::Bool
│    ││││││││││└
│    ││││││││││┌ @ essentials.jl:575 within `ifelse`
│    │││││││││││ %307  = Core.ifelse(%306, 0, %305)::Int64
│    │││││└└└└└└
│    │││││ @ abstractarray.jl:2933 within `_sub2ind` @ abstractarray.jl:2949
│    │││││┌ @ abstractarray.jl:2965 within `_sub2ind_recurse`
│    ││││││┌ @ abstractarray.jl:2969 within `nextL`
│    │││││││┌ @ int.jl:88 within `*`
│    ││││││││ %308  = Base.mul_int(1, %307)::Int64
│    ││││││└└
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %309  = Base.sub_int(%282, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %310  = Base.mul_int(%309, 1)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %311  = Base.add_int(1, %310)::Int64
│    ││││││└
│    ││││││ @ abstractarray.jl:2965 within `_sub2ind_recurse` @ abstractarray.jl:2965
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %312  = Base.sub_int(%283, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %313  = Base.mul_int(%312, %308)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %314  = Base.add_int(%311, %313)::Int64
│    │││└└└└
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:82 within `#getindex`
└────││││         goto #103 if not false
     ││││┌ @ abstractarray.jl:707 within `checkbounds`
99 ──│││││ %316  = Core.tuple(%314)::Tuple{Int64}
│    │││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│    │││││┌ @ abstractarray.jl:381 within `eachindex`
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %317  = Base.slt_int(%7, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %318  = Core.ifelse(%317, 0, %7)::Int64
│    │││││└└└└└
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %319  = Base.sle_int(1, %314)::Bool
│    │││││││ %320  = Base.sle_int(%314, %318)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %321  = Base.and_int(%319, %320)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:709 within `checkbounds`
└────│││││         goto #101 if not %321
     │││││ @ abstractarray.jl:710 within `checkbounds`
100 ─│││││         goto #102
     │││││ @ abstractarray.jl:709 within `checkbounds`
101 ─│││││         invoke Base.throw_boundserror(%8::AMDGPU.Device.ROCDeviceMatrix{Float32, 4}, %316::Tuple{Int64})::Union{}
└────│││││         unreachable
102 ─│││││         nothing::Nothing
     ││││└
     ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:84 within `#getindex`
     ││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:85 within `unsafe_load`
     │││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:9 within `pointerref`
     ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:9 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
103 ┄│││││││ %327  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine float @entry(i8 addrspace(4)* %0, i64 %1) #0 {\nentry:\n  %2 = bitcast i8 addrspace(4)* %0 to float addrspace(4)*\n  %3 = getelementptr inbounds float, float addrspace(4)* %2, i64 %1\n  %4 = load float, float addrspace(4)* %3, align 4, !tbaa !0\n  ret float %4\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(4)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %328  = Base.sub_int(%314, 1)::Int64
│    │││││││└
│    │││││││ %329  = Base.llvmcall(%327, Float32, Tuple{Core.LLVMPtr{Float32, 4}, Int64}, %4, %328)::Float32
│    ││││└└└
└────││││         goto #104
     │││└
     │││ @ abstractarray.jl:1328 within `_getindex`
104 ─│││         goto #105
     ││└
105 ─││         goto #106
     ││┌ @ indices.jl:350 within `to_indices` @ indices.jl:354
     │││┌ @ indices.jl:359 within `_to_indices1`
     ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
     │││││┌ @ number.jl:7 within `convert`
     ││││││┌ @ boot.jl:784 within `Int64`
     │││││││┌ @ boot.jl:708 within `toInt64`
106 ─││││││││ %333  = Core.zext_int(Core.Int64, 0x00000003)::Int64
│    │││└└└└└
│    │││ @ indices.jl:350 within `to_indices` @ indices.jl:355 @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %334  = Core.zext_int(Core.Int64, %221)::Int64
│    ││└└└└└└
│    ││┌ @ abstractarray.jl:1326 within `_getindex`
└────│││         goto #111 if not false
     │││┌ @ abstractarray.jl:707 within `checkbounds`
107 ─││││ %336  = Core.tuple(%333, %334)::Tuple{Int64, Int64}
│    ││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:688
│    ││││┌ @ abstractarray.jl:98 within `axes`
│    │││││┌ @ tuple.jl:274 within `map`
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %337  = Base.getfield(%1, 1, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %338  = Base.slt_int(%337, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %339  = Core.ifelse(%338, 0, %337)::Int64
│    ││││││└└└└
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %340  = Base.getfield(%1, 2, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %341  = Base.slt_int(%340, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %342  = Core.ifelse(%341, 0, %340)::Int64
│    ││││└└└└└└
│    ││││┌ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %343  = Base.sle_int(1, %333)::Bool
│    │││││││ %344  = Base.sle_int(%333, %339)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %345  = Base.and_int(%343, %344)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices` @ abstractarray.jl:735
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %346  = Base.sle_int(1, %334)::Bool
│    │││││││ %347  = Base.sle_int(%334, %342)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %348  = Base.and_int(%346, %347)::Bool
│    │││││└└
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %349  = Base.and_int(%348, true)::Bool
│    │││││└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %350  = Base.and_int(%345, %349)::Bool
│    ││││└└
│    ││││ @ abstractarray.jl:709 within `checkbounds`
└────││││         goto #109 if not %350
     ││││ @ abstractarray.jl:710 within `checkbounds`
108 ─││││         goto #110
     ││││ @ abstractarray.jl:709 within `checkbounds`
109 ─││││         invoke Base.throw_boundserror(%8::AMDGPU.Device.ROCDeviceMatrix{Float32, 4}, %336::Tuple{Int64, Int64})::Union{}
└────││││         unreachable
110 ─││││         nothing::Nothing
     │││└
     │││ @ abstractarray.jl:1327 within `_getindex`
     │││┌ @ abstractarray.jl:1333 within `_to_linear_index`
     ││││┌ @ abstractarray.jl:2933 within `_sub2ind`
     │││││┌ @ abstractarray.jl:98 within `axes`
     ││││││┌ @ tuple.jl:274 within `map`
     │││││││┌ @ tuple.jl:29 within `getindex`
111 ┄││││││││ %356  = Base.getfield(%1, 1, true)::Int64
│    │││││││└
│    │││││││┌ @ range.jl:459 within `oneto`
│    ││││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    │││││││││┌ @ promotion.jl:510 within `max`
│    ││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││ %357  = Base.slt_int(%356, 0)::Bool
│    ││││││││││└
│    ││││││││││┌ @ essentials.jl:575 within `ifelse`
│    │││││││││││ %358  = Core.ifelse(%357, 0, %356)::Int64
│    │││││└└└└└└
│    │││││ @ abstractarray.jl:2933 within `_sub2ind` @ abstractarray.jl:2949
│    │││││┌ @ abstractarray.jl:2965 within `_sub2ind_recurse`
│    ││││││┌ @ abstractarray.jl:2969 within `nextL`
│    │││││││┌ @ int.jl:88 within `*`
│    ││││││││ %359  = Base.mul_int(1, %358)::Int64
│    ││││││└└
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %360  = Base.sub_int(%333, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %361  = Base.mul_int(%360, 1)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %362  = Base.add_int(1, %361)::Int64
│    ││││││└
│    ││││││ @ abstractarray.jl:2965 within `_sub2ind_recurse` @ abstractarray.jl:2965
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %363  = Base.sub_int(%334, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %364  = Base.mul_int(%363, %359)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %365  = Base.add_int(%362, %364)::Int64
│    │││└└└└
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:82 within `#getindex`
└────││││         goto #116 if not false
     ││││┌ @ abstractarray.jl:707 within `checkbounds`
112 ─│││││ %367  = Core.tuple(%365)::Tuple{Int64}
│    │││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│    │││││┌ @ abstractarray.jl:381 within `eachindex`
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %368  = Base.slt_int(%7, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %369  = Core.ifelse(%368, 0, %7)::Int64
│    │││││└└└└└
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %370  = Base.sle_int(1, %365)::Bool
│    │││││││ %371  = Base.sle_int(%365, %369)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %372  = Base.and_int(%370, %371)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:709 within `checkbounds`
└────│││││         goto #114 if not %372
     │││││ @ abstractarray.jl:710 within `checkbounds`
113 ─│││││         goto #115
     │││││ @ abstractarray.jl:709 within `checkbounds`
114 ─│││││         invoke Base.throw_boundserror(%8::AMDGPU.Device.ROCDeviceMatrix{Float32, 4}, %367::Tuple{Int64})::Union{}
└────│││││         unreachable
115 ─│││││         nothing::Nothing
     ││││└
     ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:84 within `#getindex`
     ││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:85 within `unsafe_load`
     │││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:9 within `pointerref`
     ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:9 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
116 ┄│││││││ %378  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine float @entry(i8 addrspace(4)* %0, i64 %1) #0 {\nentry:\n  %2 = bitcast i8 addrspace(4)* %0 to float addrspace(4)*\n  %3 = getelementptr inbounds float, float addrspace(4)* %2, i64 %1\n  %4 = load float, float addrspace(4)* %3, align 4, !tbaa !0\n  ret float %4\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(4)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %379  = Base.sub_int(%365, 1)::Int64
│    │││││││└
│    │││││││ %380  = Base.llvmcall(%378, Float32, Tuple{Core.LLVMPtr{Float32, 4}, Int64}, %4, %379)::Float32
│    ││││└└└
└────││││         goto #117
     │││└
     │││ @ abstractarray.jl:1328 within `_getindex`
117 ─│││         goto #118
     ││└
118 ─││         goto #119
     │└
     │ @ /home/pxl-th/code/Nerf.jl/src/encoding/spherical_harmonics.jl:33 within `macro expansion`
     │┌ @ float.jl:410 within `*`
119 ─││ %384  = Base.mul_float(%278, %329)::Float32
│    ││ %385  = Base.mul_float(%278, %380)::Float32
│    ││ %386  = Base.mul_float(%329, %380)::Float32
│    │└
│    │ @ /home/pxl-th/code/Nerf.jl/src/encoding/spherical_harmonics.jl:34 within `macro expansion`
│    │┌ @ intfuncs.jl:319 within `literal_pow`
│    ││┌ @ float.jl:410 within `*`
│    │││ %387  = Base.mul_float(%278, %278)::Float32
│    │││ @ float.jl:410 within `*`
│    │││ %388  = Base.mul_float(%329, %329)::Float32
│    │││ @ float.jl:410 within `*`
│    │││ %389  = Base.mul_float(%380, %380)::Float32
│    │└└
│    │ @ /home/pxl-th/code/Nerf.jl/src/encoding/spherical_harmonics.jl:37 within `macro expansion`
│    │┌ @ abstractarray.jl:1397 within `setindex!`
│    ││┌ @ indices.jl:350 within `to_indices` @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %390  = Core.zext_int(Core.Int64, 0x00000001)::Int64
│    │││└└└└└
│    │││ @ indices.jl:350 within `to_indices` @ indices.jl:355 @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %391  = Core.zext_int(Core.Int64, %221)::Int64
│    ││└└└└└└
│    ││┌ @ abstractarray.jl:1419 within `_setindex!`
└────│││         goto #124 if not false
     │││┌ @ abstractarray.jl:707 within `checkbounds`
120 ─││││ %393  = Core.tuple(%390, %391)::Tuple{Int64, Int64}
│    ││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:688
│    ││││┌ @ abstractarray.jl:98 within `axes`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
│    ││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││ %394  = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    │││││└└
│    │││││┌ @ tuple.jl:274 within `map`
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %395  = Base.getfield(%394, 1, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %396  = Base.slt_int(%395, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %397  = Core.ifelse(%396, 0, %395)::Int64
│    ││││││└└└└
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %398  = Base.getfield(%394, 2, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %399  = Base.slt_int(%398, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %400  = Core.ifelse(%399, 0, %398)::Int64
│    ││││└└└└└└
│    ││││┌ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %401  = Base.sle_int(1, %390)::Bool
│    │││││││ %402  = Base.sle_int(%390, %397)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %403  = Base.and_int(%401, %402)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices` @ abstractarray.jl:735
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %404  = Base.sle_int(1, %391)::Bool
│    │││││││ %405  = Base.sle_int(%391, %400)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %406  = Base.and_int(%404, %405)::Bool
│    │││││└└
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %407  = Base.and_int(%406, true)::Bool
│    │││││└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %408  = Base.and_int(%403, %407)::Bool
│    ││││└└
│    ││││ @ abstractarray.jl:709 within `checkbounds`
└────││││         goto #122 if not %408
     ││││ @ abstractarray.jl:710 within `checkbounds`
121 ─││││         goto #123
     ││││ @ abstractarray.jl:709 within `checkbounds`
122 ─││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %393::Tuple{Int64, Int64})::Union{}
└────││││         unreachable
123 ─││││         nothing::Nothing
     │││└
     │││ @ abstractarray.jl:1420 within `_setindex!`
     │││┌ @ abstractarray.jl:1333 within `_to_linear_index`
     ││││┌ @ abstractarray.jl:2933 within `_sub2ind`
     │││││┌ @ abstractarray.jl:98 within `axes`
     ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
     │││││││┌ @ Base.jl:37 within `getproperty`
124 ┄││││││││ %414  = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    ││││││└└
│    ││││││┌ @ tuple.jl:274 within `map`
│    │││││││┌ @ tuple.jl:29 within `getindex`
│    ││││││││ %415  = Base.getfield(%414, 1, true)::Int64
│    │││││││└
│    │││││││┌ @ range.jl:459 within `oneto`
│    ││││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    │││││││││┌ @ promotion.jl:510 within `max`
│    ││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││ %416  = Base.slt_int(%415, 0)::Bool
│    ││││││││││└
│    ││││││││││┌ @ essentials.jl:575 within `ifelse`
│    │││││││││││ %417  = Core.ifelse(%416, 0, %415)::Int64
│    │││││└└└└└└
│    │││││ @ abstractarray.jl:2933 within `_sub2ind` @ abstractarray.jl:2949
│    │││││┌ @ abstractarray.jl:2965 within `_sub2ind_recurse`
│    ││││││┌ @ abstractarray.jl:2969 within `nextL`
│    │││││││┌ @ int.jl:88 within `*`
│    ││││││││ %418  = Base.mul_int(1, %417)::Int64
│    ││││││└└
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %419  = Base.sub_int(%390, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %420  = Base.mul_int(%419, 1)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %421  = Base.add_int(1, %420)::Int64
│    ││││││└
│    ││││││ @ abstractarray.jl:2965 within `_sub2ind_recurse` @ abstractarray.jl:2965
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %422  = Base.sub_int(%391, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %423  = Base.mul_int(%422, %418)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %424  = Base.add_int(%421, %423)::Int64
│    │││└└└└
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:88 within `#setindex!`
└────││││         goto #129 if not false
     ││││┌ @ abstractarray.jl:707 within `checkbounds`
125 ─│││││ %426  = Core.tuple(%424)::Tuple{Int64}
│    │││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│    │││││┌ @ abstractarray.jl:381 within `eachindex`
│    ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:69 within `length`
│    │││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││ %427  = Base.getfield(encodings, :len)::Int64
│    ││││││└└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %428  = Base.slt_int(%427, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %429  = Core.ifelse(%428, 0, %427)::Int64
│    │││││└└└└└
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %430  = Base.sle_int(1, %424)::Bool
│    │││││││ %431  = Base.sle_int(%424, %429)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %432  = Base.and_int(%430, %431)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:709 within `checkbounds`
└────│││││         goto #127 if not %432
     │││││ @ abstractarray.jl:710 within `checkbounds`
126 ─│││││         goto #128
     │││││ @ abstractarray.jl:709 within `checkbounds`
127 ─│││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %426::Tuple{Int64})::Union{}
└────│││││         unreachable
128 ─│││││         nothing::Nothing
     ││││└
     ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:90 within `#setindex!`
     ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:63 within `pointer`
     │││││┌ @ Base.jl:37 within `getproperty`
129 ┄││││││ %438  = Base.getfield(encodings, :ptr)::Core.LLVMPtr{Float32, 1}
│    ││││└└
│    ││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:88 within `unsafe_store!`
│    │││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `pointerset`
│    ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
│    │││││││ %439  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(i8 addrspace(1)* %0, float %1, i64 %2) #0 {\nentry:\n  %3 = bitcast i8 addrspace(1)* %0 to float addrspace(1)*\n  %4 = getelementptr inbounds float, float addrspace(1)* %3, i64 %2\n  store float %1, float addrspace(1)* %4, align 4, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %440  = Base.sub_int(%424, 1)::Int64
│    │││││││└
│    │││││││         Base.llvmcall(%439, Nothing, Tuple{Core.LLVMPtr{Float32, 1}, Float32, Int64}, %438, 0.2820948f0, %440)::Nothing
│    ││││└└└
│    ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:91 within `#setindex!`
└────││││         goto #130
     │││└
     │││ @ abstractarray.jl:1421 within `_setindex!`
130 ─│││         goto #131
     ││└
131 ─││         goto #132
     │└
     │ @ /home/pxl-th/code/Nerf.jl/src/encoding/spherical_harmonics.jl:38 within `macro expansion`
     │┌ @ float.jl:410 within `*`
132 ─││ %445  = Base.mul_float(-0.48860252f0, %329)::Float32
│    │└
│    │┌ @ abstractarray.jl:1397 within `setindex!`
│    ││┌ @ indices.jl:350 within `to_indices` @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %446  = Core.zext_int(Core.Int64, 0x00000002)::Int64
│    │││└└└└└
│    │││ @ indices.jl:350 within `to_indices` @ indices.jl:355 @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %447  = Core.zext_int(Core.Int64, %221)::Int64
│    ││└└└└└└
│    ││┌ @ abstractarray.jl:1419 within `_setindex!`
└────│││         goto #137 if not false
     │││┌ @ abstractarray.jl:707 within `checkbounds`
133 ─││││ %449  = Core.tuple(%446, %447)::Tuple{Int64, Int64}
│    ││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:688
│    ││││┌ @ abstractarray.jl:98 within `axes`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
│    ││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││ %450  = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    │││││└└
│    │││││┌ @ tuple.jl:274 within `map`
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %451  = Base.getfield(%450, 1, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %452  = Base.slt_int(%451, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %453  = Core.ifelse(%452, 0, %451)::Int64
│    ││││││└└└└
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %454  = Base.getfield(%450, 2, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %455  = Base.slt_int(%454, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %456  = Core.ifelse(%455, 0, %454)::Int64
│    ││││└└└└└└
│    ││││┌ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %457  = Base.sle_int(1, %446)::Bool
│    │││││││ %458  = Base.sle_int(%446, %453)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %459  = Base.and_int(%457, %458)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices` @ abstractarray.jl:735
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %460  = Base.sle_int(1, %447)::Bool
│    │││││││ %461  = Base.sle_int(%447, %456)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %462  = Base.and_int(%460, %461)::Bool
│    │││││└└
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %463  = Base.and_int(%462, true)::Bool
│    │││││└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %464  = Base.and_int(%459, %463)::Bool
│    ││││└└
│    ││││ @ abstractarray.jl:709 within `checkbounds`
└────││││         goto #135 if not %464
     ││││ @ abstractarray.jl:710 within `checkbounds`
134 ─││││         goto #136
     ││││ @ abstractarray.jl:709 within `checkbounds`
135 ─││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %449::Tuple{Int64, Int64})::Union{}
└────││││         unreachable
136 ─││││         nothing::Nothing
     │││└
     │││ @ abstractarray.jl:1420 within `_setindex!`
     │││┌ @ abstractarray.jl:1333 within `_to_linear_index`
     ││││┌ @ abstractarray.jl:2933 within `_sub2ind`
     │││││┌ @ abstractarray.jl:98 within `axes`
     ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
     │││││││┌ @ Base.jl:37 within `getproperty`
137 ┄││││││││ %470  = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    ││││││└└
│    ││││││┌ @ tuple.jl:274 within `map`
│    │││││││┌ @ tuple.jl:29 within `getindex`
│    ││││││││ %471  = Base.getfield(%470, 1, true)::Int64
│    │││││││└
│    │││││││┌ @ range.jl:459 within `oneto`
│    ││││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    │││││││││┌ @ promotion.jl:510 within `max`
│    ││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││ %472  = Base.slt_int(%471, 0)::Bool
│    ││││││││││└
│    ││││││││││┌ @ essentials.jl:575 within `ifelse`
│    │││││││││││ %473  = Core.ifelse(%472, 0, %471)::Int64
│    │││││└└└└└└
│    │││││ @ abstractarray.jl:2933 within `_sub2ind` @ abstractarray.jl:2949
│    │││││┌ @ abstractarray.jl:2965 within `_sub2ind_recurse`
│    ││││││┌ @ abstractarray.jl:2969 within `nextL`
│    │││││││┌ @ int.jl:88 within `*`
│    ││││││││ %474  = Base.mul_int(1, %473)::Int64
│    ││││││└└
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %475  = Base.sub_int(%446, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %476  = Base.mul_int(%475, 1)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %477  = Base.add_int(1, %476)::Int64
│    ││││││└
│    ││││││ @ abstractarray.jl:2965 within `_sub2ind_recurse` @ abstractarray.jl:2965
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %478  = Base.sub_int(%447, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %479  = Base.mul_int(%478, %474)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %480  = Base.add_int(%477, %479)::Int64
│    │││└└└└
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:88 within `#setindex!`
└────││││         goto #142 if not false
     ││││┌ @ abstractarray.jl:707 within `checkbounds`
138 ─│││││ %482  = Core.tuple(%480)::Tuple{Int64}
│    │││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│    │││││┌ @ abstractarray.jl:381 within `eachindex`
│    ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:69 within `length`
│    │││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││ %483  = Base.getfield(encodings, :len)::Int64
│    ││││││└└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %484  = Base.slt_int(%483, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %485  = Core.ifelse(%484, 0, %483)::Int64
│    │││││└└└└└
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %486  = Base.sle_int(1, %480)::Bool
│    │││││││ %487  = Base.sle_int(%480, %485)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %488  = Base.and_int(%486, %487)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:709 within `checkbounds`
└────│││││         goto #140 if not %488
     │││││ @ abstractarray.jl:710 within `checkbounds`
139 ─│││││         goto #141
     │││││ @ abstractarray.jl:709 within `checkbounds`
140 ─│││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %482::Tuple{Int64})::Union{}
└────│││││         unreachable
141 ─│││││         nothing::Nothing
     ││││└
     ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:90 within `#setindex!`
     ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:63 within `pointer`
     │││││┌ @ Base.jl:37 within `getproperty`
142 ┄││││││ %494  = Base.getfield(encodings, :ptr)::Core.LLVMPtr{Float32, 1}
│    ││││└└
│    ││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:88 within `unsafe_store!`
│    │││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `pointerset`
│    ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
│    │││││││ %495  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(i8 addrspace(1)* %0, float %1, i64 %2) #0 {\nentry:\n  %3 = bitcast i8 addrspace(1)* %0 to float addrspace(1)*\n  %4 = getelementptr inbounds float, float addrspace(1)* %3, i64 %2\n  store float %1, float addrspace(1)* %4, align 4, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %496  = Base.sub_int(%480, 1)::Int64
│    │││││││└
│    │││││││         Base.llvmcall(%495, Nothing, Tuple{Core.LLVMPtr{Float32, 1}, Float32, Int64}, %494, %445, %496)::Nothing
│    ││││└└└
│    ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:91 within `#setindex!`
└────││││         goto #143
     │││└
     │││ @ abstractarray.jl:1421 within `_setindex!`
143 ─│││         goto #144
     ││└
144 ─││         goto #145
     │└
     │ @ /home/pxl-th/code/Nerf.jl/src/encoding/spherical_harmonics.jl:39 within `macro expansion`
     │┌ @ float.jl:410 within `*`
145 ─││ %501  = Base.mul_float(0.48860252f0, %380)::Float32
│    │└
│    │┌ @ abstractarray.jl:1397 within `setindex!`
│    ││┌ @ indices.jl:350 within `to_indices` @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %502  = Core.zext_int(Core.Int64, 0x00000003)::Int64
│    │││└└└└└
│    │││ @ indices.jl:350 within `to_indices` @ indices.jl:355 @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %503  = Core.zext_int(Core.Int64, %221)::Int64
│    ││└└└└└└
│    ││┌ @ abstractarray.jl:1419 within `_setindex!`
└────│││         goto #150 if not false
     │││┌ @ abstractarray.jl:707 within `checkbounds`
146 ─││││ %505  = Core.tuple(%502, %503)::Tuple{Int64, Int64}
│    ││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:688
│    ││││┌ @ abstractarray.jl:98 within `axes`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
│    ││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││ %506  = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    │││││└└
│    │││││┌ @ tuple.jl:274 within `map`
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %507  = Base.getfield(%506, 1, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %508  = Base.slt_int(%507, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %509  = Core.ifelse(%508, 0, %507)::Int64
│    ││││││└└└└
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %510  = Base.getfield(%506, 2, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %511  = Base.slt_int(%510, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %512  = Core.ifelse(%511, 0, %510)::Int64
│    ││││└└└└└└
│    ││││┌ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %513  = Base.sle_int(1, %502)::Bool
│    │││││││ %514  = Base.sle_int(%502, %509)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %515  = Base.and_int(%513, %514)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices` @ abstractarray.jl:735
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %516  = Base.sle_int(1, %503)::Bool
│    │││││││ %517  = Base.sle_int(%503, %512)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %518  = Base.and_int(%516, %517)::Bool
│    │││││└└
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %519  = Base.and_int(%518, true)::Bool
│    │││││└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %520  = Base.and_int(%515, %519)::Bool
│    ││││└└
│    ││││ @ abstractarray.jl:709 within `checkbounds`
└────││││         goto #148 if not %520
     ││││ @ abstractarray.jl:710 within `checkbounds`
147 ─││││         goto #149
     ││││ @ abstractarray.jl:709 within `checkbounds`
148 ─││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %505::Tuple{Int64, Int64})::Union{}
└────││││         unreachable
149 ─││││         nothing::Nothing
     │││└
     │││ @ abstractarray.jl:1420 within `_setindex!`
     │││┌ @ abstractarray.jl:1333 within `_to_linear_index`
     ││││┌ @ abstractarray.jl:2933 within `_sub2ind`
     │││││┌ @ abstractarray.jl:98 within `axes`
     ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
     │││││││┌ @ Base.jl:37 within `getproperty`
150 ┄││││││││ %526  = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    ││││││└└
│    ││││││┌ @ tuple.jl:274 within `map`
│    │││││││┌ @ tuple.jl:29 within `getindex`
│    ││││││││ %527  = Base.getfield(%526, 1, true)::Int64
│    │││││││└
│    │││││││┌ @ range.jl:459 within `oneto`
│    ││││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    │││││││││┌ @ promotion.jl:510 within `max`
│    ││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││ %528  = Base.slt_int(%527, 0)::Bool
│    ││││││││││└
│    ││││││││││┌ @ essentials.jl:575 within `ifelse`
│    │││││││││││ %529  = Core.ifelse(%528, 0, %527)::Int64
│    │││││└└└└└└
│    │││││ @ abstractarray.jl:2933 within `_sub2ind` @ abstractarray.jl:2949
│    │││││┌ @ abstractarray.jl:2965 within `_sub2ind_recurse`
│    ││││││┌ @ abstractarray.jl:2969 within `nextL`
│    │││││││┌ @ int.jl:88 within `*`
│    ││││││││ %530  = Base.mul_int(1, %529)::Int64
│    ││││││└└
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %531  = Base.sub_int(%502, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %532  = Base.mul_int(%531, 1)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %533  = Base.add_int(1, %532)::Int64
│    ││││││└
│    ││││││ @ abstractarray.jl:2965 within `_sub2ind_recurse` @ abstractarray.jl:2965
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %534  = Base.sub_int(%503, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %535  = Base.mul_int(%534, %530)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %536  = Base.add_int(%533, %535)::Int64
│    │││└└└└
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:88 within `#setindex!`
└────││││         goto #155 if not false
     ││││┌ @ abstractarray.jl:707 within `checkbounds`
151 ─│││││ %538  = Core.tuple(%536)::Tuple{Int64}
│    │││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│    │││││┌ @ abstractarray.jl:381 within `eachindex`
│    ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:69 within `length`
│    │││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││ %539  = Base.getfield(encodings, :len)::Int64
│    ││││││└└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %540  = Base.slt_int(%539, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %541  = Core.ifelse(%540, 0, %539)::Int64
│    │││││└└└└└
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %542  = Base.sle_int(1, %536)::Bool
│    │││││││ %543  = Base.sle_int(%536, %541)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %544  = Base.and_int(%542, %543)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:709 within `checkbounds`
└────│││││         goto #153 if not %544
     │││││ @ abstractarray.jl:710 within `checkbounds`
152 ─│││││         goto #154
     │││││ @ abstractarray.jl:709 within `checkbounds`
153 ─│││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %538::Tuple{Int64})::Union{}
└────│││││         unreachable
154 ─│││││         nothing::Nothing
     ││││└
     ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:90 within `#setindex!`
     ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:63 within `pointer`
     │││││┌ @ Base.jl:37 within `getproperty`
155 ┄││││││ %550  = Base.getfield(encodings, :ptr)::Core.LLVMPtr{Float32, 1}
│    ││││└└
│    ││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:88 within `unsafe_store!`
│    │││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `pointerset`
│    ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
│    │││││││ %551  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(i8 addrspace(1)* %0, float %1, i64 %2) #0 {\nentry:\n  %3 = bitcast i8 addrspace(1)* %0 to float addrspace(1)*\n  %4 = getelementptr inbounds float, float addrspace(1)* %3, i64 %2\n  store float %1, float addrspace(1)* %4, align 4, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %552  = Base.sub_int(%536, 1)::Int64
│    │││││││└
│    │││││││         Base.llvmcall(%551, Nothing, Tuple{Core.LLVMPtr{Float32, 1}, Float32, Int64}, %550, %501, %552)::Nothing
│    ││││└└└
│    ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:91 within `#setindex!`
└────││││         goto #156
     │││└
     │││ @ abstractarray.jl:1421 within `_setindex!`
156 ─│││         goto #157
     ││└
157 ─││         goto #158
     │└
     │ @ /home/pxl-th/code/Nerf.jl/src/encoding/spherical_harmonics.jl:40 within `macro expansion`
     │┌ @ float.jl:410 within `*`
158 ─││ %557  = Base.mul_float(-0.48860252f0, %278)::Float32
│    │└
│    │┌ @ abstractarray.jl:1397 within `setindex!`
│    ││┌ @ indices.jl:350 within `to_indices` @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %558  = Core.zext_int(Core.Int64, 0x00000004)::Int64
│    │││└└└└└
│    │││ @ indices.jl:350 within `to_indices` @ indices.jl:355 @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %559  = Core.zext_int(Core.Int64, %221)::Int64
│    ││└└└└└└
│    ││┌ @ abstractarray.jl:1419 within `_setindex!`
└────│││         goto #163 if not false
     │││┌ @ abstractarray.jl:707 within `checkbounds`
159 ─││││ %561  = Core.tuple(%558, %559)::Tuple{Int64, Int64}
│    ││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:688
│    ││││┌ @ abstractarray.jl:98 within `axes`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
│    ││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││ %562  = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    │││││└└
│    │││││┌ @ tuple.jl:274 within `map`
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %563  = Base.getfield(%562, 1, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %564  = Base.slt_int(%563, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %565  = Core.ifelse(%564, 0, %563)::Int64
│    ││││││└└└└
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %566  = Base.getfield(%562, 2, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %567  = Base.slt_int(%566, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %568  = Core.ifelse(%567, 0, %566)::Int64
│    ││││└└└└└└
│    ││││┌ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %569  = Base.sle_int(1, %558)::Bool
│    │││││││ %570  = Base.sle_int(%558, %565)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %571  = Base.and_int(%569, %570)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices` @ abstractarray.jl:735
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %572  = Base.sle_int(1, %559)::Bool
│    │││││││ %573  = Base.sle_int(%559, %568)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %574  = Base.and_int(%572, %573)::Bool
│    │││││└└
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %575  = Base.and_int(%574, true)::Bool
│    │││││└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %576  = Base.and_int(%571, %575)::Bool
│    ││││└└
│    ││││ @ abstractarray.jl:709 within `checkbounds`
└────││││         goto #161 if not %576
     ││││ @ abstractarray.jl:710 within `checkbounds`
160 ─││││         goto #162
     ││││ @ abstractarray.jl:709 within `checkbounds`
161 ─││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %561::Tuple{Int64, Int64})::Union{}
└────││││         unreachable
162 ─││││         nothing::Nothing
     │││└
     │││ @ abstractarray.jl:1420 within `_setindex!`
     │││┌ @ abstractarray.jl:1333 within `_to_linear_index`
     ││││┌ @ abstractarray.jl:2933 within `_sub2ind`
     │││││┌ @ abstractarray.jl:98 within `axes`
     ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
     │││││││┌ @ Base.jl:37 within `getproperty`
163 ┄││││││││ %582  = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    ││││││└└
│    ││││││┌ @ tuple.jl:274 within `map`
│    │││││││┌ @ tuple.jl:29 within `getindex`
│    ││││││││ %583  = Base.getfield(%582, 1, true)::Int64
│    │││││││└
│    │││││││┌ @ range.jl:459 within `oneto`
│    ││││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    │││││││││┌ @ promotion.jl:510 within `max`
│    ││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││ %584  = Base.slt_int(%583, 0)::Bool
│    ││││││││││└
│    ││││││││││┌ @ essentials.jl:575 within `ifelse`
│    │││││││││││ %585  = Core.ifelse(%584, 0, %583)::Int64
│    │││││└└└└└└
│    │││││ @ abstractarray.jl:2933 within `_sub2ind` @ abstractarray.jl:2949
│    │││││┌ @ abstractarray.jl:2965 within `_sub2ind_recurse`
│    ││││││┌ @ abstractarray.jl:2969 within `nextL`
│    │││││││┌ @ int.jl:88 within `*`
│    ││││││││ %586  = Base.mul_int(1, %585)::Int64
│    ││││││└└
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %587  = Base.sub_int(%558, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %588  = Base.mul_int(%587, 1)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %589  = Base.add_int(1, %588)::Int64
│    ││││││└
│    ││││││ @ abstractarray.jl:2965 within `_sub2ind_recurse` @ abstractarray.jl:2965
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %590  = Base.sub_int(%559, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %591  = Base.mul_int(%590, %586)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %592  = Base.add_int(%589, %591)::Int64
│    │││└└└└
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:88 within `#setindex!`
└────││││         goto #168 if not false
     ││││┌ @ abstractarray.jl:707 within `checkbounds`
164 ─│││││ %594  = Core.tuple(%592)::Tuple{Int64}
│    │││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│    │││││┌ @ abstractarray.jl:381 within `eachindex`
│    ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:69 within `length`
│    │││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││ %595  = Base.getfield(encodings, :len)::Int64
│    ││││││└└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %596  = Base.slt_int(%595, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %597  = Core.ifelse(%596, 0, %595)::Int64
│    │││││└└└└└
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %598  = Base.sle_int(1, %592)::Bool
│    │││││││ %599  = Base.sle_int(%592, %597)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %600  = Base.and_int(%598, %599)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:709 within `checkbounds`
└────│││││         goto #166 if not %600
     │││││ @ abstractarray.jl:710 within `checkbounds`
165 ─│││││         goto #167
     │││││ @ abstractarray.jl:709 within `checkbounds`
166 ─│││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %594::Tuple{Int64})::Union{}
└────│││││         unreachable
167 ─│││││         nothing::Nothing
     ││││└
     ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:90 within `#setindex!`
     ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:63 within `pointer`
     │││││┌ @ Base.jl:37 within `getproperty`
168 ┄││││││ %606  = Base.getfield(encodings, :ptr)::Core.LLVMPtr{Float32, 1}
│    ││││└└
│    ││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:88 within `unsafe_store!`
│    │││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `pointerset`
│    ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
│    │││││││ %607  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(i8 addrspace(1)* %0, float %1, i64 %2) #0 {\nentry:\n  %3 = bitcast i8 addrspace(1)* %0 to float addrspace(1)*\n  %4 = getelementptr inbounds float, float addrspace(1)* %3, i64 %2\n  store float %1, float addrspace(1)* %4, align 4, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %608  = Base.sub_int(%592, 1)::Int64
│    │││││││└
│    │││││││         Base.llvmcall(%607, Nothing, Tuple{Core.LLVMPtr{Float32, 1}, Float32, Int64}, %606, %557, %608)::Nothing
│    ││││└└└
│    ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:91 within `#setindex!`
└────││││         goto #169
     │││└
     │││ @ abstractarray.jl:1421 within `_setindex!`
169 ─│││         goto #170
     ││└
170 ─││         goto #171
     │└
     │ @ /home/pxl-th/code/Nerf.jl/src/encoding/spherical_harmonics.jl:41 within `macro expansion`
     │┌ @ float.jl:410 within `*`
171 ─││ %613  = Base.mul_float(1.0925485f0, %384)::Float32
│    │└
│    │┌ @ abstractarray.jl:1397 within `setindex!`
│    ││┌ @ indices.jl:350 within `to_indices` @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %614  = Core.zext_int(Core.Int64, 0x00000005)::Int64
│    │││└└└└└
│    │││ @ indices.jl:350 within `to_indices` @ indices.jl:355 @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %615  = Core.zext_int(Core.Int64, %221)::Int64
│    ││└└└└└└
│    ││┌ @ abstractarray.jl:1419 within `_setindex!`
└────│││         goto #176 if not false
     │││┌ @ abstractarray.jl:707 within `checkbounds`
172 ─││││ %617  = Core.tuple(%614, %615)::Tuple{Int64, Int64}
│    ││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:688
│    ││││┌ @ abstractarray.jl:98 within `axes`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
│    ││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││ %618  = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    │││││└└
│    │││││┌ @ tuple.jl:274 within `map`
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %619  = Base.getfield(%618, 1, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %620  = Base.slt_int(%619, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %621  = Core.ifelse(%620, 0, %619)::Int64
│    ││││││└└└└
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %622  = Base.getfield(%618, 2, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %623  = Base.slt_int(%622, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %624  = Core.ifelse(%623, 0, %622)::Int64
│    ││││└└└└└└
│    ││││┌ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %625  = Base.sle_int(1, %614)::Bool
│    │││││││ %626  = Base.sle_int(%614, %621)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %627  = Base.and_int(%625, %626)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices` @ abstractarray.jl:735
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %628  = Base.sle_int(1, %615)::Bool
│    │││││││ %629  = Base.sle_int(%615, %624)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %630  = Base.and_int(%628, %629)::Bool
│    │││││└└
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %631  = Base.and_int(%630, true)::Bool
│    │││││└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %632  = Base.and_int(%627, %631)::Bool
│    ││││└└
│    ││││ @ abstractarray.jl:709 within `checkbounds`
└────││││         goto #174 if not %632
     ││││ @ abstractarray.jl:710 within `checkbounds`
173 ─││││         goto #175
     ││││ @ abstractarray.jl:709 within `checkbounds`
174 ─││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %617::Tuple{Int64, Int64})::Union{}
└────││││         unreachable
175 ─││││         nothing::Nothing
     │││└
     │││ @ abstractarray.jl:1420 within `_setindex!`
     │││┌ @ abstractarray.jl:1333 within `_to_linear_index`
     ││││┌ @ abstractarray.jl:2933 within `_sub2ind`
     │││││┌ @ abstractarray.jl:98 within `axes`
     ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
     │││││││┌ @ Base.jl:37 within `getproperty`
176 ┄││││││││ %638  = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    ││││││└└
│    ││││││┌ @ tuple.jl:274 within `map`
│    │││││││┌ @ tuple.jl:29 within `getindex`
│    ││││││││ %639  = Base.getfield(%638, 1, true)::Int64
│    │││││││└
│    │││││││┌ @ range.jl:459 within `oneto`
│    ││││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    │││││││││┌ @ promotion.jl:510 within `max`
│    ││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││ %640  = Base.slt_int(%639, 0)::Bool
│    ││││││││││└
│    ││││││││││┌ @ essentials.jl:575 within `ifelse`
│    │││││││││││ %641  = Core.ifelse(%640, 0, %639)::Int64
│    │││││└└└└└└
│    │││││ @ abstractarray.jl:2933 within `_sub2ind` @ abstractarray.jl:2949
│    │││││┌ @ abstractarray.jl:2965 within `_sub2ind_recurse`
│    ││││││┌ @ abstractarray.jl:2969 within `nextL`
│    │││││││┌ @ int.jl:88 within `*`
│    ││││││││ %642  = Base.mul_int(1, %641)::Int64
│    ││││││└└
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %643  = Base.sub_int(%614, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %644  = Base.mul_int(%643, 1)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %645  = Base.add_int(1, %644)::Int64
│    ││││││└
│    ││││││ @ abstractarray.jl:2965 within `_sub2ind_recurse` @ abstractarray.jl:2965
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %646  = Base.sub_int(%615, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %647  = Base.mul_int(%646, %642)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %648  = Base.add_int(%645, %647)::Int64
│    │││└└└└
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:88 within `#setindex!`
└────││││         goto #181 if not false
     ││││┌ @ abstractarray.jl:707 within `checkbounds`
177 ─│││││ %650  = Core.tuple(%648)::Tuple{Int64}
│    │││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│    │││││┌ @ abstractarray.jl:381 within `eachindex`
│    ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:69 within `length`
│    │││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││ %651  = Base.getfield(encodings, :len)::Int64
│    ││││││└└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %652  = Base.slt_int(%651, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %653  = Core.ifelse(%652, 0, %651)::Int64
│    │││││└└└└└
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %654  = Base.sle_int(1, %648)::Bool
│    │││││││ %655  = Base.sle_int(%648, %653)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %656  = Base.and_int(%654, %655)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:709 within `checkbounds`
└────│││││         goto #179 if not %656
     │││││ @ abstractarray.jl:710 within `checkbounds`
178 ─│││││         goto #180
     │││││ @ abstractarray.jl:709 within `checkbounds`
179 ─│││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %650::Tuple{Int64})::Union{}
└────│││││         unreachable
180 ─│││││         nothing::Nothing
     ││││└
     ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:90 within `#setindex!`
     ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:63 within `pointer`
     │││││┌ @ Base.jl:37 within `getproperty`
181 ┄││││││ %662  = Base.getfield(encodings, :ptr)::Core.LLVMPtr{Float32, 1}
│    ││││└└
│    ││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:88 within `unsafe_store!`
│    │││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `pointerset`
│    ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
│    │││││││ %663  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(i8 addrspace(1)* %0, float %1, i64 %2) #0 {\nentry:\n  %3 = bitcast i8 addrspace(1)* %0 to float addrspace(1)*\n  %4 = getelementptr inbounds float, float addrspace(1)* %3, i64 %2\n  store float %1, float addrspace(1)* %4, align 4, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %664  = Base.sub_int(%648, 1)::Int64
│    │││││││└
│    │││││││         Base.llvmcall(%663, Nothing, Tuple{Core.LLVMPtr{Float32, 1}, Float32, Int64}, %662, %613, %664)::Nothing
│    ││││└└└
│    ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:91 within `#setindex!`
└────││││         goto #182
     │││└
     │││ @ abstractarray.jl:1421 within `_setindex!`
182 ─│││         goto #183
     ││└
183 ─││         goto #184
     │└
     │ @ /home/pxl-th/code/Nerf.jl/src/encoding/spherical_harmonics.jl:42 within `macro expansion`
     │┌ @ float.jl:410 within `*`
184 ─││ %669  = Base.mul_float(-1.0925485f0, %386)::Float32
│    │└
│    │┌ @ abstractarray.jl:1397 within `setindex!`
│    ││┌ @ indices.jl:350 within `to_indices` @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %670  = Core.zext_int(Core.Int64, 0x00000006)::Int64
│    │││└└└└└
│    │││ @ indices.jl:350 within `to_indices` @ indices.jl:355 @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %671  = Core.zext_int(Core.Int64, %221)::Int64
│    ││└└└└└└
│    ││┌ @ abstractarray.jl:1419 within `_setindex!`
└────│││         goto #189 if not false
     │││┌ @ abstractarray.jl:707 within `checkbounds`
185 ─││││ %673  = Core.tuple(%670, %671)::Tuple{Int64, Int64}
│    ││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:688
│    ││││┌ @ abstractarray.jl:98 within `axes`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
│    ││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││ %674  = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    │││││└└
│    │││││┌ @ tuple.jl:274 within `map`
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %675  = Base.getfield(%674, 1, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %676  = Base.slt_int(%675, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %677  = Core.ifelse(%676, 0, %675)::Int64
│    ││││││└└└└
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %678  = Base.getfield(%674, 2, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %679  = Base.slt_int(%678, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %680  = Core.ifelse(%679, 0, %678)::Int64
│    ││││└└└└└└
│    ││││┌ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %681  = Base.sle_int(1, %670)::Bool
│    │││││││ %682  = Base.sle_int(%670, %677)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %683  = Base.and_int(%681, %682)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices` @ abstractarray.jl:735
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %684  = Base.sle_int(1, %671)::Bool
│    │││││││ %685  = Base.sle_int(%671, %680)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %686  = Base.and_int(%684, %685)::Bool
│    │││││└└
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %687  = Base.and_int(%686, true)::Bool
│    │││││└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %688  = Base.and_int(%683, %687)::Bool
│    ││││└└
│    ││││ @ abstractarray.jl:709 within `checkbounds`
└────││││         goto #187 if not %688
     ││││ @ abstractarray.jl:710 within `checkbounds`
186 ─││││         goto #188
     ││││ @ abstractarray.jl:709 within `checkbounds`
187 ─││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %673::Tuple{Int64, Int64})::Union{}
└────││││         unreachable
188 ─││││         nothing::Nothing
     │││└
     │││ @ abstractarray.jl:1420 within `_setindex!`
     │││┌ @ abstractarray.jl:1333 within `_to_linear_index`
     ││││┌ @ abstractarray.jl:2933 within `_sub2ind`
     │││││┌ @ abstractarray.jl:98 within `axes`
     ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
     │││││││┌ @ Base.jl:37 within `getproperty`
189 ┄││││││││ %694  = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    ││││││└└
│    ││││││┌ @ tuple.jl:274 within `map`
│    │││││││┌ @ tuple.jl:29 within `getindex`
│    ││││││││ %695  = Base.getfield(%694, 1, true)::Int64
│    │││││││└
│    │││││││┌ @ range.jl:459 within `oneto`
│    ││││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    │││││││││┌ @ promotion.jl:510 within `max`
│    ││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││ %696  = Base.slt_int(%695, 0)::Bool
│    ││││││││││└
│    ││││││││││┌ @ essentials.jl:575 within `ifelse`
│    │││││││││││ %697  = Core.ifelse(%696, 0, %695)::Int64
│    │││││└└└└└└
│    │││││ @ abstractarray.jl:2933 within `_sub2ind` @ abstractarray.jl:2949
│    │││││┌ @ abstractarray.jl:2965 within `_sub2ind_recurse`
│    ││││││┌ @ abstractarray.jl:2969 within `nextL`
│    │││││││┌ @ int.jl:88 within `*`
│    ││││││││ %698  = Base.mul_int(1, %697)::Int64
│    ││││││└└
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %699  = Base.sub_int(%670, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %700  = Base.mul_int(%699, 1)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %701  = Base.add_int(1, %700)::Int64
│    ││││││└
│    ││││││ @ abstractarray.jl:2965 within `_sub2ind_recurse` @ abstractarray.jl:2965
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %702  = Base.sub_int(%671, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %703  = Base.mul_int(%702, %698)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %704  = Base.add_int(%701, %703)::Int64
│    │││└└└└
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:88 within `#setindex!`
└────││││         goto #194 if not false
     ││││┌ @ abstractarray.jl:707 within `checkbounds`
190 ─│││││ %706  = Core.tuple(%704)::Tuple{Int64}
│    │││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│    │││││┌ @ abstractarray.jl:381 within `eachindex`
│    ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:69 within `length`
│    │││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││ %707  = Base.getfield(encodings, :len)::Int64
│    ││││││└└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %708  = Base.slt_int(%707, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %709  = Core.ifelse(%708, 0, %707)::Int64
│    │││││└└└└└
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %710  = Base.sle_int(1, %704)::Bool
│    │││││││ %711  = Base.sle_int(%704, %709)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %712  = Base.and_int(%710, %711)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:709 within `checkbounds`
└────│││││         goto #192 if not %712
     │││││ @ abstractarray.jl:710 within `checkbounds`
191 ─│││││         goto #193
     │││││ @ abstractarray.jl:709 within `checkbounds`
192 ─│││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %706::Tuple{Int64})::Union{}
└────│││││         unreachable
193 ─│││││         nothing::Nothing
     ││││└
     ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:90 within `#setindex!`
     ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:63 within `pointer`
     │││││┌ @ Base.jl:37 within `getproperty`
194 ┄││││││ %718  = Base.getfield(encodings, :ptr)::Core.LLVMPtr{Float32, 1}
│    ││││└└
│    ││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:88 within `unsafe_store!`
│    │││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `pointerset`
│    ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
│    │││││││ %719  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(i8 addrspace(1)* %0, float %1, i64 %2) #0 {\nentry:\n  %3 = bitcast i8 addrspace(1)* %0 to float addrspace(1)*\n  %4 = getelementptr inbounds float, float addrspace(1)* %3, i64 %2\n  store float %1, float addrspace(1)* %4, align 4, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %720  = Base.sub_int(%704, 1)::Int64
│    │││││││└
│    │││││││         Base.llvmcall(%719, Nothing, Tuple{Core.LLVMPtr{Float32, 1}, Float32, Int64}, %718, %669, %720)::Nothing
│    ││││└└└
│    ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:91 within `#setindex!`
└────││││         goto #195
     │││└
     │││ @ abstractarray.jl:1421 within `_setindex!`
195 ─│││         goto #196
     ││└
196 ─││         goto #197
     │└
     │ @ /home/pxl-th/code/Nerf.jl/src/encoding/spherical_harmonics.jl:43 within `macro expansion`
     │┌ @ float.jl:410 within `*`
197 ─││ %725  = Base.mul_float(0.9461747f0, %389)::Float32
│    │└
│    │┌ @ float.jl:409 within `-`
│    ││ %726  = Base.sub_float(%725, 0.31539157f0)::Float32
│    │└
│    │┌ @ abstractarray.jl:1397 within `setindex!`
│    ││┌ @ indices.jl:350 within `to_indices` @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %727  = Core.zext_int(Core.Int64, 0x00000007)::Int64
│    │││└└└└└
│    │││ @ indices.jl:350 within `to_indices` @ indices.jl:355 @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %728  = Core.zext_int(Core.Int64, %221)::Int64
│    ││└└└└└└
│    ││┌ @ abstractarray.jl:1419 within `_setindex!`
└────│││         goto #202 if not false
     │││┌ @ abstractarray.jl:707 within `checkbounds`
198 ─││││ %730  = Core.tuple(%727, %728)::Tuple{Int64, Int64}
│    ││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:688
│    ││││┌ @ abstractarray.jl:98 within `axes`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
│    ││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││ %731  = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    │││││└└
│    │││││┌ @ tuple.jl:274 within `map`
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %732  = Base.getfield(%731, 1, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %733  = Base.slt_int(%732, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %734  = Core.ifelse(%733, 0, %732)::Int64
│    ││││││└└└└
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %735  = Base.getfield(%731, 2, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %736  = Base.slt_int(%735, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %737  = Core.ifelse(%736, 0, %735)::Int64
│    ││││└└└└└└
│    ││││┌ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %738  = Base.sle_int(1, %727)::Bool
│    │││││││ %739  = Base.sle_int(%727, %734)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %740  = Base.and_int(%738, %739)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices` @ abstractarray.jl:735
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %741  = Base.sle_int(1, %728)::Bool
│    │││││││ %742  = Base.sle_int(%728, %737)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %743  = Base.and_int(%741, %742)::Bool
│    │││││└└
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %744  = Base.and_int(%743, true)::Bool
│    │││││└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %745  = Base.and_int(%740, %744)::Bool
│    ││││└└
│    ││││ @ abstractarray.jl:709 within `checkbounds`
└────││││         goto #200 if not %745
     ││││ @ abstractarray.jl:710 within `checkbounds`
199 ─││││         goto #201
     ││││ @ abstractarray.jl:709 within `checkbounds`
200 ─││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %730::Tuple{Int64, Int64})::Union{}
└────││││         unreachable
201 ─││││         nothing::Nothing
     │││└
     │││ @ abstractarray.jl:1420 within `_setindex!`
     │││┌ @ abstractarray.jl:1333 within `_to_linear_index`
     ││││┌ @ abstractarray.jl:2933 within `_sub2ind`
     │││││┌ @ abstractarray.jl:98 within `axes`
     ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
     │││││││┌ @ Base.jl:37 within `getproperty`
202 ┄││││││││ %751  = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    ││││││└└
│    ││││││┌ @ tuple.jl:274 within `map`
│    │││││││┌ @ tuple.jl:29 within `getindex`
│    ││││││││ %752  = Base.getfield(%751, 1, true)::Int64
│    │││││││└
│    │││││││┌ @ range.jl:459 within `oneto`
│    ││││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    │││││││││┌ @ promotion.jl:510 within `max`
│    ││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││ %753  = Base.slt_int(%752, 0)::Bool
│    ││││││││││└
│    ││││││││││┌ @ essentials.jl:575 within `ifelse`
│    │││││││││││ %754  = Core.ifelse(%753, 0, %752)::Int64
│    │││││└└└└└└
│    │││││ @ abstractarray.jl:2933 within `_sub2ind` @ abstractarray.jl:2949
│    │││││┌ @ abstractarray.jl:2965 within `_sub2ind_recurse`
│    ││││││┌ @ abstractarray.jl:2969 within `nextL`
│    │││││││┌ @ int.jl:88 within `*`
│    ││││││││ %755  = Base.mul_int(1, %754)::Int64
│    ││││││└└
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %756  = Base.sub_int(%727, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %757  = Base.mul_int(%756, 1)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %758  = Base.add_int(1, %757)::Int64
│    ││││││└
│    ││││││ @ abstractarray.jl:2965 within `_sub2ind_recurse` @ abstractarray.jl:2965
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %759  = Base.sub_int(%728, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %760  = Base.mul_int(%759, %755)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %761  = Base.add_int(%758, %760)::Int64
│    │││└└└└
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:88 within `#setindex!`
└────││││         goto #207 if not false
     ││││┌ @ abstractarray.jl:707 within `checkbounds`
203 ─│││││ %763  = Core.tuple(%761)::Tuple{Int64}
│    │││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│    │││││┌ @ abstractarray.jl:381 within `eachindex`
│    ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:69 within `length`
│    │││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││ %764  = Base.getfield(encodings, :len)::Int64
│    ││││││└└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %765  = Base.slt_int(%764, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %766  = Core.ifelse(%765, 0, %764)::Int64
│    │││││└└└└└
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %767  = Base.sle_int(1, %761)::Bool
│    │││││││ %768  = Base.sle_int(%761, %766)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %769  = Base.and_int(%767, %768)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:709 within `checkbounds`
└────│││││         goto #205 if not %769
     │││││ @ abstractarray.jl:710 within `checkbounds`
204 ─│││││         goto #206
     │││││ @ abstractarray.jl:709 within `checkbounds`
205 ─│││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %763::Tuple{Int64})::Union{}
└────│││││         unreachable
206 ─│││││         nothing::Nothing
     ││││└
     ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:90 within `#setindex!`
     ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:63 within `pointer`
     │││││┌ @ Base.jl:37 within `getproperty`
207 ┄││││││ %775  = Base.getfield(encodings, :ptr)::Core.LLVMPtr{Float32, 1}
│    ││││└└
│    ││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:88 within `unsafe_store!`
│    │││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `pointerset`
│    ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
│    │││││││ %776  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(i8 addrspace(1)* %0, float %1, i64 %2) #0 {\nentry:\n  %3 = bitcast i8 addrspace(1)* %0 to float addrspace(1)*\n  %4 = getelementptr inbounds float, float addrspace(1)* %3, i64 %2\n  store float %1, float addrspace(1)* %4, align 4, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %777  = Base.sub_int(%761, 1)::Int64
│    │││││││└
│    │││││││         Base.llvmcall(%776, Nothing, Tuple{Core.LLVMPtr{Float32, 1}, Float32, Int64}, %775, %726, %777)::Nothing
│    ││││└└└
│    ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:91 within `#setindex!`
└────││││         goto #208
     │││└
     │││ @ abstractarray.jl:1421 within `_setindex!`
208 ─│││         goto #209
     ││└
209 ─││         goto #210
     │└
     │ @ /home/pxl-th/code/Nerf.jl/src/encoding/spherical_harmonics.jl:44 within `macro expansion`
     │┌ @ float.jl:410 within `*`
210 ─││ %782  = Base.mul_float(-1.0925485f0, %385)::Float32
│    │└
│    │┌ @ abstractarray.jl:1397 within `setindex!`
│    ││┌ @ indices.jl:350 within `to_indices` @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %783  = Core.zext_int(Core.Int64, 0x00000008)::Int64
│    │││└└└└└
│    │││ @ indices.jl:350 within `to_indices` @ indices.jl:355 @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %784  = Core.zext_int(Core.Int64, %221)::Int64
│    ││└└└└└└
│    ││┌ @ abstractarray.jl:1419 within `_setindex!`
└────│││         goto #215 if not false
     │││┌ @ abstractarray.jl:707 within `checkbounds`
211 ─││││ %786  = Core.tuple(%783, %784)::Tuple{Int64, Int64}
│    ││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:688
│    ││││┌ @ abstractarray.jl:98 within `axes`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
│    ││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││ %787  = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    │││││└└
│    │││││┌ @ tuple.jl:274 within `map`
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %788  = Base.getfield(%787, 1, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %789  = Base.slt_int(%788, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %790  = Core.ifelse(%789, 0, %788)::Int64
│    ││││││└└└└
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %791  = Base.getfield(%787, 2, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %792  = Base.slt_int(%791, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %793  = Core.ifelse(%792, 0, %791)::Int64
│    ││││└└└└└└
│    ││││┌ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %794  = Base.sle_int(1, %783)::Bool
│    │││││││ %795  = Base.sle_int(%783, %790)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %796  = Base.and_int(%794, %795)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices` @ abstractarray.jl:735
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %797  = Base.sle_int(1, %784)::Bool
│    │││││││ %798  = Base.sle_int(%784, %793)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %799  = Base.and_int(%797, %798)::Bool
│    │││││└└
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %800  = Base.and_int(%799, true)::Bool
│    │││││└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %801  = Base.and_int(%796, %800)::Bool
│    ││││└└
│    ││││ @ abstractarray.jl:709 within `checkbounds`
└────││││         goto #213 if not %801
     ││││ @ abstractarray.jl:710 within `checkbounds`
212 ─││││         goto #214
     ││││ @ abstractarray.jl:709 within `checkbounds`
213 ─││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %786::Tuple{Int64, Int64})::Union{}
└────││││         unreachable
214 ─││││         nothing::Nothing
     │││└
     │││ @ abstractarray.jl:1420 within `_setindex!`
     │││┌ @ abstractarray.jl:1333 within `_to_linear_index`
     ││││┌ @ abstractarray.jl:2933 within `_sub2ind`
     │││││┌ @ abstractarray.jl:98 within `axes`
     ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
     │││││││┌ @ Base.jl:37 within `getproperty`
215 ┄││││││││ %807  = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    ││││││└└
│    ││││││┌ @ tuple.jl:274 within `map`
│    │││││││┌ @ tuple.jl:29 within `getindex`
│    ││││││││ %808  = Base.getfield(%807, 1, true)::Int64
│    │││││││└
│    │││││││┌ @ range.jl:459 within `oneto`
│    ││││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    │││││││││┌ @ promotion.jl:510 within `max`
│    ││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││ %809  = Base.slt_int(%808, 0)::Bool
│    ││││││││││└
│    ││││││││││┌ @ essentials.jl:575 within `ifelse`
│    │││││││││││ %810  = Core.ifelse(%809, 0, %808)::Int64
│    │││││└└└└└└
│    │││││ @ abstractarray.jl:2933 within `_sub2ind` @ abstractarray.jl:2949
│    │││││┌ @ abstractarray.jl:2965 within `_sub2ind_recurse`
│    ││││││┌ @ abstractarray.jl:2969 within `nextL`
│    │││││││┌ @ int.jl:88 within `*`
│    ││││││││ %811  = Base.mul_int(1, %810)::Int64
│    ││││││└└
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %812  = Base.sub_int(%783, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %813  = Base.mul_int(%812, 1)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %814  = Base.add_int(1, %813)::Int64
│    ││││││└
│    ││││││ @ abstractarray.jl:2965 within `_sub2ind_recurse` @ abstractarray.jl:2965
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %815  = Base.sub_int(%784, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %816  = Base.mul_int(%815, %811)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %817  = Base.add_int(%814, %816)::Int64
│    │││└└└└
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:88 within `#setindex!`
└────││││         goto #220 if not false
     ││││┌ @ abstractarray.jl:707 within `checkbounds`
216 ─│││││ %819  = Core.tuple(%817)::Tuple{Int64}
│    │││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│    │││││┌ @ abstractarray.jl:381 within `eachindex`
│    ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:69 within `length`
│    │││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││ %820  = Base.getfield(encodings, :len)::Int64
│    ││││││└└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %821  = Base.slt_int(%820, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %822  = Core.ifelse(%821, 0, %820)::Int64
│    │││││└└└└└
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %823  = Base.sle_int(1, %817)::Bool
│    │││││││ %824  = Base.sle_int(%817, %822)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %825  = Base.and_int(%823, %824)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:709 within `checkbounds`
└────│││││         goto #218 if not %825
     │││││ @ abstractarray.jl:710 within `checkbounds`
217 ─│││││         goto #219
     │││││ @ abstractarray.jl:709 within `checkbounds`
218 ─│││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %819::Tuple{Int64})::Union{}
└────│││││         unreachable
219 ─│││││         nothing::Nothing
     ││││└
     ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:90 within `#setindex!`
     ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:63 within `pointer`
     │││││┌ @ Base.jl:37 within `getproperty`
220 ┄││││││ %831  = Base.getfield(encodings, :ptr)::Core.LLVMPtr{Float32, 1}
│    ││││└└
│    ││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:88 within `unsafe_store!`
│    │││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `pointerset`
│    ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
│    │││││││ %832  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(i8 addrspace(1)* %0, float %1, i64 %2) #0 {\nentry:\n  %3 = bitcast i8 addrspace(1)* %0 to float addrspace(1)*\n  %4 = getelementptr inbounds float, float addrspace(1)* %3, i64 %2\n  store float %1, float addrspace(1)* %4, align 4, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %833  = Base.sub_int(%817, 1)::Int64
│    │││││││└
│    │││││││         Base.llvmcall(%832, Nothing, Tuple{Core.LLVMPtr{Float32, 1}, Float32, Int64}, %831, %782, %833)::Nothing
│    ││││└└└
│    ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:91 within `#setindex!`
└────││││         goto #221
     │││└
     │││ @ abstractarray.jl:1421 within `_setindex!`
221 ─│││         goto #222
     ││└
222 ─││         goto #223
     │└
     │ @ /home/pxl-th/code/Nerf.jl/src/encoding/spherical_harmonics.jl:45 within `macro expansion`
     │┌ @ float.jl:410 within `*`
223 ─││ %838  = Base.mul_float(0.54627424f0, %387)::Float32
│    ││ %839  = Base.mul_float(0.54627424f0, %388)::Float32
│    │└
│    │┌ @ float.jl:409 within `-`
│    ││ %840  = Base.sub_float(%838, %839)::Float32
│    │└
│    │┌ @ abstractarray.jl:1397 within `setindex!`
│    ││┌ @ indices.jl:350 within `to_indices` @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %841  = Core.zext_int(Core.Int64, 0x00000009)::Int64
│    │││└└└└└
│    │││ @ indices.jl:350 within `to_indices` @ indices.jl:355 @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %842  = Core.zext_int(Core.Int64, %221)::Int64
│    ││└└└└└└
│    ││┌ @ abstractarray.jl:1419 within `_setindex!`
└────│││         goto #228 if not false
     │││┌ @ abstractarray.jl:707 within `checkbounds`
224 ─││││ %844  = Core.tuple(%841, %842)::Tuple{Int64, Int64}
│    ││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:688
│    ││││┌ @ abstractarray.jl:98 within `axes`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
│    ││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││ %845  = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    │││││└└
│    │││││┌ @ tuple.jl:274 within `map`
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %846  = Base.getfield(%845, 1, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %847  = Base.slt_int(%846, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %848  = Core.ifelse(%847, 0, %846)::Int64
│    ││││││└└└└
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %849  = Base.getfield(%845, 2, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %850  = Base.slt_int(%849, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %851  = Core.ifelse(%850, 0, %849)::Int64
│    ││││└└└└└└
│    ││││┌ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %852  = Base.sle_int(1, %841)::Bool
│    │││││││ %853  = Base.sle_int(%841, %848)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %854  = Base.and_int(%852, %853)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices` @ abstractarray.jl:735
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %855  = Base.sle_int(1, %842)::Bool
│    │││││││ %856  = Base.sle_int(%842, %851)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %857  = Base.and_int(%855, %856)::Bool
│    │││││└└
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %858  = Base.and_int(%857, true)::Bool
│    │││││└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %859  = Base.and_int(%854, %858)::Bool
│    ││││└└
│    ││││ @ abstractarray.jl:709 within `checkbounds`
└────││││         goto #226 if not %859
     ││││ @ abstractarray.jl:710 within `checkbounds`
225 ─││││         goto #227
     ││││ @ abstractarray.jl:709 within `checkbounds`
226 ─││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %844::Tuple{Int64, Int64})::Union{}
└────││││         unreachable
227 ─││││         nothing::Nothing
     │││└
     │││ @ abstractarray.jl:1420 within `_setindex!`
     │││┌ @ abstractarray.jl:1333 within `_to_linear_index`
     ││││┌ @ abstractarray.jl:2933 within `_sub2ind`
     │││││┌ @ abstractarray.jl:98 within `axes`
     ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
     │││││││┌ @ Base.jl:37 within `getproperty`
228 ┄││││││││ %865  = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    ││││││└└
│    ││││││┌ @ tuple.jl:274 within `map`
│    │││││││┌ @ tuple.jl:29 within `getindex`
│    ││││││││ %866  = Base.getfield(%865, 1, true)::Int64
│    │││││││└
│    │││││││┌ @ range.jl:459 within `oneto`
│    ││││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    │││││││││┌ @ promotion.jl:510 within `max`
│    ││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││ %867  = Base.slt_int(%866, 0)::Bool
│    ││││││││││└
│    ││││││││││┌ @ essentials.jl:575 within `ifelse`
│    │││││││││││ %868  = Core.ifelse(%867, 0, %866)::Int64
│    │││││└└└└└└
│    │││││ @ abstractarray.jl:2933 within `_sub2ind` @ abstractarray.jl:2949
│    │││││┌ @ abstractarray.jl:2965 within `_sub2ind_recurse`
│    ││││││┌ @ abstractarray.jl:2969 within `nextL`
│    │││││││┌ @ int.jl:88 within `*`
│    ││││││││ %869  = Base.mul_int(1, %868)::Int64
│    ││││││└└
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %870  = Base.sub_int(%841, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %871  = Base.mul_int(%870, 1)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %872  = Base.add_int(1, %871)::Int64
│    ││││││└
│    ││││││ @ abstractarray.jl:2965 within `_sub2ind_recurse` @ abstractarray.jl:2965
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %873  = Base.sub_int(%842, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %874  = Base.mul_int(%873, %869)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %875  = Base.add_int(%872, %874)::Int64
│    │││└└└└
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:88 within `#setindex!`
└────││││         goto #233 if not false
     ││││┌ @ abstractarray.jl:707 within `checkbounds`
229 ─│││││ %877  = Core.tuple(%875)::Tuple{Int64}
│    │││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│    │││││┌ @ abstractarray.jl:381 within `eachindex`
│    ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:69 within `length`
│    │││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││ %878  = Base.getfield(encodings, :len)::Int64
│    ││││││└└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %879  = Base.slt_int(%878, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %880  = Core.ifelse(%879, 0, %878)::Int64
│    │││││└└└└└
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %881  = Base.sle_int(1, %875)::Bool
│    │││││││ %882  = Base.sle_int(%875, %880)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %883  = Base.and_int(%881, %882)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:709 within `checkbounds`
└────│││││         goto #231 if not %883
     │││││ @ abstractarray.jl:710 within `checkbounds`
230 ─│││││         goto #232
     │││││ @ abstractarray.jl:709 within `checkbounds`
231 ─│││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %877::Tuple{Int64})::Union{}
└────│││││         unreachable
232 ─│││││         nothing::Nothing
     ││││└
     ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:90 within `#setindex!`
     ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:63 within `pointer`
     │││││┌ @ Base.jl:37 within `getproperty`
233 ┄││││││ %889  = Base.getfield(encodings, :ptr)::Core.LLVMPtr{Float32, 1}
│    ││││└└
│    ││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:88 within `unsafe_store!`
│    │││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `pointerset`
│    ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
│    │││││││ %890  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(i8 addrspace(1)* %0, float %1, i64 %2) #0 {\nentry:\n  %3 = bitcast i8 addrspace(1)* %0 to float addrspace(1)*\n  %4 = getelementptr inbounds float, float addrspace(1)* %3, i64 %2\n  store float %1, float addrspace(1)* %4, align 4, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %891  = Base.sub_int(%875, 1)::Int64
│    │││││││└
│    │││││││         Base.llvmcall(%890, Nothing, Tuple{Core.LLVMPtr{Float32, 1}, Float32, Int64}, %889, %840, %891)::Nothing
│    ││││└└└
│    ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:91 within `#setindex!`
└────││││         goto #234
     │││└
     │││ @ abstractarray.jl:1421 within `_setindex!`
234 ─│││         goto #235
     ││└
235 ─││         goto #236
     │└
     │ @ /home/pxl-th/code/Nerf.jl/src/encoding/spherical_harmonics.jl:46 within `macro expansion`
     │┌ @ float.jl:410 within `*`
236 ─││ %896  = Base.mul_float(-3.0f0, %387)::Float32
│    │└
│    │┌ @ float.jl:408 within `+`
│    ││ %897  = Base.add_float(%896, %388)::Float32
│    │└
│    │┌ @ operators.jl:578 within `*` @ float.jl:410
│    ││ %898  = Base.mul_float(0.5900436f0, %329)::Float32
│    ││ %899  = Base.mul_float(%898, %897)::Float32
│    │└
│    │┌ @ abstractarray.jl:1397 within `setindex!`
│    ││┌ @ indices.jl:350 within `to_indices` @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %900  = Core.zext_int(Core.Int64, 0x0000000a)::Int64
│    │││└└└└└
│    │││ @ indices.jl:350 within `to_indices` @ indices.jl:355 @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %901  = Core.zext_int(Core.Int64, %221)::Int64
│    ││└└└└└└
│    ││┌ @ abstractarray.jl:1419 within `_setindex!`
└────│││         goto #241 if not false
     │││┌ @ abstractarray.jl:707 within `checkbounds`
237 ─││││ %903  = Core.tuple(%900, %901)::Tuple{Int64, Int64}
│    ││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:688
│    ││││┌ @ abstractarray.jl:98 within `axes`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
│    ││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││ %904  = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    │││││└└
│    │││││┌ @ tuple.jl:274 within `map`
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %905  = Base.getfield(%904, 1, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %906  = Base.slt_int(%905, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %907  = Core.ifelse(%906, 0, %905)::Int64
│    ││││││└└└└
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %908  = Base.getfield(%904, 2, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %909  = Base.slt_int(%908, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %910  = Core.ifelse(%909, 0, %908)::Int64
│    ││││└└└└└└
│    ││││┌ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %911  = Base.sle_int(1, %900)::Bool
│    │││││││ %912  = Base.sle_int(%900, %907)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %913  = Base.and_int(%911, %912)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices` @ abstractarray.jl:735
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %914  = Base.sle_int(1, %901)::Bool
│    │││││││ %915  = Base.sle_int(%901, %910)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %916  = Base.and_int(%914, %915)::Bool
│    │││││└└
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %917  = Base.and_int(%916, true)::Bool
│    │││││└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %918  = Base.and_int(%913, %917)::Bool
│    ││││└└
│    ││││ @ abstractarray.jl:709 within `checkbounds`
└────││││         goto #239 if not %918
     ││││ @ abstractarray.jl:710 within `checkbounds`
238 ─││││         goto #240
     ││││ @ abstractarray.jl:709 within `checkbounds`
239 ─││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %903::Tuple{Int64, Int64})::Union{}
└────││││         unreachable
240 ─││││         nothing::Nothing
     │││└
     │││ @ abstractarray.jl:1420 within `_setindex!`
     │││┌ @ abstractarray.jl:1333 within `_to_linear_index`
     ││││┌ @ abstractarray.jl:2933 within `_sub2ind`
     │││││┌ @ abstractarray.jl:98 within `axes`
     ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
     │││││││┌ @ Base.jl:37 within `getproperty`
241 ┄││││││││ %924  = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    ││││││└└
│    ││││││┌ @ tuple.jl:274 within `map`
│    │││││││┌ @ tuple.jl:29 within `getindex`
│    ││││││││ %925  = Base.getfield(%924, 1, true)::Int64
│    │││││││└
│    │││││││┌ @ range.jl:459 within `oneto`
│    ││││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    │││││││││┌ @ promotion.jl:510 within `max`
│    ││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││ %926  = Base.slt_int(%925, 0)::Bool
│    ││││││││││└
│    ││││││││││┌ @ essentials.jl:575 within `ifelse`
│    │││││││││││ %927  = Core.ifelse(%926, 0, %925)::Int64
│    │││││└└└└└└
│    │││││ @ abstractarray.jl:2933 within `_sub2ind` @ abstractarray.jl:2949
│    │││││┌ @ abstractarray.jl:2965 within `_sub2ind_recurse`
│    ││││││┌ @ abstractarray.jl:2969 within `nextL`
│    │││││││┌ @ int.jl:88 within `*`
│    ││││││││ %928  = Base.mul_int(1, %927)::Int64
│    ││││││└└
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %929  = Base.sub_int(%900, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %930  = Base.mul_int(%929, 1)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %931  = Base.add_int(1, %930)::Int64
│    ││││││└
│    ││││││ @ abstractarray.jl:2965 within `_sub2ind_recurse` @ abstractarray.jl:2965
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %932  = Base.sub_int(%901, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %933  = Base.mul_int(%932, %928)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %934  = Base.add_int(%931, %933)::Int64
│    │││└└└└
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:88 within `#setindex!`
└────││││         goto #246 if not false
     ││││┌ @ abstractarray.jl:707 within `checkbounds`
242 ─│││││ %936  = Core.tuple(%934)::Tuple{Int64}
│    │││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│    │││││┌ @ abstractarray.jl:381 within `eachindex`
│    ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:69 within `length`
│    │││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││ %937  = Base.getfield(encodings, :len)::Int64
│    ││││││└└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %938  = Base.slt_int(%937, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %939  = Core.ifelse(%938, 0, %937)::Int64
│    │││││└└└└└
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %940  = Base.sle_int(1, %934)::Bool
│    │││││││ %941  = Base.sle_int(%934, %939)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %942  = Base.and_int(%940, %941)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:709 within `checkbounds`
└────│││││         goto #244 if not %942
     │││││ @ abstractarray.jl:710 within `checkbounds`
243 ─│││││         goto #245
     │││││ @ abstractarray.jl:709 within `checkbounds`
244 ─│││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %936::Tuple{Int64})::Union{}
└────│││││         unreachable
245 ─│││││         nothing::Nothing
     ││││└
     ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:90 within `#setindex!`
     ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:63 within `pointer`
     │││││┌ @ Base.jl:37 within `getproperty`
246 ┄││││││ %948  = Base.getfield(encodings, :ptr)::Core.LLVMPtr{Float32, 1}
│    ││││└└
│    ││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:88 within `unsafe_store!`
│    │││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `pointerset`
│    ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
│    │││││││ %949  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(i8 addrspace(1)* %0, float %1, i64 %2) #0 {\nentry:\n  %3 = bitcast i8 addrspace(1)* %0 to float addrspace(1)*\n  %4 = getelementptr inbounds float, float addrspace(1)* %3, i64 %2\n  store float %1, float addrspace(1)* %4, align 4, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %950  = Base.sub_int(%934, 1)::Int64
│    │││││││└
│    │││││││         Base.llvmcall(%949, Nothing, Tuple{Core.LLVMPtr{Float32, 1}, Float32, Int64}, %948, %899, %950)::Nothing
│    ││││└└└
│    ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:91 within `#setindex!`
└────││││         goto #247
     │││└
     │││ @ abstractarray.jl:1421 within `_setindex!`
247 ─│││         goto #248
     ││└
248 ─││         goto #249
     │└
     │ @ /home/pxl-th/code/Nerf.jl/src/encoding/spherical_harmonics.jl:47 within `macro expansion`
     │┌ @ operators.jl:578 within `*` @ float.jl:410
249 ─││ %955  = Base.mul_float(2.8906114f0, %384)::Float32
│    ││ %956  = Base.mul_float(%955, %380)::Float32
│    │└
│    │┌ @ abstractarray.jl:1397 within `setindex!`
│    ││┌ @ indices.jl:350 within `to_indices` @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %957  = Core.zext_int(Core.Int64, 0x0000000b)::Int64
│    │││└└└└└
│    │││ @ indices.jl:350 within `to_indices` @ indices.jl:355 @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %958  = Core.zext_int(Core.Int64, %221)::Int64
│    ││└└└└└└
│    ││┌ @ abstractarray.jl:1419 within `_setindex!`
└────│││         goto #254 if not false
     │││┌ @ abstractarray.jl:707 within `checkbounds`
250 ─││││ %960  = Core.tuple(%957, %958)::Tuple{Int64, Int64}
│    ││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:688
│    ││││┌ @ abstractarray.jl:98 within `axes`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
│    ││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││ %961  = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    │││││└└
│    │││││┌ @ tuple.jl:274 within `map`
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %962  = Base.getfield(%961, 1, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %963  = Base.slt_int(%962, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %964  = Core.ifelse(%963, 0, %962)::Int64
│    ││││││└└└└
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %965  = Base.getfield(%961, 2, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %966  = Base.slt_int(%965, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %967  = Core.ifelse(%966, 0, %965)::Int64
│    ││││└└└└└└
│    ││││┌ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %968  = Base.sle_int(1, %957)::Bool
│    │││││││ %969  = Base.sle_int(%957, %964)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %970  = Base.and_int(%968, %969)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices` @ abstractarray.jl:735
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %971  = Base.sle_int(1, %958)::Bool
│    │││││││ %972  = Base.sle_int(%958, %967)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %973  = Base.and_int(%971, %972)::Bool
│    │││││└└
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %974  = Base.and_int(%973, true)::Bool
│    │││││└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %975  = Base.and_int(%970, %974)::Bool
│    ││││└└
│    ││││ @ abstractarray.jl:709 within `checkbounds`
└────││││         goto #252 if not %975
     ││││ @ abstractarray.jl:710 within `checkbounds`
251 ─││││         goto #253
     ││││ @ abstractarray.jl:709 within `checkbounds`
252 ─││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %960::Tuple{Int64, Int64})::Union{}
└────││││         unreachable
253 ─││││         nothing::Nothing
     │││└
     │││ @ abstractarray.jl:1420 within `_setindex!`
     │││┌ @ abstractarray.jl:1333 within `_to_linear_index`
     ││││┌ @ abstractarray.jl:2933 within `_sub2ind`
     │││││┌ @ abstractarray.jl:98 within `axes`
     ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
     │││││││┌ @ Base.jl:37 within `getproperty`
254 ┄││││││││ %981  = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    ││││││└└
│    ││││││┌ @ tuple.jl:274 within `map`
│    │││││││┌ @ tuple.jl:29 within `getindex`
│    ││││││││ %982  = Base.getfield(%981, 1, true)::Int64
│    │││││││└
│    │││││││┌ @ range.jl:459 within `oneto`
│    ││││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    │││││││││┌ @ promotion.jl:510 within `max`
│    ││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││ %983  = Base.slt_int(%982, 0)::Bool
│    ││││││││││└
│    ││││││││││┌ @ essentials.jl:575 within `ifelse`
│    │││││││││││ %984  = Core.ifelse(%983, 0, %982)::Int64
│    │││││└└└└└└
│    │││││ @ abstractarray.jl:2933 within `_sub2ind` @ abstractarray.jl:2949
│    │││││┌ @ abstractarray.jl:2965 within `_sub2ind_recurse`
│    ││││││┌ @ abstractarray.jl:2969 within `nextL`
│    │││││││┌ @ int.jl:88 within `*`
│    ││││││││ %985  = Base.mul_int(1, %984)::Int64
│    ││││││└└
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %986  = Base.sub_int(%957, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %987  = Base.mul_int(%986, 1)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %988  = Base.add_int(1, %987)::Int64
│    ││││││└
│    ││││││ @ abstractarray.jl:2965 within `_sub2ind_recurse` @ abstractarray.jl:2965
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %989  = Base.sub_int(%958, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %990  = Base.mul_int(%989, %985)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %991  = Base.add_int(%988, %990)::Int64
│    │││└└└└
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:88 within `#setindex!`
└────││││         goto #259 if not false
     ││││┌ @ abstractarray.jl:707 within `checkbounds`
255 ─│││││ %993  = Core.tuple(%991)::Tuple{Int64}
│    │││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│    │││││┌ @ abstractarray.jl:381 within `eachindex`
│    ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:69 within `length`
│    │││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││ %994  = Base.getfield(encodings, :len)::Int64
│    ││││││└└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %995  = Base.slt_int(%994, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %996  = Core.ifelse(%995, 0, %994)::Int64
│    │││││└└└└└
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %997  = Base.sle_int(1, %991)::Bool
│    │││││││ %998  = Base.sle_int(%991, %996)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %999  = Base.and_int(%997, %998)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:709 within `checkbounds`
└────│││││         goto #257 if not %999
     │││││ @ abstractarray.jl:710 within `checkbounds`
256 ─│││││         goto #258
     │││││ @ abstractarray.jl:709 within `checkbounds`
257 ─│││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %993::Tuple{Int64})::Union{}
└────│││││         unreachable
258 ─│││││         nothing::Nothing
     ││││└
     ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:90 within `#setindex!`
     ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:63 within `pointer`
     │││││┌ @ Base.jl:37 within `getproperty`
259 ┄││││││ %1005 = Base.getfield(encodings, :ptr)::Core.LLVMPtr{Float32, 1}
│    ││││└└
│    ││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:88 within `unsafe_store!`
│    │││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `pointerset`
│    ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
│    │││││││ %1006 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(i8 addrspace(1)* %0, float %1, i64 %2) #0 {\nentry:\n  %3 = bitcast i8 addrspace(1)* %0 to float addrspace(1)*\n  %4 = getelementptr inbounds float, float addrspace(1)* %3, i64 %2\n  store float %1, float addrspace(1)* %4, align 4, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %1007 = Base.sub_int(%991, 1)::Int64
│    │││││││└
│    │││││││         Base.llvmcall(%1006, Nothing, Tuple{Core.LLVMPtr{Float32, 1}, Float32, Int64}, %1005, %956, %1007)::Nothing
│    ││││└└└
│    ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:91 within `#setindex!`
└────││││         goto #260
     │││└
     │││ @ abstractarray.jl:1421 within `_setindex!`
260 ─│││         goto #261
     ││└
261 ─││         goto #262
     │└
     │ @ /home/pxl-th/code/Nerf.jl/src/encoding/spherical_harmonics.jl:48 within `macro expansion`
     │┌ @ float.jl:410 within `*`
262 ─││ %1012 = Base.mul_float(5.0f0, %389)::Float32
│    │└
│    │┌ @ float.jl:409 within `-`
│    ││ %1013 = Base.sub_float(1.0f0, %1012)::Float32
│    │└
│    │┌ @ operators.jl:578 within `*` @ float.jl:410
│    ││ %1014 = Base.mul_float(0.4570458f0, %329)::Float32
│    ││ %1015 = Base.mul_float(%1014, %1013)::Float32
│    │└
│    │┌ @ abstractarray.jl:1397 within `setindex!`
│    ││┌ @ indices.jl:350 within `to_indices` @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %1016 = Core.zext_int(Core.Int64, 0x0000000c)::Int64
│    │││└└└└└
│    │││ @ indices.jl:350 within `to_indices` @ indices.jl:355 @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %1017 = Core.zext_int(Core.Int64, %221)::Int64
│    ││└└└└└└
│    ││┌ @ abstractarray.jl:1419 within `_setindex!`
└────│││         goto #267 if not false
     │││┌ @ abstractarray.jl:707 within `checkbounds`
263 ─││││ %1019 = Core.tuple(%1016, %1017)::Tuple{Int64, Int64}
│    ││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:688
│    ││││┌ @ abstractarray.jl:98 within `axes`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
│    ││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││ %1020 = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    │││││└└
│    │││││┌ @ tuple.jl:274 within `map`
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %1021 = Base.getfield(%1020, 1, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %1022 = Base.slt_int(%1021, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %1023 = Core.ifelse(%1022, 0, %1021)::Int64
│    ││││││└└└└
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %1024 = Base.getfield(%1020, 2, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %1025 = Base.slt_int(%1024, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %1026 = Core.ifelse(%1025, 0, %1024)::Int64
│    ││││└└└└└└
│    ││││┌ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %1027 = Base.sle_int(1, %1016)::Bool
│    │││││││ %1028 = Base.sle_int(%1016, %1023)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %1029 = Base.and_int(%1027, %1028)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices` @ abstractarray.jl:735
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %1030 = Base.sle_int(1, %1017)::Bool
│    │││││││ %1031 = Base.sle_int(%1017, %1026)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %1032 = Base.and_int(%1030, %1031)::Bool
│    │││││└└
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %1033 = Base.and_int(%1032, true)::Bool
│    │││││└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %1034 = Base.and_int(%1029, %1033)::Bool
│    ││││└└
│    ││││ @ abstractarray.jl:709 within `checkbounds`
└────││││         goto #265 if not %1034
     ││││ @ abstractarray.jl:710 within `checkbounds`
264 ─││││         goto #266
     ││││ @ abstractarray.jl:709 within `checkbounds`
265 ─││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %1019::Tuple{Int64, Int64})::Union{}
└────││││         unreachable
266 ─││││         nothing::Nothing
     │││└
     │││ @ abstractarray.jl:1420 within `_setindex!`
     │││┌ @ abstractarray.jl:1333 within `_to_linear_index`
     ││││┌ @ abstractarray.jl:2933 within `_sub2ind`
     │││││┌ @ abstractarray.jl:98 within `axes`
     ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
     │││││││┌ @ Base.jl:37 within `getproperty`
267 ┄││││││││ %1040 = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    ││││││└└
│    ││││││┌ @ tuple.jl:274 within `map`
│    │││││││┌ @ tuple.jl:29 within `getindex`
│    ││││││││ %1041 = Base.getfield(%1040, 1, true)::Int64
│    │││││││└
│    │││││││┌ @ range.jl:459 within `oneto`
│    ││││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    │││││││││┌ @ promotion.jl:510 within `max`
│    ││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││ %1042 = Base.slt_int(%1041, 0)::Bool
│    ││││││││││└
│    ││││││││││┌ @ essentials.jl:575 within `ifelse`
│    │││││││││││ %1043 = Core.ifelse(%1042, 0, %1041)::Int64
│    │││││└└└└└└
│    │││││ @ abstractarray.jl:2933 within `_sub2ind` @ abstractarray.jl:2949
│    │││││┌ @ abstractarray.jl:2965 within `_sub2ind_recurse`
│    ││││││┌ @ abstractarray.jl:2969 within `nextL`
│    │││││││┌ @ int.jl:88 within `*`
│    ││││││││ %1044 = Base.mul_int(1, %1043)::Int64
│    ││││││└└
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %1045 = Base.sub_int(%1016, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %1046 = Base.mul_int(%1045, 1)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %1047 = Base.add_int(1, %1046)::Int64
│    ││││││└
│    ││││││ @ abstractarray.jl:2965 within `_sub2ind_recurse` @ abstractarray.jl:2965
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %1048 = Base.sub_int(%1017, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %1049 = Base.mul_int(%1048, %1044)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %1050 = Base.add_int(%1047, %1049)::Int64
│    │││└└└└
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:88 within `#setindex!`
└────││││         goto #272 if not false
     ││││┌ @ abstractarray.jl:707 within `checkbounds`
268 ─│││││ %1052 = Core.tuple(%1050)::Tuple{Int64}
│    │││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│    │││││┌ @ abstractarray.jl:381 within `eachindex`
│    ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:69 within `length`
│    │││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││ %1053 = Base.getfield(encodings, :len)::Int64
│    ││││││└└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %1054 = Base.slt_int(%1053, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %1055 = Core.ifelse(%1054, 0, %1053)::Int64
│    │││││└└└└└
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %1056 = Base.sle_int(1, %1050)::Bool
│    │││││││ %1057 = Base.sle_int(%1050, %1055)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %1058 = Base.and_int(%1056, %1057)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:709 within `checkbounds`
└────│││││         goto #270 if not %1058
     │││││ @ abstractarray.jl:710 within `checkbounds`
269 ─│││││         goto #271
     │││││ @ abstractarray.jl:709 within `checkbounds`
270 ─│││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %1052::Tuple{Int64})::Union{}
└────│││││         unreachable
271 ─│││││         nothing::Nothing
     ││││└
     ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:90 within `#setindex!`
     ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:63 within `pointer`
     │││││┌ @ Base.jl:37 within `getproperty`
272 ┄││││││ %1064 = Base.getfield(encodings, :ptr)::Core.LLVMPtr{Float32, 1}
│    ││││└└
│    ││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:88 within `unsafe_store!`
│    │││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `pointerset`
│    ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
│    │││││││ %1065 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(i8 addrspace(1)* %0, float %1, i64 %2) #0 {\nentry:\n  %3 = bitcast i8 addrspace(1)* %0 to float addrspace(1)*\n  %4 = getelementptr inbounds float, float addrspace(1)* %3, i64 %2\n  store float %1, float addrspace(1)* %4, align 4, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %1066 = Base.sub_int(%1050, 1)::Int64
│    │││││││└
│    │││││││         Base.llvmcall(%1065, Nothing, Tuple{Core.LLVMPtr{Float32, 1}, Float32, Int64}, %1064, %1015, %1066)::Nothing
│    ││││└└└
│    ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:91 within `#setindex!`
└────││││         goto #273
     │││└
     │││ @ abstractarray.jl:1421 within `_setindex!`
273 ─│││         goto #274
     ││└
274 ─││         goto #275
     │└
     │ @ /home/pxl-th/code/Nerf.jl/src/encoding/spherical_harmonics.jl:49 within `macro expansion`
     │┌ @ float.jl:410 within `*`
275 ─││ %1071 = Base.mul_float(5.0f0, %389)::Float32
│    │└
│    │┌ @ float.jl:409 within `-`
│    ││ %1072 = Base.sub_float(%1071, 3.0f0)::Float32
│    │└
│    │┌ @ operators.jl:578 within `*` @ float.jl:410
│    ││ %1073 = Base.mul_float(0.37317634f0, %380)::Float32
│    ││ %1074 = Base.mul_float(%1073, %1072)::Float32
│    │└
│    │┌ @ abstractarray.jl:1397 within `setindex!`
│    ││┌ @ indices.jl:350 within `to_indices` @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %1075 = Core.zext_int(Core.Int64, 0x0000000d)::Int64
│    │││└└└└└
│    │││ @ indices.jl:350 within `to_indices` @ indices.jl:355 @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %1076 = Core.zext_int(Core.Int64, %221)::Int64
│    ││└└└└└└
│    ││┌ @ abstractarray.jl:1419 within `_setindex!`
└────│││         goto #280 if not false
     │││┌ @ abstractarray.jl:707 within `checkbounds`
276 ─││││ %1078 = Core.tuple(%1075, %1076)::Tuple{Int64, Int64}
│    ││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:688
│    ││││┌ @ abstractarray.jl:98 within `axes`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
│    ││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││ %1079 = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    │││││└└
│    │││││┌ @ tuple.jl:274 within `map`
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %1080 = Base.getfield(%1079, 1, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %1081 = Base.slt_int(%1080, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %1082 = Core.ifelse(%1081, 0, %1080)::Int64
│    ││││││└└└└
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %1083 = Base.getfield(%1079, 2, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %1084 = Base.slt_int(%1083, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %1085 = Core.ifelse(%1084, 0, %1083)::Int64
│    ││││└└└└└└
│    ││││┌ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %1086 = Base.sle_int(1, %1075)::Bool
│    │││││││ %1087 = Base.sle_int(%1075, %1082)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %1088 = Base.and_int(%1086, %1087)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices` @ abstractarray.jl:735
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %1089 = Base.sle_int(1, %1076)::Bool
│    │││││││ %1090 = Base.sle_int(%1076, %1085)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %1091 = Base.and_int(%1089, %1090)::Bool
│    │││││└└
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %1092 = Base.and_int(%1091, true)::Bool
│    │││││└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %1093 = Base.and_int(%1088, %1092)::Bool
│    ││││└└
│    ││││ @ abstractarray.jl:709 within `checkbounds`
└────││││         goto #278 if not %1093
     ││││ @ abstractarray.jl:710 within `checkbounds`
277 ─││││         goto #279
     ││││ @ abstractarray.jl:709 within `checkbounds`
278 ─││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %1078::Tuple{Int64, Int64})::Union{}
└────││││         unreachable
279 ─││││         nothing::Nothing
     │││└
     │││ @ abstractarray.jl:1420 within `_setindex!`
     │││┌ @ abstractarray.jl:1333 within `_to_linear_index`
     ││││┌ @ abstractarray.jl:2933 within `_sub2ind`
     │││││┌ @ abstractarray.jl:98 within `axes`
     ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
     │││││││┌ @ Base.jl:37 within `getproperty`
280 ┄││││││││ %1099 = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    ││││││└└
│    ││││││┌ @ tuple.jl:274 within `map`
│    │││││││┌ @ tuple.jl:29 within `getindex`
│    ││││││││ %1100 = Base.getfield(%1099, 1, true)::Int64
│    │││││││└
│    │││││││┌ @ range.jl:459 within `oneto`
│    ││││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    │││││││││┌ @ promotion.jl:510 within `max`
│    ││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││ %1101 = Base.slt_int(%1100, 0)::Bool
│    ││││││││││└
│    ││││││││││┌ @ essentials.jl:575 within `ifelse`
│    │││││││││││ %1102 = Core.ifelse(%1101, 0, %1100)::Int64
│    │││││└└└└└└
│    │││││ @ abstractarray.jl:2933 within `_sub2ind` @ abstractarray.jl:2949
│    │││││┌ @ abstractarray.jl:2965 within `_sub2ind_recurse`
│    ││││││┌ @ abstractarray.jl:2969 within `nextL`
│    │││││││┌ @ int.jl:88 within `*`
│    ││││││││ %1103 = Base.mul_int(1, %1102)::Int64
│    ││││││└└
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %1104 = Base.sub_int(%1075, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %1105 = Base.mul_int(%1104, 1)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %1106 = Base.add_int(1, %1105)::Int64
│    ││││││└
│    ││││││ @ abstractarray.jl:2965 within `_sub2ind_recurse` @ abstractarray.jl:2965
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %1107 = Base.sub_int(%1076, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %1108 = Base.mul_int(%1107, %1103)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %1109 = Base.add_int(%1106, %1108)::Int64
│    │││└└└└
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:88 within `#setindex!`
└────││││         goto #285 if not false
     ││││┌ @ abstractarray.jl:707 within `checkbounds`
281 ─│││││ %1111 = Core.tuple(%1109)::Tuple{Int64}
│    │││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│    │││││┌ @ abstractarray.jl:381 within `eachindex`
│    ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:69 within `length`
│    │││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││ %1112 = Base.getfield(encodings, :len)::Int64
│    ││││││└└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %1113 = Base.slt_int(%1112, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %1114 = Core.ifelse(%1113, 0, %1112)::Int64
│    │││││└└└└└
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %1115 = Base.sle_int(1, %1109)::Bool
│    │││││││ %1116 = Base.sle_int(%1109, %1114)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %1117 = Base.and_int(%1115, %1116)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:709 within `checkbounds`
└────│││││         goto #283 if not %1117
     │││││ @ abstractarray.jl:710 within `checkbounds`
282 ─│││││         goto #284
     │││││ @ abstractarray.jl:709 within `checkbounds`
283 ─│││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %1111::Tuple{Int64})::Union{}
└────│││││         unreachable
284 ─│││││         nothing::Nothing
     ││││└
     ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:90 within `#setindex!`
     ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:63 within `pointer`
     │││││┌ @ Base.jl:37 within `getproperty`
285 ┄││││││ %1123 = Base.getfield(encodings, :ptr)::Core.LLVMPtr{Float32, 1}
│    ││││└└
│    ││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:88 within `unsafe_store!`
│    │││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `pointerset`
│    ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
│    │││││││ %1124 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(i8 addrspace(1)* %0, float %1, i64 %2) #0 {\nentry:\n  %3 = bitcast i8 addrspace(1)* %0 to float addrspace(1)*\n  %4 = getelementptr inbounds float, float addrspace(1)* %3, i64 %2\n  store float %1, float addrspace(1)* %4, align 4, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %1125 = Base.sub_int(%1109, 1)::Int64
│    │││││││└
│    │││││││         Base.llvmcall(%1124, Nothing, Tuple{Core.LLVMPtr{Float32, 1}, Float32, Int64}, %1123, %1074, %1125)::Nothing
│    ││││└└└
│    ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:91 within `#setindex!`
└────││││         goto #286
     │││└
     │││ @ abstractarray.jl:1421 within `_setindex!`
286 ─│││         goto #287
     ││└
287 ─││         goto #288
     │└
     │ @ /home/pxl-th/code/Nerf.jl/src/encoding/spherical_harmonics.jl:50 within `macro expansion`
     │┌ @ float.jl:410 within `*`
288 ─││ %1130 = Base.mul_float(5.0f0, %389)::Float32
│    │└
│    │┌ @ float.jl:409 within `-`
│    ││ %1131 = Base.sub_float(1.0f0, %1130)::Float32
│    │└
│    │┌ @ operators.jl:578 within `*` @ float.jl:410
│    ││ %1132 = Base.mul_float(0.4570458f0, %278)::Float32
│    ││ %1133 = Base.mul_float(%1132, %1131)::Float32
│    │└
│    │┌ @ abstractarray.jl:1397 within `setindex!`
│    ││┌ @ indices.jl:350 within `to_indices` @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %1134 = Core.zext_int(Core.Int64, 0x0000000e)::Int64
│    │││└└└└└
│    │││ @ indices.jl:350 within `to_indices` @ indices.jl:355 @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %1135 = Core.zext_int(Core.Int64, %221)::Int64
│    ││└└└└└└
│    ││┌ @ abstractarray.jl:1419 within `_setindex!`
└────│││         goto #293 if not false
     │││┌ @ abstractarray.jl:707 within `checkbounds`
289 ─││││ %1137 = Core.tuple(%1134, %1135)::Tuple{Int64, Int64}
│    ││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:688
│    ││││┌ @ abstractarray.jl:98 within `axes`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
│    ││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││ %1138 = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    │││││└└
│    │││││┌ @ tuple.jl:274 within `map`
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %1139 = Base.getfield(%1138, 1, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %1140 = Base.slt_int(%1139, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %1141 = Core.ifelse(%1140, 0, %1139)::Int64
│    ││││││└└└└
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %1142 = Base.getfield(%1138, 2, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %1143 = Base.slt_int(%1142, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %1144 = Core.ifelse(%1143, 0, %1142)::Int64
│    ││││└└└└└└
│    ││││┌ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %1145 = Base.sle_int(1, %1134)::Bool
│    │││││││ %1146 = Base.sle_int(%1134, %1141)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %1147 = Base.and_int(%1145, %1146)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices` @ abstractarray.jl:735
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %1148 = Base.sle_int(1, %1135)::Bool
│    │││││││ %1149 = Base.sle_int(%1135, %1144)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %1150 = Base.and_int(%1148, %1149)::Bool
│    │││││└└
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %1151 = Base.and_int(%1150, true)::Bool
│    │││││└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %1152 = Base.and_int(%1147, %1151)::Bool
│    ││││└└
│    ││││ @ abstractarray.jl:709 within `checkbounds`
└────││││         goto #291 if not %1152
     ││││ @ abstractarray.jl:710 within `checkbounds`
290 ─││││         goto #292
     ││││ @ abstractarray.jl:709 within `checkbounds`
291 ─││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %1137::Tuple{Int64, Int64})::Union{}
└────││││         unreachable
292 ─││││         nothing::Nothing
     │││└
     │││ @ abstractarray.jl:1420 within `_setindex!`
     │││┌ @ abstractarray.jl:1333 within `_to_linear_index`
     ││││┌ @ abstractarray.jl:2933 within `_sub2ind`
     │││││┌ @ abstractarray.jl:98 within `axes`
     ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
     │││││││┌ @ Base.jl:37 within `getproperty`
293 ┄││││││││ %1158 = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    ││││││└└
│    ││││││┌ @ tuple.jl:274 within `map`
│    │││││││┌ @ tuple.jl:29 within `getindex`
│    ││││││││ %1159 = Base.getfield(%1158, 1, true)::Int64
│    │││││││└
│    │││││││┌ @ range.jl:459 within `oneto`
│    ││││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    │││││││││┌ @ promotion.jl:510 within `max`
│    ││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││ %1160 = Base.slt_int(%1159, 0)::Bool
│    ││││││││││└
│    ││││││││││┌ @ essentials.jl:575 within `ifelse`
│    │││││││││││ %1161 = Core.ifelse(%1160, 0, %1159)::Int64
│    │││││└└└└└└
│    │││││ @ abstractarray.jl:2933 within `_sub2ind` @ abstractarray.jl:2949
│    │││││┌ @ abstractarray.jl:2965 within `_sub2ind_recurse`
│    ││││││┌ @ abstractarray.jl:2969 within `nextL`
│    │││││││┌ @ int.jl:88 within `*`
│    ││││││││ %1162 = Base.mul_int(1, %1161)::Int64
│    ││││││└└
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %1163 = Base.sub_int(%1134, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %1164 = Base.mul_int(%1163, 1)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %1165 = Base.add_int(1, %1164)::Int64
│    ││││││└
│    ││││││ @ abstractarray.jl:2965 within `_sub2ind_recurse` @ abstractarray.jl:2965
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %1166 = Base.sub_int(%1135, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %1167 = Base.mul_int(%1166, %1162)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %1168 = Base.add_int(%1165, %1167)::Int64
│    │││└└└└
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:88 within `#setindex!`
└────││││         goto #298 if not false
     ││││┌ @ abstractarray.jl:707 within `checkbounds`
294 ─│││││ %1170 = Core.tuple(%1168)::Tuple{Int64}
│    │││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│    │││││┌ @ abstractarray.jl:381 within `eachindex`
│    ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:69 within `length`
│    │││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││ %1171 = Base.getfield(encodings, :len)::Int64
│    ││││││└└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %1172 = Base.slt_int(%1171, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %1173 = Core.ifelse(%1172, 0, %1171)::Int64
│    │││││└└└└└
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %1174 = Base.sle_int(1, %1168)::Bool
│    │││││││ %1175 = Base.sle_int(%1168, %1173)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %1176 = Base.and_int(%1174, %1175)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:709 within `checkbounds`
└────│││││         goto #296 if not %1176
     │││││ @ abstractarray.jl:710 within `checkbounds`
295 ─│││││         goto #297
     │││││ @ abstractarray.jl:709 within `checkbounds`
296 ─│││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %1170::Tuple{Int64})::Union{}
└────│││││         unreachable
297 ─│││││         nothing::Nothing
     ││││└
     ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:90 within `#setindex!`
     ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:63 within `pointer`
     │││││┌ @ Base.jl:37 within `getproperty`
298 ┄││││││ %1182 = Base.getfield(encodings, :ptr)::Core.LLVMPtr{Float32, 1}
│    ││││└└
│    ││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:88 within `unsafe_store!`
│    │││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `pointerset`
│    ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
│    │││││││ %1183 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(i8 addrspace(1)* %0, float %1, i64 %2) #0 {\nentry:\n  %3 = bitcast i8 addrspace(1)* %0 to float addrspace(1)*\n  %4 = getelementptr inbounds float, float addrspace(1)* %3, i64 %2\n  store float %1, float addrspace(1)* %4, align 4, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %1184 = Base.sub_int(%1168, 1)::Int64
│    │││││││└
│    │││││││         Base.llvmcall(%1183, Nothing, Tuple{Core.LLVMPtr{Float32, 1}, Float32, Int64}, %1182, %1133, %1184)::Nothing
│    ││││└└└
│    ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:91 within `#setindex!`
└────││││         goto #299
     │││└
     │││ @ abstractarray.jl:1421 within `_setindex!`
299 ─│││         goto #300
     ││└
300 ─││         goto #301
     │└
     │ @ /home/pxl-th/code/Nerf.jl/src/encoding/spherical_harmonics.jl:51 within `macro expansion`
     │┌ @ float.jl:409 within `-`
301 ─││ %1189 = Base.sub_float(%387, %388)::Float32
│    │└
│    │┌ @ operators.jl:578 within `*` @ float.jl:410
│    ││ %1190 = Base.mul_float(1.4453057f0, %380)::Float32
│    ││ %1191 = Base.mul_float(%1190, %1189)::Float32
│    │└
│    │┌ @ abstractarray.jl:1397 within `setindex!`
│    ││┌ @ indices.jl:350 within `to_indices` @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %1192 = Core.zext_int(Core.Int64, 0x0000000f)::Int64
│    │││└└└└└
│    │││ @ indices.jl:350 within `to_indices` @ indices.jl:355 @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %1193 = Core.zext_int(Core.Int64, %221)::Int64
│    ││└└└└└└
│    ││┌ @ abstractarray.jl:1419 within `_setindex!`
└────│││         goto #306 if not false
     │││┌ @ abstractarray.jl:707 within `checkbounds`
302 ─││││ %1195 = Core.tuple(%1192, %1193)::Tuple{Int64, Int64}
│    ││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:688
│    ││││┌ @ abstractarray.jl:98 within `axes`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
│    ││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││ %1196 = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    │││││└└
│    │││││┌ @ tuple.jl:274 within `map`
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %1197 = Base.getfield(%1196, 1, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %1198 = Base.slt_int(%1197, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %1199 = Core.ifelse(%1198, 0, %1197)::Int64
│    ││││││└└└└
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %1200 = Base.getfield(%1196, 2, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %1201 = Base.slt_int(%1200, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %1202 = Core.ifelse(%1201, 0, %1200)::Int64
│    ││││└└└└└└
│    ││││┌ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %1203 = Base.sle_int(1, %1192)::Bool
│    │││││││ %1204 = Base.sle_int(%1192, %1199)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %1205 = Base.and_int(%1203, %1204)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices` @ abstractarray.jl:735
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %1206 = Base.sle_int(1, %1193)::Bool
│    │││││││ %1207 = Base.sle_int(%1193, %1202)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %1208 = Base.and_int(%1206, %1207)::Bool
│    │││││└└
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %1209 = Base.and_int(%1208, true)::Bool
│    │││││└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %1210 = Base.and_int(%1205, %1209)::Bool
│    ││││└└
│    ││││ @ abstractarray.jl:709 within `checkbounds`
└────││││         goto #304 if not %1210
     ││││ @ abstractarray.jl:710 within `checkbounds`
303 ─││││         goto #305
     ││││ @ abstractarray.jl:709 within `checkbounds`
304 ─││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %1195::Tuple{Int64, Int64})::Union{}
└────││││         unreachable
305 ─││││         nothing::Nothing
     │││└
     │││ @ abstractarray.jl:1420 within `_setindex!`
     │││┌ @ abstractarray.jl:1333 within `_to_linear_index`
     ││││┌ @ abstractarray.jl:2933 within `_sub2ind`
     │││││┌ @ abstractarray.jl:98 within `axes`
     ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
     │││││││┌ @ Base.jl:37 within `getproperty`
306 ┄││││││││ %1216 = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    ││││││└└
│    ││││││┌ @ tuple.jl:274 within `map`
│    │││││││┌ @ tuple.jl:29 within `getindex`
│    ││││││││ %1217 = Base.getfield(%1216, 1, true)::Int64
│    │││││││└
│    │││││││┌ @ range.jl:459 within `oneto`
│    ││││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    │││││││││┌ @ promotion.jl:510 within `max`
│    ││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││ %1218 = Base.slt_int(%1217, 0)::Bool
│    ││││││││││└
│    ││││││││││┌ @ essentials.jl:575 within `ifelse`
│    │││││││││││ %1219 = Core.ifelse(%1218, 0, %1217)::Int64
│    │││││└└└└└└
│    │││││ @ abstractarray.jl:2933 within `_sub2ind` @ abstractarray.jl:2949
│    │││││┌ @ abstractarray.jl:2965 within `_sub2ind_recurse`
│    ││││││┌ @ abstractarray.jl:2969 within `nextL`
│    │││││││┌ @ int.jl:88 within `*`
│    ││││││││ %1220 = Base.mul_int(1, %1219)::Int64
│    ││││││└└
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %1221 = Base.sub_int(%1192, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %1222 = Base.mul_int(%1221, 1)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %1223 = Base.add_int(1, %1222)::Int64
│    ││││││└
│    ││││││ @ abstractarray.jl:2965 within `_sub2ind_recurse` @ abstractarray.jl:2965
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %1224 = Base.sub_int(%1193, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %1225 = Base.mul_int(%1224, %1220)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %1226 = Base.add_int(%1223, %1225)::Int64
│    │││└└└└
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:88 within `#setindex!`
└────││││         goto #311 if not false
     ││││┌ @ abstractarray.jl:707 within `checkbounds`
307 ─│││││ %1228 = Core.tuple(%1226)::Tuple{Int64}
│    │││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│    │││││┌ @ abstractarray.jl:381 within `eachindex`
│    ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:69 within `length`
│    │││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││ %1229 = Base.getfield(encodings, :len)::Int64
│    ││││││└└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %1230 = Base.slt_int(%1229, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %1231 = Core.ifelse(%1230, 0, %1229)::Int64
│    │││││└└└└└
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %1232 = Base.sle_int(1, %1226)::Bool
│    │││││││ %1233 = Base.sle_int(%1226, %1231)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %1234 = Base.and_int(%1232, %1233)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:709 within `checkbounds`
└────│││││         goto #309 if not %1234
     │││││ @ abstractarray.jl:710 within `checkbounds`
308 ─│││││         goto #310
     │││││ @ abstractarray.jl:709 within `checkbounds`
309 ─│││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %1228::Tuple{Int64})::Union{}
└────│││││         unreachable
310 ─│││││         nothing::Nothing
     ││││└
     ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:90 within `#setindex!`
     ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:63 within `pointer`
     │││││┌ @ Base.jl:37 within `getproperty`
311 ┄││││││ %1240 = Base.getfield(encodings, :ptr)::Core.LLVMPtr{Float32, 1}
│    ││││└└
│    ││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:88 within `unsafe_store!`
│    │││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `pointerset`
│    ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
│    │││││││ %1241 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(i8 addrspace(1)* %0, float %1, i64 %2) #0 {\nentry:\n  %3 = bitcast i8 addrspace(1)* %0 to float addrspace(1)*\n  %4 = getelementptr inbounds float, float addrspace(1)* %3, i64 %2\n  store float %1, float addrspace(1)* %4, align 4, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %1242 = Base.sub_int(%1226, 1)::Int64
│    │││││││└
│    │││││││         Base.llvmcall(%1241, Nothing, Tuple{Core.LLVMPtr{Float32, 1}, Float32, Int64}, %1240, %1191, %1242)::Nothing
│    ││││└└└
│    ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:91 within `#setindex!`
└────││││         goto #312
     │││└
     │││ @ abstractarray.jl:1421 within `_setindex!`
312 ─│││         goto #313
     ││└
313 ─││         goto #314
     │└
     │ @ /home/pxl-th/code/Nerf.jl/src/encoding/spherical_harmonics.jl:52 within `macro expansion`
     │┌ @ float.jl:406 within `-`
314 ─││ %1247 = Base.neg_float(%387)::Float32
│    │└
│    │┌ @ float.jl:410 within `*`
│    ││ %1248 = Base.mul_float(3.0f0, %388)::Float32
│    │└
│    │┌ @ float.jl:408 within `+`
│    ││ %1249 = Base.add_float(%1247, %1248)::Float32
│    │└
│    │┌ @ operators.jl:578 within `*` @ float.jl:410
│    ││ %1250 = Base.mul_float(0.5900436f0, %278)::Float32
│    ││ %1251 = Base.mul_float(%1250, %1249)::Float32
│    │└
│    │┌ @ abstractarray.jl:1397 within `setindex!`
│    ││┌ @ indices.jl:350 within `to_indices` @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %1252 = Core.zext_int(Core.Int64, 0x00000010)::Int64
│    │││└└└└└
│    │││ @ indices.jl:350 within `to_indices` @ indices.jl:355 @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %1253 = Core.zext_int(Core.Int64, %221)::Int64
│    ││└└└└└└
│    ││┌ @ abstractarray.jl:1419 within `_setindex!`
└────│││         goto #319 if not false
     │││┌ @ abstractarray.jl:707 within `checkbounds`
315 ─││││ %1255 = Core.tuple(%1252, %1253)::Tuple{Int64, Int64}
│    ││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:688
│    ││││┌ @ abstractarray.jl:98 within `axes`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
│    ││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││ %1256 = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    │││││└└
│    │││││┌ @ tuple.jl:274 within `map`
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %1257 = Base.getfield(%1256, 1, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %1258 = Base.slt_int(%1257, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %1259 = Core.ifelse(%1258, 0, %1257)::Int64
│    ││││││└└└└
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %1260 = Base.getfield(%1256, 2, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %1261 = Base.slt_int(%1260, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %1262 = Core.ifelse(%1261, 0, %1260)::Int64
│    ││││└└└└└└
│    ││││┌ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %1263 = Base.sle_int(1, %1252)::Bool
│    │││││││ %1264 = Base.sle_int(%1252, %1259)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %1265 = Base.and_int(%1263, %1264)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices` @ abstractarray.jl:735
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %1266 = Base.sle_int(1, %1253)::Bool
│    │││││││ %1267 = Base.sle_int(%1253, %1262)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %1268 = Base.and_int(%1266, %1267)::Bool
│    │││││└└
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %1269 = Base.and_int(%1268, true)::Bool
│    │││││└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %1270 = Base.and_int(%1265, %1269)::Bool
│    ││││└└
│    ││││ @ abstractarray.jl:709 within `checkbounds`
└────││││         goto #317 if not %1270
     ││││ @ abstractarray.jl:710 within `checkbounds`
316 ─││││         goto #318
     ││││ @ abstractarray.jl:709 within `checkbounds`
317 ─││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %1255::Tuple{Int64, Int64})::Union{}
└────││││         unreachable
318 ─││││         nothing::Nothing
     │││└
     │││ @ abstractarray.jl:1420 within `_setindex!`
     │││┌ @ abstractarray.jl:1333 within `_to_linear_index`
     ││││┌ @ abstractarray.jl:2933 within `_sub2ind`
     │││││┌ @ abstractarray.jl:98 within `axes`
     ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
     │││││││┌ @ Base.jl:37 within `getproperty`
319 ┄││││││││ %1276 = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    ││││││└└
│    ││││││┌ @ tuple.jl:274 within `map`
│    │││││││┌ @ tuple.jl:29 within `getindex`
│    ││││││││ %1277 = Base.getfield(%1276, 1, true)::Int64
│    │││││││└
│    │││││││┌ @ range.jl:459 within `oneto`
│    ││││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    │││││││││┌ @ promotion.jl:510 within `max`
│    ││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││ %1278 = Base.slt_int(%1277, 0)::Bool
│    ││││││││││└
│    ││││││││││┌ @ essentials.jl:575 within `ifelse`
│    │││││││││││ %1279 = Core.ifelse(%1278, 0, %1277)::Int64
│    │││││└└└└└└
│    │││││ @ abstractarray.jl:2933 within `_sub2ind` @ abstractarray.jl:2949
│    │││││┌ @ abstractarray.jl:2965 within `_sub2ind_recurse`
│    ││││││┌ @ abstractarray.jl:2969 within `nextL`
│    │││││││┌ @ int.jl:88 within `*`
│    ││││││││ %1280 = Base.mul_int(1, %1279)::Int64
│    ││││││└└
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %1281 = Base.sub_int(%1252, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %1282 = Base.mul_int(%1281, 1)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %1283 = Base.add_int(1, %1282)::Int64
│    ││││││└
│    ││││││ @ abstractarray.jl:2965 within `_sub2ind_recurse` @ abstractarray.jl:2965
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %1284 = Base.sub_int(%1253, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %1285 = Base.mul_int(%1284, %1280)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %1286 = Base.add_int(%1283, %1285)::Int64
│    │││└└└└
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:88 within `#setindex!`
└────││││         goto #324 if not false
     ││││┌ @ abstractarray.jl:707 within `checkbounds`
320 ─│││││ %1288 = Core.tuple(%1286)::Tuple{Int64}
│    │││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│    │││││┌ @ abstractarray.jl:381 within `eachindex`
│    ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:69 within `length`
│    │││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││ %1289 = Base.getfield(encodings, :len)::Int64
│    ││││││└└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %1290 = Base.slt_int(%1289, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %1291 = Core.ifelse(%1290, 0, %1289)::Int64
│    │││││└└└└└
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %1292 = Base.sle_int(1, %1286)::Bool
│    │││││││ %1293 = Base.sle_int(%1286, %1291)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %1294 = Base.and_int(%1292, %1293)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:709 within `checkbounds`
└────│││││         goto #322 if not %1294
     │││││ @ abstractarray.jl:710 within `checkbounds`
321 ─│││││         goto #323
     │││││ @ abstractarray.jl:709 within `checkbounds`
322 ─│││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %1288::Tuple{Int64})::Union{}
└────│││││         unreachable
323 ─│││││         nothing::Nothing
     ││││└
     ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:90 within `#setindex!`
     ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:63 within `pointer`
     │││││┌ @ Base.jl:37 within `getproperty`
324 ┄││││││ %1300 = Base.getfield(encodings, :ptr)::Core.LLVMPtr{Float32, 1}
│    ││││└└
│    ││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:88 within `unsafe_store!`
│    │││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `pointerset`
│    ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
│    │││││││ %1301 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(i8 addrspace(1)* %0, float %1, i64 %2) #0 {\nentry:\n  %3 = bitcast i8 addrspace(1)* %0 to float addrspace(1)*\n  %4 = getelementptr inbounds float, float addrspace(1)* %3, i64 %2\n  store float %1, float addrspace(1)* %4, align 4, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %1302 = Base.sub_int(%1286, 1)::Int64
│    │││││││└
│    │││││││         Base.llvmcall(%1301, Nothing, Tuple{Core.LLVMPtr{Float32, 1}, Float32, Int64}, %1300, %1251, %1302)::Nothing
│    ││││└└└
│    ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:91 within `#setindex!`
└────││││         goto #325
     │││└
     │││ @ abstractarray.jl:1421 within `_setindex!`
325 ─│││         goto #326
     ││└
326 ─││         goto #327
327 ─││         nothing::Nothing
     └└
      @ /home/pxl-th/.julia/packages/KernelAbstractions/cWlFz/src/macros.jl:92 within `gpu__spherical_harmonics!`
328 ┄         return Nerf.nothing
) => Nothing
