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
     ││┌ @ indices.jl:350 within `to_indices` @ indices.jl:355 @ indices.jl:354
     │││┌ @ indices.jl:359 within `_to_indices1`
     ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
     │││││┌ @ number.jl:7 within `convert`
     ││││││┌ @ boot.jl:784 within `Int64`
     │││││││┌ @ boot.jl:708 within `toInt64`
80 ──││││││││ %231  = Core.zext_int(Core.Int64, %221)::Int64
│    ││└└└└└└
│    ││┌ @ abstractarray.jl:1326 within `_getindex`
└────│││         goto #85 if not false
     │││┌ @ abstractarray.jl:707 within `checkbounds`
81 ──││││ %233  = Core.tuple(1, %231)::Tuple{Int64, Int64}
│    ││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:688
│    ││││┌ @ abstractarray.jl:98 within `axes`
│    │││││┌ @ tuple.jl:274 within `map`
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %234  = Base.getfield(%1, 1, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %235  = Base.slt_int(%234, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %236  = Core.ifelse(%235, 0, %234)::Int64
│    ││││││└└└└
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %237  = Base.getfield(%1, 2, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %238  = Base.slt_int(%237, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %239  = Core.ifelse(%238, 0, %237)::Int64
│    ││││└└└└└└
│    ││││┌ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %240  = Base.sle_int(1, 1)::Bool
│    │││││││ %241  = Base.sle_int(1, %236)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %242  = Base.and_int(%240, %241)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices` @ abstractarray.jl:735
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %243  = Base.sle_int(1, %231)::Bool
│    │││││││ %244  = Base.sle_int(%231, %239)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %245  = Base.and_int(%243, %244)::Bool
│    │││││└└
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %246  = Base.and_int(%245, true)::Bool
│    │││││└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %247  = Base.and_int(%242, %246)::Bool
│    ││││└└
│    ││││ @ abstractarray.jl:709 within `checkbounds`
└────││││         goto #83 if not %247
     ││││ @ abstractarray.jl:710 within `checkbounds`
82 ──││││         goto #84
     ││││ @ abstractarray.jl:709 within `checkbounds`
83 ──││││         invoke Base.throw_boundserror(%8::AMDGPU.Device.ROCDeviceMatrix{Float32, 4}, %233::Tuple{Int64, Int64})::Union{}
└────││││         unreachable
84 ──││││         nothing::Nothing
     │││└
     │││ @ abstractarray.jl:1327 within `_getindex`
     │││┌ @ abstractarray.jl:1333 within `_to_linear_index`
     ││││┌ @ abstractarray.jl:2933 within `_sub2ind`
     │││││┌ @ abstractarray.jl:98 within `axes`
     ││││││┌ @ tuple.jl:274 within `map`
     │││││││┌ @ tuple.jl:29 within `getindex`
85 ┄─││││││││ %253  = Base.getfield(%1, 1, true)::Int64
│    │││││││└
│    │││││││┌ @ range.jl:459 within `oneto`
│    ││││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    │││││││││┌ @ promotion.jl:510 within `max`
│    ││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││ %254  = Base.slt_int(%253, 0)::Bool
│    ││││││││││└
│    ││││││││││┌ @ essentials.jl:575 within `ifelse`
│    │││││││││││ %255  = Core.ifelse(%254, 0, %253)::Int64
│    │││││└└└└└└
│    │││││ @ abstractarray.jl:2933 within `_sub2ind` @ abstractarray.jl:2949
│    │││││┌ @ abstractarray.jl:2965 within `_sub2ind_recurse`
│    ││││││┌ @ abstractarray.jl:2969 within `nextL`
│    │││││││┌ @ int.jl:88 within `*`
│    ││││││││ %256  = Base.mul_int(1, %255)::Int64
│    ││││││└└
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %257  = Base.sub_int(1, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %258  = Base.mul_int(%257, 1)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %259  = Base.add_int(1, %258)::Int64
│    ││││││└
│    ││││││ @ abstractarray.jl:2965 within `_sub2ind_recurse` @ abstractarray.jl:2965
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %260  = Base.sub_int(%231, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %261  = Base.mul_int(%260, %256)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %262  = Base.add_int(%259, %261)::Int64
│    │││└└└└
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:82 within `#getindex`
└────││││         goto #90 if not false
     ││││┌ @ abstractarray.jl:707 within `checkbounds`
86 ──│││││ %264  = Core.tuple(%262)::Tuple{Int64}
│    │││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│    │││││┌ @ abstractarray.jl:381 within `eachindex`
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %265  = Base.slt_int(%7, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %266  = Core.ifelse(%265, 0, %7)::Int64
│    │││││└└└└└
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %267  = Base.sle_int(1, %262)::Bool
│    │││││││ %268  = Base.sle_int(%262, %266)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %269  = Base.and_int(%267, %268)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:709 within `checkbounds`
└────│││││         goto #88 if not %269
     │││││ @ abstractarray.jl:710 within `checkbounds`
87 ──│││││         goto #89
     │││││ @ abstractarray.jl:709 within `checkbounds`
88 ──│││││         invoke Base.throw_boundserror(%8::AMDGPU.Device.ROCDeviceMatrix{Float32, 4}, %264::Tuple{Int64})::Union{}
└────│││││         unreachable
89 ──│││││         nothing::Nothing
     ││││└
     ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:84 within `#getindex`
     ││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:85 within `unsafe_load`
     │││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:9 within `pointerref`
     ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:9 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
90 ┄─│││││││ %275  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine float @entry(i8 addrspace(4)* %0, i64 %1) #0 {\nentry:\n  %2 = bitcast i8 addrspace(4)* %0 to float addrspace(4)*\n  %3 = getelementptr inbounds float, float addrspace(4)* %2, i64 %1\n  %4 = load float, float addrspace(4)* %3, align 4, !tbaa !0\n  ret float %4\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(4)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %276  = Base.sub_int(%262, 1)::Int64
│    │││││││└
│    │││││││ %277  = Base.llvmcall(%275, Float32, Tuple{Core.LLVMPtr{Float32, 4}, Int64}, %4, %276)::Float32
│    ││││└└└
└────││││         goto #91
     │││└
     │││ @ abstractarray.jl:1328 within `_getindex`
91 ──│││         goto #92
     ││└
92 ──││         goto #93
     ││┌ @ indices.jl:350 within `to_indices` @ indices.jl:355 @ indices.jl:354
     │││┌ @ indices.jl:359 within `_to_indices1`
     ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
     │││││┌ @ number.jl:7 within `convert`
     ││││││┌ @ boot.jl:784 within `Int64`
     │││││││┌ @ boot.jl:708 within `toInt64`
93 ──││││││││ %281  = Core.zext_int(Core.Int64, %221)::Int64
│    ││└└└└└└
│    ││┌ @ abstractarray.jl:1326 within `_getindex`
└────│││         goto #98 if not false
     │││┌ @ abstractarray.jl:707 within `checkbounds`
94 ──││││ %283  = Core.tuple(2, %281)::Tuple{Int64, Int64}
│    ││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:688
│    ││││┌ @ abstractarray.jl:98 within `axes`
│    │││││┌ @ tuple.jl:274 within `map`
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %284  = Base.getfield(%1, 1, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %285  = Base.slt_int(%284, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %286  = Core.ifelse(%285, 0, %284)::Int64
│    ││││││└└└└
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %287  = Base.getfield(%1, 2, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %288  = Base.slt_int(%287, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %289  = Core.ifelse(%288, 0, %287)::Int64
│    ││││└└└└└└
│    ││││┌ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %290  = Base.sle_int(1, 2)::Bool
│    │││││││ %291  = Base.sle_int(2, %286)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %292  = Base.and_int(%290, %291)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices` @ abstractarray.jl:735
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %293  = Base.sle_int(1, %281)::Bool
│    │││││││ %294  = Base.sle_int(%281, %289)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %295  = Base.and_int(%293, %294)::Bool
│    │││││└└
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %296  = Base.and_int(%295, true)::Bool
│    │││││└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %297  = Base.and_int(%292, %296)::Bool
│    ││││└└
│    ││││ @ abstractarray.jl:709 within `checkbounds`
└────││││         goto #96 if not %297
     ││││ @ abstractarray.jl:710 within `checkbounds`
95 ──││││         goto #97
     ││││ @ abstractarray.jl:709 within `checkbounds`
96 ──││││         invoke Base.throw_boundserror(%8::AMDGPU.Device.ROCDeviceMatrix{Float32, 4}, %283::Tuple{Int64, Int64})::Union{}
└────││││         unreachable
97 ──││││         nothing::Nothing
     │││└
     │││ @ abstractarray.jl:1327 within `_getindex`
     │││┌ @ abstractarray.jl:1333 within `_to_linear_index`
     ││││┌ @ abstractarray.jl:2933 within `_sub2ind`
     │││││┌ @ abstractarray.jl:98 within `axes`
     ││││││┌ @ tuple.jl:274 within `map`
     │││││││┌ @ tuple.jl:29 within `getindex`
98 ┄─││││││││ %303  = Base.getfield(%1, 1, true)::Int64
│    │││││││└
│    │││││││┌ @ range.jl:459 within `oneto`
│    ││││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    │││││││││┌ @ promotion.jl:510 within `max`
│    ││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││ %304  = Base.slt_int(%303, 0)::Bool
│    ││││││││││└
│    ││││││││││┌ @ essentials.jl:575 within `ifelse`
│    │││││││││││ %305  = Core.ifelse(%304, 0, %303)::Int64
│    │││││└└└└└└
│    │││││ @ abstractarray.jl:2933 within `_sub2ind` @ abstractarray.jl:2949
│    │││││┌ @ abstractarray.jl:2965 within `_sub2ind_recurse`
│    ││││││┌ @ abstractarray.jl:2969 within `nextL`
│    │││││││┌ @ int.jl:88 within `*`
│    ││││││││ %306  = Base.mul_int(1, %305)::Int64
│    ││││││└└
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %307  = Base.sub_int(2, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %308  = Base.mul_int(%307, 1)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %309  = Base.add_int(1, %308)::Int64
│    ││││││└
│    ││││││ @ abstractarray.jl:2965 within `_sub2ind_recurse` @ abstractarray.jl:2965
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %310  = Base.sub_int(%281, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %311  = Base.mul_int(%310, %306)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %312  = Base.add_int(%309, %311)::Int64
│    │││└└└└
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:82 within `#getindex`
└────││││         goto #103 if not false
     ││││┌ @ abstractarray.jl:707 within `checkbounds`
99 ──│││││ %314  = Core.tuple(%312)::Tuple{Int64}
│    │││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│    │││││┌ @ abstractarray.jl:381 within `eachindex`
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %315  = Base.slt_int(%7, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %316  = Core.ifelse(%315, 0, %7)::Int64
│    │││││└└└└└
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %317  = Base.sle_int(1, %312)::Bool
│    │││││││ %318  = Base.sle_int(%312, %316)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %319  = Base.and_int(%317, %318)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:709 within `checkbounds`
└────│││││         goto #101 if not %319
     │││││ @ abstractarray.jl:710 within `checkbounds`
100 ─│││││         goto #102
     │││││ @ abstractarray.jl:709 within `checkbounds`
101 ─│││││         invoke Base.throw_boundserror(%8::AMDGPU.Device.ROCDeviceMatrix{Float32, 4}, %314::Tuple{Int64})::Union{}
└────│││││         unreachable
102 ─│││││         nothing::Nothing
     ││││└
     ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:84 within `#getindex`
     ││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:85 within `unsafe_load`
     │││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:9 within `pointerref`
     ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:9 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
103 ┄│││││││ %325  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine float @entry(i8 addrspace(4)* %0, i64 %1) #0 {\nentry:\n  %2 = bitcast i8 addrspace(4)* %0 to float addrspace(4)*\n  %3 = getelementptr inbounds float, float addrspace(4)* %2, i64 %1\n  %4 = load float, float addrspace(4)* %3, align 4, !tbaa !0\n  ret float %4\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(4)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %326  = Base.sub_int(%312, 1)::Int64
│    │││││││└
│    │││││││ %327  = Base.llvmcall(%325, Float32, Tuple{Core.LLVMPtr{Float32, 4}, Int64}, %4, %326)::Float32
│    ││││└└└
└────││││         goto #104
     │││└
     │││ @ abstractarray.jl:1328 within `_getindex`
104 ─│││         goto #105
     ││└
105 ─││         goto #106
     ││┌ @ indices.jl:350 within `to_indices` @ indices.jl:355 @ indices.jl:354
     │││┌ @ indices.jl:359 within `_to_indices1`
     ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
     │││││┌ @ number.jl:7 within `convert`
     ││││││┌ @ boot.jl:784 within `Int64`
     │││││││┌ @ boot.jl:708 within `toInt64`
106 ─││││││││ %331  = Core.zext_int(Core.Int64, %221)::Int64
│    ││└└└└└└
│    ││┌ @ abstractarray.jl:1326 within `_getindex`
└────│││         goto #111 if not false
     │││┌ @ abstractarray.jl:707 within `checkbounds`
107 ─││││ %333  = Core.tuple(3, %331)::Tuple{Int64, Int64}
│    ││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:688
│    ││││┌ @ abstractarray.jl:98 within `axes`
│    │││││┌ @ tuple.jl:274 within `map`
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %334  = Base.getfield(%1, 1, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %335  = Base.slt_int(%334, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %336  = Core.ifelse(%335, 0, %334)::Int64
│    ││││││└└└└
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %337  = Base.getfield(%1, 2, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %338  = Base.slt_int(%337, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %339  = Core.ifelse(%338, 0, %337)::Int64
│    ││││└└└└└└
│    ││││┌ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %340  = Base.sle_int(1, 3)::Bool
│    │││││││ %341  = Base.sle_int(3, %336)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %342  = Base.and_int(%340, %341)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices` @ abstractarray.jl:735
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %343  = Base.sle_int(1, %331)::Bool
│    │││││││ %344  = Base.sle_int(%331, %339)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %345  = Base.and_int(%343, %344)::Bool
│    │││││└└
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %346  = Base.and_int(%345, true)::Bool
│    │││││└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %347  = Base.and_int(%342, %346)::Bool
│    ││││└└
│    ││││ @ abstractarray.jl:709 within `checkbounds`
└────││││         goto #109 if not %347
     ││││ @ abstractarray.jl:710 within `checkbounds`
108 ─││││         goto #110
     ││││ @ abstractarray.jl:709 within `checkbounds`
109 ─││││         invoke Base.throw_boundserror(%8::AMDGPU.Device.ROCDeviceMatrix{Float32, 4}, %333::Tuple{Int64, Int64})::Union{}
└────││││         unreachable
110 ─││││         nothing::Nothing
     │││└
     │││ @ abstractarray.jl:1327 within `_getindex`
     │││┌ @ abstractarray.jl:1333 within `_to_linear_index`
     ││││┌ @ abstractarray.jl:2933 within `_sub2ind`
     │││││┌ @ abstractarray.jl:98 within `axes`
     ││││││┌ @ tuple.jl:274 within `map`
     │││││││┌ @ tuple.jl:29 within `getindex`
111 ┄││││││││ %353  = Base.getfield(%1, 1, true)::Int64
│    │││││││└
│    │││││││┌ @ range.jl:459 within `oneto`
│    ││││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    │││││││││┌ @ promotion.jl:510 within `max`
│    ││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││ %354  = Base.slt_int(%353, 0)::Bool
│    ││││││││││└
│    ││││││││││┌ @ essentials.jl:575 within `ifelse`
│    │││││││││││ %355  = Core.ifelse(%354, 0, %353)::Int64
│    │││││└└└└└└
│    │││││ @ abstractarray.jl:2933 within `_sub2ind` @ abstractarray.jl:2949
│    │││││┌ @ abstractarray.jl:2965 within `_sub2ind_recurse`
│    ││││││┌ @ abstractarray.jl:2969 within `nextL`
│    │││││││┌ @ int.jl:88 within `*`
│    ││││││││ %356  = Base.mul_int(1, %355)::Int64
│    ││││││└└
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %357  = Base.sub_int(3, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %358  = Base.mul_int(%357, 1)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %359  = Base.add_int(1, %358)::Int64
│    ││││││└
│    ││││││ @ abstractarray.jl:2965 within `_sub2ind_recurse` @ abstractarray.jl:2965
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %360  = Base.sub_int(%331, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %361  = Base.mul_int(%360, %356)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %362  = Base.add_int(%359, %361)::Int64
│    │││└└└└
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:82 within `#getindex`
└────││││         goto #116 if not false
     ││││┌ @ abstractarray.jl:707 within `checkbounds`
112 ─│││││ %364  = Core.tuple(%362)::Tuple{Int64}
│    │││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│    │││││┌ @ abstractarray.jl:381 within `eachindex`
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %365  = Base.slt_int(%7, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %366  = Core.ifelse(%365, 0, %7)::Int64
│    │││││└└└└└
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %367  = Base.sle_int(1, %362)::Bool
│    │││││││ %368  = Base.sle_int(%362, %366)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %369  = Base.and_int(%367, %368)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:709 within `checkbounds`
└────│││││         goto #114 if not %369
     │││││ @ abstractarray.jl:710 within `checkbounds`
113 ─│││││         goto #115
     │││││ @ abstractarray.jl:709 within `checkbounds`
114 ─│││││         invoke Base.throw_boundserror(%8::AMDGPU.Device.ROCDeviceMatrix{Float32, 4}, %364::Tuple{Int64})::Union{}
└────│││││         unreachable
115 ─│││││         nothing::Nothing
     ││││└
     ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:84 within `#getindex`
     ││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:85 within `unsafe_load`
     │││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:9 within `pointerref`
     ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:9 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
116 ┄│││││││ %375  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine float @entry(i8 addrspace(4)* %0, i64 %1) #0 {\nentry:\n  %2 = bitcast i8 addrspace(4)* %0 to float addrspace(4)*\n  %3 = getelementptr inbounds float, float addrspace(4)* %2, i64 %1\n  %4 = load float, float addrspace(4)* %3, align 4, !tbaa !0\n  ret float %4\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(4)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %376  = Base.sub_int(%362, 1)::Int64
│    │││││││└
│    │││││││ %377  = Base.llvmcall(%375, Float32, Tuple{Core.LLVMPtr{Float32, 4}, Int64}, %4, %376)::Float32
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
119 ─││ %381  = Base.mul_float(%277, %327)::Float32
│    ││ %382  = Base.mul_float(%277, %377)::Float32
│    ││ %383  = Base.mul_float(%327, %377)::Float32
│    │└
│    │ @ /home/pxl-th/code/Nerf.jl/src/encoding/spherical_harmonics.jl:34 within `macro expansion`
│    │┌ @ intfuncs.jl:319 within `literal_pow`
│    ││┌ @ float.jl:410 within `*`
│    │││ %384  = Base.mul_float(%277, %277)::Float32
│    │││ @ float.jl:410 within `*`
│    │││ %385  = Base.mul_float(%327, %327)::Float32
│    │││ @ float.jl:410 within `*`
│    │││ %386  = Base.mul_float(%377, %377)::Float32
│    │└└
│    │ @ /home/pxl-th/code/Nerf.jl/src/encoding/spherical_harmonics.jl:37 within `macro expansion`
│    │┌ @ abstractarray.jl:1397 within `setindex!`
│    ││┌ @ indices.jl:350 within `to_indices` @ indices.jl:355 @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %387  = Core.zext_int(Core.Int64, %221)::Int64
│    ││└└└└└└
│    ││┌ @ abstractarray.jl:1419 within `_setindex!`
└────│││         goto #124 if not false
     │││┌ @ abstractarray.jl:707 within `checkbounds`
120 ─││││ %389  = Core.tuple(1, %387)::Tuple{Int64, Int64}
│    ││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:688
│    ││││┌ @ abstractarray.jl:98 within `axes`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
│    ││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││ %390  = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    │││││└└
│    │││││┌ @ tuple.jl:274 within `map`
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %391  = Base.getfield(%390, 1, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %392  = Base.slt_int(%391, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %393  = Core.ifelse(%392, 0, %391)::Int64
│    ││││││└└└└
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %394  = Base.getfield(%390, 2, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %395  = Base.slt_int(%394, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %396  = Core.ifelse(%395, 0, %394)::Int64
│    ││││└└└└└└
│    ││││┌ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %397  = Base.sle_int(1, 1)::Bool
│    │││││││ %398  = Base.sle_int(1, %393)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %399  = Base.and_int(%397, %398)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices` @ abstractarray.jl:735
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %400  = Base.sle_int(1, %387)::Bool
│    │││││││ %401  = Base.sle_int(%387, %396)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %402  = Base.and_int(%400, %401)::Bool
│    │││││└└
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %403  = Base.and_int(%402, true)::Bool
│    │││││└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %404  = Base.and_int(%399, %403)::Bool
│    ││││└└
│    ││││ @ abstractarray.jl:709 within `checkbounds`
└────││││         goto #122 if not %404
     ││││ @ abstractarray.jl:710 within `checkbounds`
121 ─││││         goto #123
     ││││ @ abstractarray.jl:709 within `checkbounds`
122 ─││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %389::Tuple{Int64, Int64})::Union{}
└────││││         unreachable
123 ─││││         nothing::Nothing
     │││└
     │││ @ abstractarray.jl:1420 within `_setindex!`
     │││┌ @ abstractarray.jl:1333 within `_to_linear_index`
     ││││┌ @ abstractarray.jl:2933 within `_sub2ind`
     │││││┌ @ abstractarray.jl:98 within `axes`
     ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
     │││││││┌ @ Base.jl:37 within `getproperty`
124 ┄││││││││ %410  = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    ││││││└└
│    ││││││┌ @ tuple.jl:274 within `map`
│    │││││││┌ @ tuple.jl:29 within `getindex`
│    ││││││││ %411  = Base.getfield(%410, 1, true)::Int64
│    │││││││└
│    │││││││┌ @ range.jl:459 within `oneto`
│    ││││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    │││││││││┌ @ promotion.jl:510 within `max`
│    ││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││ %412  = Base.slt_int(%411, 0)::Bool
│    ││││││││││└
│    ││││││││││┌ @ essentials.jl:575 within `ifelse`
│    │││││││││││ %413  = Core.ifelse(%412, 0, %411)::Int64
│    │││││└└└└└└
│    │││││ @ abstractarray.jl:2933 within `_sub2ind` @ abstractarray.jl:2949
│    │││││┌ @ abstractarray.jl:2965 within `_sub2ind_recurse`
│    ││││││┌ @ abstractarray.jl:2969 within `nextL`
│    │││││││┌ @ int.jl:88 within `*`
│    ││││││││ %414  = Base.mul_int(1, %413)::Int64
│    ││││││└└
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %415  = Base.sub_int(1, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %416  = Base.mul_int(%415, 1)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %417  = Base.add_int(1, %416)::Int64
│    ││││││└
│    ││││││ @ abstractarray.jl:2965 within `_sub2ind_recurse` @ abstractarray.jl:2965
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %418  = Base.sub_int(%387, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %419  = Base.mul_int(%418, %414)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %420  = Base.add_int(%417, %419)::Int64
│    │││└└└└
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:88 within `#setindex!`
└────││││         goto #129 if not false
     ││││┌ @ abstractarray.jl:707 within `checkbounds`
125 ─│││││ %422  = Core.tuple(%420)::Tuple{Int64}
│    │││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│    │││││┌ @ abstractarray.jl:381 within `eachindex`
│    ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:69 within `length`
│    │││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││ %423  = Base.getfield(encodings, :len)::Int64
│    ││││││└└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %424  = Base.slt_int(%423, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %425  = Core.ifelse(%424, 0, %423)::Int64
│    │││││└└└└└
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %426  = Base.sle_int(1, %420)::Bool
│    │││││││ %427  = Base.sle_int(%420, %425)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %428  = Base.and_int(%426, %427)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:709 within `checkbounds`
└────│││││         goto #127 if not %428
     │││││ @ abstractarray.jl:710 within `checkbounds`
126 ─│││││         goto #128
     │││││ @ abstractarray.jl:709 within `checkbounds`
127 ─│││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %422::Tuple{Int64})::Union{}
└────│││││         unreachable
128 ─│││││         nothing::Nothing
     ││││└
     ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:90 within `#setindex!`
     ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:63 within `pointer`
     │││││┌ @ Base.jl:37 within `getproperty`
129 ┄││││││ %434  = Base.getfield(encodings, :ptr)::Core.LLVMPtr{Float32, 1}
│    ││││└└
│    ││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:88 within `unsafe_store!`
│    │││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `pointerset`
│    ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
│    │││││││ %435  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(i8 addrspace(1)* %0, float %1, i64 %2) #0 {\nentry:\n  %3 = bitcast i8 addrspace(1)* %0 to float addrspace(1)*\n  %4 = getelementptr inbounds float, float addrspace(1)* %3, i64 %2\n  store float %1, float addrspace(1)* %4, align 4, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %436  = Base.sub_int(%420, 1)::Int64
│    │││││││└
│    │││││││         Base.llvmcall(%435, Nothing, Tuple{Core.LLVMPtr{Float32, 1}, Float32, Int64}, %434, 0.2820948f0, %436)::Nothing
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
132 ─││ %441  = Base.mul_float(-0.48860252f0, %327)::Float32
│    │└
│    │┌ @ abstractarray.jl:1397 within `setindex!`
│    ││┌ @ indices.jl:350 within `to_indices` @ indices.jl:355 @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %442  = Core.zext_int(Core.Int64, %221)::Int64
│    ││└└└└└└
│    ││┌ @ abstractarray.jl:1419 within `_setindex!`
└────│││         goto #137 if not false
     │││┌ @ abstractarray.jl:707 within `checkbounds`
133 ─││││ %444  = Core.tuple(2, %442)::Tuple{Int64, Int64}
│    ││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:688
│    ││││┌ @ abstractarray.jl:98 within `axes`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
│    ││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││ %445  = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    │││││└└
│    │││││┌ @ tuple.jl:274 within `map`
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %446  = Base.getfield(%445, 1, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %447  = Base.slt_int(%446, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %448  = Core.ifelse(%447, 0, %446)::Int64
│    ││││││└└└└
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %449  = Base.getfield(%445, 2, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %450  = Base.slt_int(%449, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %451  = Core.ifelse(%450, 0, %449)::Int64
│    ││││└└└└└└
│    ││││┌ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %452  = Base.sle_int(1, 2)::Bool
│    │││││││ %453  = Base.sle_int(2, %448)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %454  = Base.and_int(%452, %453)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices` @ abstractarray.jl:735
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %455  = Base.sle_int(1, %442)::Bool
│    │││││││ %456  = Base.sle_int(%442, %451)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %457  = Base.and_int(%455, %456)::Bool
│    │││││└└
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %458  = Base.and_int(%457, true)::Bool
│    │││││└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %459  = Base.and_int(%454, %458)::Bool
│    ││││└└
│    ││││ @ abstractarray.jl:709 within `checkbounds`
└────││││         goto #135 if not %459
     ││││ @ abstractarray.jl:710 within `checkbounds`
134 ─││││         goto #136
     ││││ @ abstractarray.jl:709 within `checkbounds`
135 ─││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %444::Tuple{Int64, Int64})::Union{}
└────││││         unreachable
136 ─││││         nothing::Nothing
     │││└
     │││ @ abstractarray.jl:1420 within `_setindex!`
     │││┌ @ abstractarray.jl:1333 within `_to_linear_index`
     ││││┌ @ abstractarray.jl:2933 within `_sub2ind`
     │││││┌ @ abstractarray.jl:98 within `axes`
     ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
     │││││││┌ @ Base.jl:37 within `getproperty`
137 ┄││││││││ %465  = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    ││││││└└
│    ││││││┌ @ tuple.jl:274 within `map`
│    │││││││┌ @ tuple.jl:29 within `getindex`
│    ││││││││ %466  = Base.getfield(%465, 1, true)::Int64
│    │││││││└
│    │││││││┌ @ range.jl:459 within `oneto`
│    ││││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    │││││││││┌ @ promotion.jl:510 within `max`
│    ││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││ %467  = Base.slt_int(%466, 0)::Bool
│    ││││││││││└
│    ││││││││││┌ @ essentials.jl:575 within `ifelse`
│    │││││││││││ %468  = Core.ifelse(%467, 0, %466)::Int64
│    │││││└└└└└└
│    │││││ @ abstractarray.jl:2933 within `_sub2ind` @ abstractarray.jl:2949
│    │││││┌ @ abstractarray.jl:2965 within `_sub2ind_recurse`
│    ││││││┌ @ abstractarray.jl:2969 within `nextL`
│    │││││││┌ @ int.jl:88 within `*`
│    ││││││││ %469  = Base.mul_int(1, %468)::Int64
│    ││││││└└
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %470  = Base.sub_int(2, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %471  = Base.mul_int(%470, 1)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %472  = Base.add_int(1, %471)::Int64
│    ││││││└
│    ││││││ @ abstractarray.jl:2965 within `_sub2ind_recurse` @ abstractarray.jl:2965
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %473  = Base.sub_int(%442, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %474  = Base.mul_int(%473, %469)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %475  = Base.add_int(%472, %474)::Int64
│    │││└└└└
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:88 within `#setindex!`
└────││││         goto #142 if not false
     ││││┌ @ abstractarray.jl:707 within `checkbounds`
138 ─│││││ %477  = Core.tuple(%475)::Tuple{Int64}
│    │││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│    │││││┌ @ abstractarray.jl:381 within `eachindex`
│    ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:69 within `length`
│    │││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││ %478  = Base.getfield(encodings, :len)::Int64
│    ││││││└└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %479  = Base.slt_int(%478, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %480  = Core.ifelse(%479, 0, %478)::Int64
│    │││││└└└└└
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %481  = Base.sle_int(1, %475)::Bool
│    │││││││ %482  = Base.sle_int(%475, %480)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %483  = Base.and_int(%481, %482)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:709 within `checkbounds`
└────│││││         goto #140 if not %483
     │││││ @ abstractarray.jl:710 within `checkbounds`
139 ─│││││         goto #141
     │││││ @ abstractarray.jl:709 within `checkbounds`
140 ─│││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %477::Tuple{Int64})::Union{}
└────│││││         unreachable
141 ─│││││         nothing::Nothing
     ││││└
     ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:90 within `#setindex!`
     ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:63 within `pointer`
     │││││┌ @ Base.jl:37 within `getproperty`
142 ┄││││││ %489  = Base.getfield(encodings, :ptr)::Core.LLVMPtr{Float32, 1}
│    ││││└└
│    ││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:88 within `unsafe_store!`
│    │││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `pointerset`
│    ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
│    │││││││ %490  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(i8 addrspace(1)* %0, float %1, i64 %2) #0 {\nentry:\n  %3 = bitcast i8 addrspace(1)* %0 to float addrspace(1)*\n  %4 = getelementptr inbounds float, float addrspace(1)* %3, i64 %2\n  store float %1, float addrspace(1)* %4, align 4, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %491  = Base.sub_int(%475, 1)::Int64
│    │││││││└
│    │││││││         Base.llvmcall(%490, Nothing, Tuple{Core.LLVMPtr{Float32, 1}, Float32, Int64}, %489, %441, %491)::Nothing
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
145 ─││ %496  = Base.mul_float(0.48860252f0, %377)::Float32
│    │└
│    │┌ @ abstractarray.jl:1397 within `setindex!`
│    ││┌ @ indices.jl:350 within `to_indices` @ indices.jl:355 @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %497  = Core.zext_int(Core.Int64, %221)::Int64
│    ││└└└└└└
│    ││┌ @ abstractarray.jl:1419 within `_setindex!`
└────│││         goto #150 if not false
     │││┌ @ abstractarray.jl:707 within `checkbounds`
146 ─││││ %499  = Core.tuple(3, %497)::Tuple{Int64, Int64}
│    ││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:688
│    ││││┌ @ abstractarray.jl:98 within `axes`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
│    ││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││ %500  = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    │││││└└
│    │││││┌ @ tuple.jl:274 within `map`
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %501  = Base.getfield(%500, 1, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %502  = Base.slt_int(%501, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %503  = Core.ifelse(%502, 0, %501)::Int64
│    ││││││└└└└
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %504  = Base.getfield(%500, 2, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %505  = Base.slt_int(%504, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %506  = Core.ifelse(%505, 0, %504)::Int64
│    ││││└└└└└└
│    ││││┌ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %507  = Base.sle_int(1, 3)::Bool
│    │││││││ %508  = Base.sle_int(3, %503)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %509  = Base.and_int(%507, %508)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices` @ abstractarray.jl:735
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %510  = Base.sle_int(1, %497)::Bool
│    │││││││ %511  = Base.sle_int(%497, %506)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %512  = Base.and_int(%510, %511)::Bool
│    │││││└└
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %513  = Base.and_int(%512, true)::Bool
│    │││││└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %514  = Base.and_int(%509, %513)::Bool
│    ││││└└
│    ││││ @ abstractarray.jl:709 within `checkbounds`
└────││││         goto #148 if not %514
     ││││ @ abstractarray.jl:710 within `checkbounds`
147 ─││││         goto #149
     ││││ @ abstractarray.jl:709 within `checkbounds`
148 ─││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %499::Tuple{Int64, Int64})::Union{}
└────││││         unreachable
149 ─││││         nothing::Nothing
     │││└
     │││ @ abstractarray.jl:1420 within `_setindex!`
     │││┌ @ abstractarray.jl:1333 within `_to_linear_index`
     ││││┌ @ abstractarray.jl:2933 within `_sub2ind`
     │││││┌ @ abstractarray.jl:98 within `axes`
     ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
     │││││││┌ @ Base.jl:37 within `getproperty`
150 ┄││││││││ %520  = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    ││││││└└
│    ││││││┌ @ tuple.jl:274 within `map`
│    │││││││┌ @ tuple.jl:29 within `getindex`
│    ││││││││ %521  = Base.getfield(%520, 1, true)::Int64
│    │││││││└
│    │││││││┌ @ range.jl:459 within `oneto`
│    ││││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    │││││││││┌ @ promotion.jl:510 within `max`
│    ││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││ %522  = Base.slt_int(%521, 0)::Bool
│    ││││││││││└
│    ││││││││││┌ @ essentials.jl:575 within `ifelse`
│    │││││││││││ %523  = Core.ifelse(%522, 0, %521)::Int64
│    │││││└└└└└└
│    │││││ @ abstractarray.jl:2933 within `_sub2ind` @ abstractarray.jl:2949
│    │││││┌ @ abstractarray.jl:2965 within `_sub2ind_recurse`
│    ││││││┌ @ abstractarray.jl:2969 within `nextL`
│    │││││││┌ @ int.jl:88 within `*`
│    ││││││││ %524  = Base.mul_int(1, %523)::Int64
│    ││││││└└
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %525  = Base.sub_int(3, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %526  = Base.mul_int(%525, 1)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %527  = Base.add_int(1, %526)::Int64
│    ││││││└
│    ││││││ @ abstractarray.jl:2965 within `_sub2ind_recurse` @ abstractarray.jl:2965
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %528  = Base.sub_int(%497, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %529  = Base.mul_int(%528, %524)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %530  = Base.add_int(%527, %529)::Int64
│    │││└└└└
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:88 within `#setindex!`
└────││││         goto #155 if not false
     ││││┌ @ abstractarray.jl:707 within `checkbounds`
151 ─│││││ %532  = Core.tuple(%530)::Tuple{Int64}
│    │││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│    │││││┌ @ abstractarray.jl:381 within `eachindex`
│    ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:69 within `length`
│    │││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││ %533  = Base.getfield(encodings, :len)::Int64
│    ││││││└└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %534  = Base.slt_int(%533, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %535  = Core.ifelse(%534, 0, %533)::Int64
│    │││││└└└└└
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %536  = Base.sle_int(1, %530)::Bool
│    │││││││ %537  = Base.sle_int(%530, %535)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %538  = Base.and_int(%536, %537)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:709 within `checkbounds`
└────│││││         goto #153 if not %538
     │││││ @ abstractarray.jl:710 within `checkbounds`
152 ─│││││         goto #154
     │││││ @ abstractarray.jl:709 within `checkbounds`
153 ─│││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %532::Tuple{Int64})::Union{}
└────│││││         unreachable
154 ─│││││         nothing::Nothing
     ││││└
     ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:90 within `#setindex!`
     ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:63 within `pointer`
     │││││┌ @ Base.jl:37 within `getproperty`
155 ┄││││││ %544  = Base.getfield(encodings, :ptr)::Core.LLVMPtr{Float32, 1}
│    ││││└└
│    ││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:88 within `unsafe_store!`
│    │││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `pointerset`
│    ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
│    │││││││ %545  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(i8 addrspace(1)* %0, float %1, i64 %2) #0 {\nentry:\n  %3 = bitcast i8 addrspace(1)* %0 to float addrspace(1)*\n  %4 = getelementptr inbounds float, float addrspace(1)* %3, i64 %2\n  store float %1, float addrspace(1)* %4, align 4, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %546  = Base.sub_int(%530, 1)::Int64
│    │││││││└
│    │││││││         Base.llvmcall(%545, Nothing, Tuple{Core.LLVMPtr{Float32, 1}, Float32, Int64}, %544, %496, %546)::Nothing
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
158 ─││ %551  = Base.mul_float(-0.48860252f0, %277)::Float32
│    │└
│    │┌ @ abstractarray.jl:1397 within `setindex!`
│    ││┌ @ indices.jl:350 within `to_indices` @ indices.jl:355 @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %552  = Core.zext_int(Core.Int64, %221)::Int64
│    ││└└└└└└
│    ││┌ @ abstractarray.jl:1419 within `_setindex!`
└────│││         goto #163 if not false
     │││┌ @ abstractarray.jl:707 within `checkbounds`
159 ─││││ %554  = Core.tuple(4, %552)::Tuple{Int64, Int64}
│    ││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:688
│    ││││┌ @ abstractarray.jl:98 within `axes`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
│    ││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││ %555  = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    │││││└└
│    │││││┌ @ tuple.jl:274 within `map`
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %556  = Base.getfield(%555, 1, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %557  = Base.slt_int(%556, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %558  = Core.ifelse(%557, 0, %556)::Int64
│    ││││││└└└└
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %559  = Base.getfield(%555, 2, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %560  = Base.slt_int(%559, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %561  = Core.ifelse(%560, 0, %559)::Int64
│    ││││└└└└└└
│    ││││┌ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %562  = Base.sle_int(1, 4)::Bool
│    │││││││ %563  = Base.sle_int(4, %558)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %564  = Base.and_int(%562, %563)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices` @ abstractarray.jl:735
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %565  = Base.sle_int(1, %552)::Bool
│    │││││││ %566  = Base.sle_int(%552, %561)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %567  = Base.and_int(%565, %566)::Bool
│    │││││└└
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %568  = Base.and_int(%567, true)::Bool
│    │││││└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %569  = Base.and_int(%564, %568)::Bool
│    ││││└└
│    ││││ @ abstractarray.jl:709 within `checkbounds`
└────││││         goto #161 if not %569
     ││││ @ abstractarray.jl:710 within `checkbounds`
160 ─││││         goto #162
     ││││ @ abstractarray.jl:709 within `checkbounds`
161 ─││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %554::Tuple{Int64, Int64})::Union{}
└────││││         unreachable
162 ─││││         nothing::Nothing
     │││└
     │││ @ abstractarray.jl:1420 within `_setindex!`
     │││┌ @ abstractarray.jl:1333 within `_to_linear_index`
     ││││┌ @ abstractarray.jl:2933 within `_sub2ind`
     │││││┌ @ abstractarray.jl:98 within `axes`
     ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
     │││││││┌ @ Base.jl:37 within `getproperty`
163 ┄││││││││ %575  = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    ││││││└└
│    ││││││┌ @ tuple.jl:274 within `map`
│    │││││││┌ @ tuple.jl:29 within `getindex`
│    ││││││││ %576  = Base.getfield(%575, 1, true)::Int64
│    │││││││└
│    │││││││┌ @ range.jl:459 within `oneto`
│    ││││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    │││││││││┌ @ promotion.jl:510 within `max`
│    ││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││ %577  = Base.slt_int(%576, 0)::Bool
│    ││││││││││└
│    ││││││││││┌ @ essentials.jl:575 within `ifelse`
│    │││││││││││ %578  = Core.ifelse(%577, 0, %576)::Int64
│    │││││└└└└└└
│    │││││ @ abstractarray.jl:2933 within `_sub2ind` @ abstractarray.jl:2949
│    │││││┌ @ abstractarray.jl:2965 within `_sub2ind_recurse`
│    ││││││┌ @ abstractarray.jl:2969 within `nextL`
│    │││││││┌ @ int.jl:88 within `*`
│    ││││││││ %579  = Base.mul_int(1, %578)::Int64
│    ││││││└└
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %580  = Base.sub_int(4, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %581  = Base.mul_int(%580, 1)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %582  = Base.add_int(1, %581)::Int64
│    ││││││└
│    ││││││ @ abstractarray.jl:2965 within `_sub2ind_recurse` @ abstractarray.jl:2965
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %583  = Base.sub_int(%552, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %584  = Base.mul_int(%583, %579)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %585  = Base.add_int(%582, %584)::Int64
│    │││└└└└
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:88 within `#setindex!`
└────││││         goto #168 if not false
     ││││┌ @ abstractarray.jl:707 within `checkbounds`
164 ─│││││ %587  = Core.tuple(%585)::Tuple{Int64}
│    │││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│    │││││┌ @ abstractarray.jl:381 within `eachindex`
│    ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:69 within `length`
│    │││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││ %588  = Base.getfield(encodings, :len)::Int64
│    ││││││└└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %589  = Base.slt_int(%588, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %590  = Core.ifelse(%589, 0, %588)::Int64
│    │││││└└└└└
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %591  = Base.sle_int(1, %585)::Bool
│    │││││││ %592  = Base.sle_int(%585, %590)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %593  = Base.and_int(%591, %592)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:709 within `checkbounds`
└────│││││         goto #166 if not %593
     │││││ @ abstractarray.jl:710 within `checkbounds`
165 ─│││││         goto #167
     │││││ @ abstractarray.jl:709 within `checkbounds`
166 ─│││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %587::Tuple{Int64})::Union{}
└────│││││         unreachable
167 ─│││││         nothing::Nothing
     ││││└
     ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:90 within `#setindex!`
     ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:63 within `pointer`
     │││││┌ @ Base.jl:37 within `getproperty`
168 ┄││││││ %599  = Base.getfield(encodings, :ptr)::Core.LLVMPtr{Float32, 1}
│    ││││└└
│    ││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:88 within `unsafe_store!`
│    │││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `pointerset`
│    ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
│    │││││││ %600  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(i8 addrspace(1)* %0, float %1, i64 %2) #0 {\nentry:\n  %3 = bitcast i8 addrspace(1)* %0 to float addrspace(1)*\n  %4 = getelementptr inbounds float, float addrspace(1)* %3, i64 %2\n  store float %1, float addrspace(1)* %4, align 4, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %601  = Base.sub_int(%585, 1)::Int64
│    │││││││└
│    │││││││         Base.llvmcall(%600, Nothing, Tuple{Core.LLVMPtr{Float32, 1}, Float32, Int64}, %599, %551, %601)::Nothing
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
171 ─││ %606  = Base.mul_float(1.0925485f0, %381)::Float32
│    │└
│    │┌ @ abstractarray.jl:1397 within `setindex!`
│    ││┌ @ indices.jl:350 within `to_indices` @ indices.jl:355 @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %607  = Core.zext_int(Core.Int64, %221)::Int64
│    ││└└└└└└
│    ││┌ @ abstractarray.jl:1419 within `_setindex!`
└────│││         goto #176 if not false
     │││┌ @ abstractarray.jl:707 within `checkbounds`
172 ─││││ %609  = Core.tuple(5, %607)::Tuple{Int64, Int64}
│    ││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:688
│    ││││┌ @ abstractarray.jl:98 within `axes`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
│    ││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││ %610  = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    │││││└└
│    │││││┌ @ tuple.jl:274 within `map`
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %611  = Base.getfield(%610, 1, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %612  = Base.slt_int(%611, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %613  = Core.ifelse(%612, 0, %611)::Int64
│    ││││││└└└└
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %614  = Base.getfield(%610, 2, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %615  = Base.slt_int(%614, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %616  = Core.ifelse(%615, 0, %614)::Int64
│    ││││└└└└└└
│    ││││┌ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %617  = Base.sle_int(1, 5)::Bool
│    │││││││ %618  = Base.sle_int(5, %613)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %619  = Base.and_int(%617, %618)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices` @ abstractarray.jl:735
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %620  = Base.sle_int(1, %607)::Bool
│    │││││││ %621  = Base.sle_int(%607, %616)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %622  = Base.and_int(%620, %621)::Bool
│    │││││└└
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %623  = Base.and_int(%622, true)::Bool
│    │││││└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %624  = Base.and_int(%619, %623)::Bool
│    ││││└└
│    ││││ @ abstractarray.jl:709 within `checkbounds`
└────││││         goto #174 if not %624
     ││││ @ abstractarray.jl:710 within `checkbounds`
173 ─││││         goto #175
     ││││ @ abstractarray.jl:709 within `checkbounds`
174 ─││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %609::Tuple{Int64, Int64})::Union{}
└────││││         unreachable
175 ─││││         nothing::Nothing
     │││└
     │││ @ abstractarray.jl:1420 within `_setindex!`
     │││┌ @ abstractarray.jl:1333 within `_to_linear_index`
     ││││┌ @ abstractarray.jl:2933 within `_sub2ind`
     │││││┌ @ abstractarray.jl:98 within `axes`
     ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
     │││││││┌ @ Base.jl:37 within `getproperty`
176 ┄││││││││ %630  = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    ││││││└└
│    ││││││┌ @ tuple.jl:274 within `map`
│    │││││││┌ @ tuple.jl:29 within `getindex`
│    ││││││││ %631  = Base.getfield(%630, 1, true)::Int64
│    │││││││└
│    │││││││┌ @ range.jl:459 within `oneto`
│    ││││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    │││││││││┌ @ promotion.jl:510 within `max`
│    ││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││ %632  = Base.slt_int(%631, 0)::Bool
│    ││││││││││└
│    ││││││││││┌ @ essentials.jl:575 within `ifelse`
│    │││││││││││ %633  = Core.ifelse(%632, 0, %631)::Int64
│    │││││└└└└└└
│    │││││ @ abstractarray.jl:2933 within `_sub2ind` @ abstractarray.jl:2949
│    │││││┌ @ abstractarray.jl:2965 within `_sub2ind_recurse`
│    ││││││┌ @ abstractarray.jl:2969 within `nextL`
│    │││││││┌ @ int.jl:88 within `*`
│    ││││││││ %634  = Base.mul_int(1, %633)::Int64
│    ││││││└└
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %635  = Base.sub_int(5, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %636  = Base.mul_int(%635, 1)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %637  = Base.add_int(1, %636)::Int64
│    ││││││└
│    ││││││ @ abstractarray.jl:2965 within `_sub2ind_recurse` @ abstractarray.jl:2965
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %638  = Base.sub_int(%607, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %639  = Base.mul_int(%638, %634)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %640  = Base.add_int(%637, %639)::Int64
│    │││└└└└
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:88 within `#setindex!`
└────││││         goto #181 if not false
     ││││┌ @ abstractarray.jl:707 within `checkbounds`
177 ─│││││ %642  = Core.tuple(%640)::Tuple{Int64}
│    │││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│    │││││┌ @ abstractarray.jl:381 within `eachindex`
│    ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:69 within `length`
│    │││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││ %643  = Base.getfield(encodings, :len)::Int64
│    ││││││└└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %644  = Base.slt_int(%643, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %645  = Core.ifelse(%644, 0, %643)::Int64
│    │││││└└└└└
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %646  = Base.sle_int(1, %640)::Bool
│    │││││││ %647  = Base.sle_int(%640, %645)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %648  = Base.and_int(%646, %647)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:709 within `checkbounds`
└────│││││         goto #179 if not %648
     │││││ @ abstractarray.jl:710 within `checkbounds`
178 ─│││││         goto #180
     │││││ @ abstractarray.jl:709 within `checkbounds`
179 ─│││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %642::Tuple{Int64})::Union{}
└────│││││         unreachable
180 ─│││││         nothing::Nothing
     ││││└
     ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:90 within `#setindex!`
     ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:63 within `pointer`
     │││││┌ @ Base.jl:37 within `getproperty`
181 ┄││││││ %654  = Base.getfield(encodings, :ptr)::Core.LLVMPtr{Float32, 1}
│    ││││└└
│    ││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:88 within `unsafe_store!`
│    │││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `pointerset`
│    ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
│    │││││││ %655  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(i8 addrspace(1)* %0, float %1, i64 %2) #0 {\nentry:\n  %3 = bitcast i8 addrspace(1)* %0 to float addrspace(1)*\n  %4 = getelementptr inbounds float, float addrspace(1)* %3, i64 %2\n  store float %1, float addrspace(1)* %4, align 4, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %656  = Base.sub_int(%640, 1)::Int64
│    │││││││└
│    │││││││         Base.llvmcall(%655, Nothing, Tuple{Core.LLVMPtr{Float32, 1}, Float32, Int64}, %654, %606, %656)::Nothing
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
184 ─││ %661  = Base.mul_float(-1.0925485f0, %383)::Float32
│    │└
│    │┌ @ abstractarray.jl:1397 within `setindex!`
│    ││┌ @ indices.jl:350 within `to_indices` @ indices.jl:355 @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %662  = Core.zext_int(Core.Int64, %221)::Int64
│    ││└└└└└└
│    ││┌ @ abstractarray.jl:1419 within `_setindex!`
└────│││         goto #189 if not false
     │││┌ @ abstractarray.jl:707 within `checkbounds`
185 ─││││ %664  = Core.tuple(6, %662)::Tuple{Int64, Int64}
│    ││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:688
│    ││││┌ @ abstractarray.jl:98 within `axes`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
│    ││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││ %665  = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    │││││└└
│    │││││┌ @ tuple.jl:274 within `map`
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %666  = Base.getfield(%665, 1, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %667  = Base.slt_int(%666, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %668  = Core.ifelse(%667, 0, %666)::Int64
│    ││││││└└└└
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %669  = Base.getfield(%665, 2, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %670  = Base.slt_int(%669, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %671  = Core.ifelse(%670, 0, %669)::Int64
│    ││││└└└└└└
│    ││││┌ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %672  = Base.sle_int(1, 6)::Bool
│    │││││││ %673  = Base.sle_int(6, %668)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %674  = Base.and_int(%672, %673)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices` @ abstractarray.jl:735
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %675  = Base.sle_int(1, %662)::Bool
│    │││││││ %676  = Base.sle_int(%662, %671)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %677  = Base.and_int(%675, %676)::Bool
│    │││││└└
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %678  = Base.and_int(%677, true)::Bool
│    │││││└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %679  = Base.and_int(%674, %678)::Bool
│    ││││└└
│    ││││ @ abstractarray.jl:709 within `checkbounds`
└────││││         goto #187 if not %679
     ││││ @ abstractarray.jl:710 within `checkbounds`
186 ─││││         goto #188
     ││││ @ abstractarray.jl:709 within `checkbounds`
187 ─││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %664::Tuple{Int64, Int64})::Union{}
└────││││         unreachable
188 ─││││         nothing::Nothing
     │││└
     │││ @ abstractarray.jl:1420 within `_setindex!`
     │││┌ @ abstractarray.jl:1333 within `_to_linear_index`
     ││││┌ @ abstractarray.jl:2933 within `_sub2ind`
     │││││┌ @ abstractarray.jl:98 within `axes`
     ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
     │││││││┌ @ Base.jl:37 within `getproperty`
189 ┄││││││││ %685  = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    ││││││└└
│    ││││││┌ @ tuple.jl:274 within `map`
│    │││││││┌ @ tuple.jl:29 within `getindex`
│    ││││││││ %686  = Base.getfield(%685, 1, true)::Int64
│    │││││││└
│    │││││││┌ @ range.jl:459 within `oneto`
│    ││││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    │││││││││┌ @ promotion.jl:510 within `max`
│    ││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││ %687  = Base.slt_int(%686, 0)::Bool
│    ││││││││││└
│    ││││││││││┌ @ essentials.jl:575 within `ifelse`
│    │││││││││││ %688  = Core.ifelse(%687, 0, %686)::Int64
│    │││││└└└└└└
│    │││││ @ abstractarray.jl:2933 within `_sub2ind` @ abstractarray.jl:2949
│    │││││┌ @ abstractarray.jl:2965 within `_sub2ind_recurse`
│    ││││││┌ @ abstractarray.jl:2969 within `nextL`
│    │││││││┌ @ int.jl:88 within `*`
│    ││││││││ %689  = Base.mul_int(1, %688)::Int64
│    ││││││└└
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %690  = Base.sub_int(6, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %691  = Base.mul_int(%690, 1)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %692  = Base.add_int(1, %691)::Int64
│    ││││││└
│    ││││││ @ abstractarray.jl:2965 within `_sub2ind_recurse` @ abstractarray.jl:2965
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %693  = Base.sub_int(%662, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %694  = Base.mul_int(%693, %689)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %695  = Base.add_int(%692, %694)::Int64
│    │││└└└└
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:88 within `#setindex!`
└────││││         goto #194 if not false
     ││││┌ @ abstractarray.jl:707 within `checkbounds`
190 ─│││││ %697  = Core.tuple(%695)::Tuple{Int64}
│    │││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│    │││││┌ @ abstractarray.jl:381 within `eachindex`
│    ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:69 within `length`
│    │││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││ %698  = Base.getfield(encodings, :len)::Int64
│    ││││││└└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %699  = Base.slt_int(%698, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %700  = Core.ifelse(%699, 0, %698)::Int64
│    │││││└└└└└
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %701  = Base.sle_int(1, %695)::Bool
│    │││││││ %702  = Base.sle_int(%695, %700)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %703  = Base.and_int(%701, %702)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:709 within `checkbounds`
└────│││││         goto #192 if not %703
     │││││ @ abstractarray.jl:710 within `checkbounds`
191 ─│││││         goto #193
     │││││ @ abstractarray.jl:709 within `checkbounds`
192 ─│││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %697::Tuple{Int64})::Union{}
└────│││││         unreachable
193 ─│││││         nothing::Nothing
     ││││└
     ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:90 within `#setindex!`
     ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:63 within `pointer`
     │││││┌ @ Base.jl:37 within `getproperty`
194 ┄││││││ %709  = Base.getfield(encodings, :ptr)::Core.LLVMPtr{Float32, 1}
│    ││││└└
│    ││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:88 within `unsafe_store!`
│    │││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `pointerset`
│    ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
│    │││││││ %710  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(i8 addrspace(1)* %0, float %1, i64 %2) #0 {\nentry:\n  %3 = bitcast i8 addrspace(1)* %0 to float addrspace(1)*\n  %4 = getelementptr inbounds float, float addrspace(1)* %3, i64 %2\n  store float %1, float addrspace(1)* %4, align 4, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %711  = Base.sub_int(%695, 1)::Int64
│    │││││││└
│    │││││││         Base.llvmcall(%710, Nothing, Tuple{Core.LLVMPtr{Float32, 1}, Float32, Int64}, %709, %661, %711)::Nothing
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
197 ─││ %716  = Base.mul_float(0.9461747f0, %386)::Float32
│    │└
│    │┌ @ float.jl:409 within `-`
│    ││ %717  = Base.sub_float(%716, 0.31539157f0)::Float32
│    │└
│    │┌ @ abstractarray.jl:1397 within `setindex!`
│    ││┌ @ indices.jl:350 within `to_indices` @ indices.jl:355 @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %718  = Core.zext_int(Core.Int64, %221)::Int64
│    ││└└└└└└
│    ││┌ @ abstractarray.jl:1419 within `_setindex!`
└────│││         goto #202 if not false
     │││┌ @ abstractarray.jl:707 within `checkbounds`
198 ─││││ %720  = Core.tuple(7, %718)::Tuple{Int64, Int64}
│    ││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:688
│    ││││┌ @ abstractarray.jl:98 within `axes`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
│    ││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││ %721  = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    │││││└└
│    │││││┌ @ tuple.jl:274 within `map`
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %722  = Base.getfield(%721, 1, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %723  = Base.slt_int(%722, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %724  = Core.ifelse(%723, 0, %722)::Int64
│    ││││││└└└└
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %725  = Base.getfield(%721, 2, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %726  = Base.slt_int(%725, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %727  = Core.ifelse(%726, 0, %725)::Int64
│    ││││└└└└└└
│    ││││┌ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %728  = Base.sle_int(1, 7)::Bool
│    │││││││ %729  = Base.sle_int(7, %724)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %730  = Base.and_int(%728, %729)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices` @ abstractarray.jl:735
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %731  = Base.sle_int(1, %718)::Bool
│    │││││││ %732  = Base.sle_int(%718, %727)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %733  = Base.and_int(%731, %732)::Bool
│    │││││└└
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %734  = Base.and_int(%733, true)::Bool
│    │││││└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %735  = Base.and_int(%730, %734)::Bool
│    ││││└└
│    ││││ @ abstractarray.jl:709 within `checkbounds`
└────││││         goto #200 if not %735
     ││││ @ abstractarray.jl:710 within `checkbounds`
199 ─││││         goto #201
     ││││ @ abstractarray.jl:709 within `checkbounds`
200 ─││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %720::Tuple{Int64, Int64})::Union{}
└────││││         unreachable
201 ─││││         nothing::Nothing
     │││└
     │││ @ abstractarray.jl:1420 within `_setindex!`
     │││┌ @ abstractarray.jl:1333 within `_to_linear_index`
     ││││┌ @ abstractarray.jl:2933 within `_sub2ind`
     │││││┌ @ abstractarray.jl:98 within `axes`
     ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
     │││││││┌ @ Base.jl:37 within `getproperty`
202 ┄││││││││ %741  = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    ││││││└└
│    ││││││┌ @ tuple.jl:274 within `map`
│    │││││││┌ @ tuple.jl:29 within `getindex`
│    ││││││││ %742  = Base.getfield(%741, 1, true)::Int64
│    │││││││└
│    │││││││┌ @ range.jl:459 within `oneto`
│    ││││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    │││││││││┌ @ promotion.jl:510 within `max`
│    ││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││ %743  = Base.slt_int(%742, 0)::Bool
│    ││││││││││└
│    ││││││││││┌ @ essentials.jl:575 within `ifelse`
│    │││││││││││ %744  = Core.ifelse(%743, 0, %742)::Int64
│    │││││└└└└└└
│    │││││ @ abstractarray.jl:2933 within `_sub2ind` @ abstractarray.jl:2949
│    │││││┌ @ abstractarray.jl:2965 within `_sub2ind_recurse`
│    ││││││┌ @ abstractarray.jl:2969 within `nextL`
│    │││││││┌ @ int.jl:88 within `*`
│    ││││││││ %745  = Base.mul_int(1, %744)::Int64
│    ││││││└└
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %746  = Base.sub_int(7, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %747  = Base.mul_int(%746, 1)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %748  = Base.add_int(1, %747)::Int64
│    ││││││└
│    ││││││ @ abstractarray.jl:2965 within `_sub2ind_recurse` @ abstractarray.jl:2965
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %749  = Base.sub_int(%718, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %750  = Base.mul_int(%749, %745)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %751  = Base.add_int(%748, %750)::Int64
│    │││└└└└
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:88 within `#setindex!`
└────││││         goto #207 if not false
     ││││┌ @ abstractarray.jl:707 within `checkbounds`
203 ─│││││ %753  = Core.tuple(%751)::Tuple{Int64}
│    │││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│    │││││┌ @ abstractarray.jl:381 within `eachindex`
│    ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:69 within `length`
│    │││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││ %754  = Base.getfield(encodings, :len)::Int64
│    ││││││└└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %755  = Base.slt_int(%754, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %756  = Core.ifelse(%755, 0, %754)::Int64
│    │││││└└└└└
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %757  = Base.sle_int(1, %751)::Bool
│    │││││││ %758  = Base.sle_int(%751, %756)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %759  = Base.and_int(%757, %758)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:709 within `checkbounds`
└────│││││         goto #205 if not %759
     │││││ @ abstractarray.jl:710 within `checkbounds`
204 ─│││││         goto #206
     │││││ @ abstractarray.jl:709 within `checkbounds`
205 ─│││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %753::Tuple{Int64})::Union{}
└────│││││         unreachable
206 ─│││││         nothing::Nothing
     ││││└
     ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:90 within `#setindex!`
     ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:63 within `pointer`
     │││││┌ @ Base.jl:37 within `getproperty`
207 ┄││││││ %765  = Base.getfield(encodings, :ptr)::Core.LLVMPtr{Float32, 1}
│    ││││└└
│    ││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:88 within `unsafe_store!`
│    │││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `pointerset`
│    ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
│    │││││││ %766  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(i8 addrspace(1)* %0, float %1, i64 %2) #0 {\nentry:\n  %3 = bitcast i8 addrspace(1)* %0 to float addrspace(1)*\n  %4 = getelementptr inbounds float, float addrspace(1)* %3, i64 %2\n  store float %1, float addrspace(1)* %4, align 4, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %767  = Base.sub_int(%751, 1)::Int64
│    │││││││└
│    │││││││         Base.llvmcall(%766, Nothing, Tuple{Core.LLVMPtr{Float32, 1}, Float32, Int64}, %765, %717, %767)::Nothing
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
210 ─││ %772  = Base.mul_float(-1.0925485f0, %382)::Float32
│    │└
│    │┌ @ abstractarray.jl:1397 within `setindex!`
│    ││┌ @ indices.jl:350 within `to_indices` @ indices.jl:355 @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %773  = Core.zext_int(Core.Int64, %221)::Int64
│    ││└└└└└└
│    ││┌ @ abstractarray.jl:1419 within `_setindex!`
└────│││         goto #215 if not false
     │││┌ @ abstractarray.jl:707 within `checkbounds`
211 ─││││ %775  = Core.tuple(8, %773)::Tuple{Int64, Int64}
│    ││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:688
│    ││││┌ @ abstractarray.jl:98 within `axes`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
│    ││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││ %776  = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    │││││└└
│    │││││┌ @ tuple.jl:274 within `map`
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %777  = Base.getfield(%776, 1, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %778  = Base.slt_int(%777, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %779  = Core.ifelse(%778, 0, %777)::Int64
│    ││││││└└└└
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %780  = Base.getfield(%776, 2, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %781  = Base.slt_int(%780, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %782  = Core.ifelse(%781, 0, %780)::Int64
│    ││││└└└└└└
│    ││││┌ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %783  = Base.sle_int(1, 8)::Bool
│    │││││││ %784  = Base.sle_int(8, %779)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %785  = Base.and_int(%783, %784)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices` @ abstractarray.jl:735
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %786  = Base.sle_int(1, %773)::Bool
│    │││││││ %787  = Base.sle_int(%773, %782)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %788  = Base.and_int(%786, %787)::Bool
│    │││││└└
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %789  = Base.and_int(%788, true)::Bool
│    │││││└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %790  = Base.and_int(%785, %789)::Bool
│    ││││└└
│    ││││ @ abstractarray.jl:709 within `checkbounds`
└────││││         goto #213 if not %790
     ││││ @ abstractarray.jl:710 within `checkbounds`
212 ─││││         goto #214
     ││││ @ abstractarray.jl:709 within `checkbounds`
213 ─││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %775::Tuple{Int64, Int64})::Union{}
└────││││         unreachable
214 ─││││         nothing::Nothing
     │││└
     │││ @ abstractarray.jl:1420 within `_setindex!`
     │││┌ @ abstractarray.jl:1333 within `_to_linear_index`
     ││││┌ @ abstractarray.jl:2933 within `_sub2ind`
     │││││┌ @ abstractarray.jl:98 within `axes`
     ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
     │││││││┌ @ Base.jl:37 within `getproperty`
215 ┄││││││││ %796  = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    ││││││└└
│    ││││││┌ @ tuple.jl:274 within `map`
│    │││││││┌ @ tuple.jl:29 within `getindex`
│    ││││││││ %797  = Base.getfield(%796, 1, true)::Int64
│    │││││││└
│    │││││││┌ @ range.jl:459 within `oneto`
│    ││││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    │││││││││┌ @ promotion.jl:510 within `max`
│    ││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││ %798  = Base.slt_int(%797, 0)::Bool
│    ││││││││││└
│    ││││││││││┌ @ essentials.jl:575 within `ifelse`
│    │││││││││││ %799  = Core.ifelse(%798, 0, %797)::Int64
│    │││││└└└└└└
│    │││││ @ abstractarray.jl:2933 within `_sub2ind` @ abstractarray.jl:2949
│    │││││┌ @ abstractarray.jl:2965 within `_sub2ind_recurse`
│    ││││││┌ @ abstractarray.jl:2969 within `nextL`
│    │││││││┌ @ int.jl:88 within `*`
│    ││││││││ %800  = Base.mul_int(1, %799)::Int64
│    ││││││└└
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %801  = Base.sub_int(8, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %802  = Base.mul_int(%801, 1)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %803  = Base.add_int(1, %802)::Int64
│    ││││││└
│    ││││││ @ abstractarray.jl:2965 within `_sub2ind_recurse` @ abstractarray.jl:2965
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %804  = Base.sub_int(%773, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %805  = Base.mul_int(%804, %800)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %806  = Base.add_int(%803, %805)::Int64
│    │││└└└└
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:88 within `#setindex!`
└────││││         goto #220 if not false
     ││││┌ @ abstractarray.jl:707 within `checkbounds`
216 ─│││││ %808  = Core.tuple(%806)::Tuple{Int64}
│    │││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│    │││││┌ @ abstractarray.jl:381 within `eachindex`
│    ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:69 within `length`
│    │││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││ %809  = Base.getfield(encodings, :len)::Int64
│    ││││││└└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %810  = Base.slt_int(%809, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %811  = Core.ifelse(%810, 0, %809)::Int64
│    │││││└└└└└
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %812  = Base.sle_int(1, %806)::Bool
│    │││││││ %813  = Base.sle_int(%806, %811)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %814  = Base.and_int(%812, %813)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:709 within `checkbounds`
└────│││││         goto #218 if not %814
     │││││ @ abstractarray.jl:710 within `checkbounds`
217 ─│││││         goto #219
     │││││ @ abstractarray.jl:709 within `checkbounds`
218 ─│││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %808::Tuple{Int64})::Union{}
└────│││││         unreachable
219 ─│││││         nothing::Nothing
     ││││└
     ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:90 within `#setindex!`
     ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:63 within `pointer`
     │││││┌ @ Base.jl:37 within `getproperty`
220 ┄││││││ %820  = Base.getfield(encodings, :ptr)::Core.LLVMPtr{Float32, 1}
│    ││││└└
│    ││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:88 within `unsafe_store!`
│    │││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `pointerset`
│    ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
│    │││││││ %821  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(i8 addrspace(1)* %0, float %1, i64 %2) #0 {\nentry:\n  %3 = bitcast i8 addrspace(1)* %0 to float addrspace(1)*\n  %4 = getelementptr inbounds float, float addrspace(1)* %3, i64 %2\n  store float %1, float addrspace(1)* %4, align 4, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %822  = Base.sub_int(%806, 1)::Int64
│    │││││││└
│    │││││││         Base.llvmcall(%821, Nothing, Tuple{Core.LLVMPtr{Float32, 1}, Float32, Int64}, %820, %772, %822)::Nothing
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
223 ─││ %827  = Base.mul_float(0.54627424f0, %384)::Float32
│    ││ %828  = Base.mul_float(0.54627424f0, %385)::Float32
│    │└
│    │┌ @ float.jl:409 within `-`
│    ││ %829  = Base.sub_float(%827, %828)::Float32
│    │└
│    │┌ @ abstractarray.jl:1397 within `setindex!`
│    ││┌ @ indices.jl:350 within `to_indices` @ indices.jl:355 @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %830  = Core.zext_int(Core.Int64, %221)::Int64
│    ││└└└└└└
│    ││┌ @ abstractarray.jl:1419 within `_setindex!`
└────│││         goto #228 if not false
     │││┌ @ abstractarray.jl:707 within `checkbounds`
224 ─││││ %832  = Core.tuple(9, %830)::Tuple{Int64, Int64}
│    ││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:688
│    ││││┌ @ abstractarray.jl:98 within `axes`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
│    ││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││ %833  = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    │││││└└
│    │││││┌ @ tuple.jl:274 within `map`
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %834  = Base.getfield(%833, 1, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %835  = Base.slt_int(%834, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %836  = Core.ifelse(%835, 0, %834)::Int64
│    ││││││└└└└
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %837  = Base.getfield(%833, 2, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %838  = Base.slt_int(%837, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %839  = Core.ifelse(%838, 0, %837)::Int64
│    ││││└└└└└└
│    ││││┌ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %840  = Base.sle_int(1, 9)::Bool
│    │││││││ %841  = Base.sle_int(9, %836)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %842  = Base.and_int(%840, %841)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices` @ abstractarray.jl:735
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %843  = Base.sle_int(1, %830)::Bool
│    │││││││ %844  = Base.sle_int(%830, %839)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %845  = Base.and_int(%843, %844)::Bool
│    │││││└└
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %846  = Base.and_int(%845, true)::Bool
│    │││││└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %847  = Base.and_int(%842, %846)::Bool
│    ││││└└
│    ││││ @ abstractarray.jl:709 within `checkbounds`
└────││││         goto #226 if not %847
     ││││ @ abstractarray.jl:710 within `checkbounds`
225 ─││││         goto #227
     ││││ @ abstractarray.jl:709 within `checkbounds`
226 ─││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %832::Tuple{Int64, Int64})::Union{}
└────││││         unreachable
227 ─││││         nothing::Nothing
     │││└
     │││ @ abstractarray.jl:1420 within `_setindex!`
     │││┌ @ abstractarray.jl:1333 within `_to_linear_index`
     ││││┌ @ abstractarray.jl:2933 within `_sub2ind`
     │││││┌ @ abstractarray.jl:98 within `axes`
     ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
     │││││││┌ @ Base.jl:37 within `getproperty`
228 ┄││││││││ %853  = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    ││││││└└
│    ││││││┌ @ tuple.jl:274 within `map`
│    │││││││┌ @ tuple.jl:29 within `getindex`
│    ││││││││ %854  = Base.getfield(%853, 1, true)::Int64
│    │││││││└
│    │││││││┌ @ range.jl:459 within `oneto`
│    ││││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    │││││││││┌ @ promotion.jl:510 within `max`
│    ││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││ %855  = Base.slt_int(%854, 0)::Bool
│    ││││││││││└
│    ││││││││││┌ @ essentials.jl:575 within `ifelse`
│    │││││││││││ %856  = Core.ifelse(%855, 0, %854)::Int64
│    │││││└└└└└└
│    │││││ @ abstractarray.jl:2933 within `_sub2ind` @ abstractarray.jl:2949
│    │││││┌ @ abstractarray.jl:2965 within `_sub2ind_recurse`
│    ││││││┌ @ abstractarray.jl:2969 within `nextL`
│    │││││││┌ @ int.jl:88 within `*`
│    ││││││││ %857  = Base.mul_int(1, %856)::Int64
│    ││││││└└
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %858  = Base.sub_int(9, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %859  = Base.mul_int(%858, 1)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %860  = Base.add_int(1, %859)::Int64
│    ││││││└
│    ││││││ @ abstractarray.jl:2965 within `_sub2ind_recurse` @ abstractarray.jl:2965
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %861  = Base.sub_int(%830, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %862  = Base.mul_int(%861, %857)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %863  = Base.add_int(%860, %862)::Int64
│    │││└└└└
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:88 within `#setindex!`
└────││││         goto #233 if not false
     ││││┌ @ abstractarray.jl:707 within `checkbounds`
229 ─│││││ %865  = Core.tuple(%863)::Tuple{Int64}
│    │││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│    │││││┌ @ abstractarray.jl:381 within `eachindex`
│    ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:69 within `length`
│    │││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││ %866  = Base.getfield(encodings, :len)::Int64
│    ││││││└└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %867  = Base.slt_int(%866, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %868  = Core.ifelse(%867, 0, %866)::Int64
│    │││││└└└└└
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %869  = Base.sle_int(1, %863)::Bool
│    │││││││ %870  = Base.sle_int(%863, %868)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %871  = Base.and_int(%869, %870)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:709 within `checkbounds`
└────│││││         goto #231 if not %871
     │││││ @ abstractarray.jl:710 within `checkbounds`
230 ─│││││         goto #232
     │││││ @ abstractarray.jl:709 within `checkbounds`
231 ─│││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %865::Tuple{Int64})::Union{}
└────│││││         unreachable
232 ─│││││         nothing::Nothing
     ││││└
     ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:90 within `#setindex!`
     ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:63 within `pointer`
     │││││┌ @ Base.jl:37 within `getproperty`
233 ┄││││││ %877  = Base.getfield(encodings, :ptr)::Core.LLVMPtr{Float32, 1}
│    ││││└└
│    ││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:88 within `unsafe_store!`
│    │││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `pointerset`
│    ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
│    │││││││ %878  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(i8 addrspace(1)* %0, float %1, i64 %2) #0 {\nentry:\n  %3 = bitcast i8 addrspace(1)* %0 to float addrspace(1)*\n  %4 = getelementptr inbounds float, float addrspace(1)* %3, i64 %2\n  store float %1, float addrspace(1)* %4, align 4, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %879  = Base.sub_int(%863, 1)::Int64
│    │││││││└
│    │││││││         Base.llvmcall(%878, Nothing, Tuple{Core.LLVMPtr{Float32, 1}, Float32, Int64}, %877, %829, %879)::Nothing
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
236 ─││ %884  = Base.mul_float(-3.0f0, %384)::Float32
│    │└
│    │┌ @ float.jl:408 within `+`
│    ││ %885  = Base.add_float(%884, %385)::Float32
│    │└
│    │┌ @ operators.jl:578 within `*` @ float.jl:410
│    ││ %886  = Base.mul_float(0.5900436f0, %327)::Float32
│    ││ %887  = Base.mul_float(%886, %885)::Float32
│    │└
│    │┌ @ abstractarray.jl:1397 within `setindex!`
│    ││┌ @ indices.jl:350 within `to_indices` @ indices.jl:355 @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %888  = Core.zext_int(Core.Int64, %221)::Int64
│    ││└└└└└└
│    ││┌ @ abstractarray.jl:1419 within `_setindex!`
└────│││         goto #241 if not false
     │││┌ @ abstractarray.jl:707 within `checkbounds`
237 ─││││ %890  = Core.tuple(10, %888)::Tuple{Int64, Int64}
│    ││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:688
│    ││││┌ @ abstractarray.jl:98 within `axes`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
│    ││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││ %891  = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    │││││└└
│    │││││┌ @ tuple.jl:274 within `map`
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %892  = Base.getfield(%891, 1, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %893  = Base.slt_int(%892, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %894  = Core.ifelse(%893, 0, %892)::Int64
│    ││││││└└└└
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %895  = Base.getfield(%891, 2, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %896  = Base.slt_int(%895, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %897  = Core.ifelse(%896, 0, %895)::Int64
│    ││││└└└└└└
│    ││││┌ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %898  = Base.sle_int(1, 10)::Bool
│    │││││││ %899  = Base.sle_int(10, %894)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %900  = Base.and_int(%898, %899)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices` @ abstractarray.jl:735
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %901  = Base.sle_int(1, %888)::Bool
│    │││││││ %902  = Base.sle_int(%888, %897)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %903  = Base.and_int(%901, %902)::Bool
│    │││││└└
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %904  = Base.and_int(%903, true)::Bool
│    │││││└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %905  = Base.and_int(%900, %904)::Bool
│    ││││└└
│    ││││ @ abstractarray.jl:709 within `checkbounds`
└────││││         goto #239 if not %905
     ││││ @ abstractarray.jl:710 within `checkbounds`
238 ─││││         goto #240
     ││││ @ abstractarray.jl:709 within `checkbounds`
239 ─││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %890::Tuple{Int64, Int64})::Union{}
└────││││         unreachable
240 ─││││         nothing::Nothing
     │││└
     │││ @ abstractarray.jl:1420 within `_setindex!`
     │││┌ @ abstractarray.jl:1333 within `_to_linear_index`
     ││││┌ @ abstractarray.jl:2933 within `_sub2ind`
     │││││┌ @ abstractarray.jl:98 within `axes`
     ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
     │││││││┌ @ Base.jl:37 within `getproperty`
241 ┄││││││││ %911  = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    ││││││└└
│    ││││││┌ @ tuple.jl:274 within `map`
│    │││││││┌ @ tuple.jl:29 within `getindex`
│    ││││││││ %912  = Base.getfield(%911, 1, true)::Int64
│    │││││││└
│    │││││││┌ @ range.jl:459 within `oneto`
│    ││││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    │││││││││┌ @ promotion.jl:510 within `max`
│    ││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││ %913  = Base.slt_int(%912, 0)::Bool
│    ││││││││││└
│    ││││││││││┌ @ essentials.jl:575 within `ifelse`
│    │││││││││││ %914  = Core.ifelse(%913, 0, %912)::Int64
│    │││││└└└└└└
│    │││││ @ abstractarray.jl:2933 within `_sub2ind` @ abstractarray.jl:2949
│    │││││┌ @ abstractarray.jl:2965 within `_sub2ind_recurse`
│    ││││││┌ @ abstractarray.jl:2969 within `nextL`
│    │││││││┌ @ int.jl:88 within `*`
│    ││││││││ %915  = Base.mul_int(1, %914)::Int64
│    ││││││└└
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %916  = Base.sub_int(10, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %917  = Base.mul_int(%916, 1)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %918  = Base.add_int(1, %917)::Int64
│    ││││││└
│    ││││││ @ abstractarray.jl:2965 within `_sub2ind_recurse` @ abstractarray.jl:2965
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %919  = Base.sub_int(%888, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %920  = Base.mul_int(%919, %915)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %921  = Base.add_int(%918, %920)::Int64
│    │││└└└└
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:88 within `#setindex!`
└────││││         goto #246 if not false
     ││││┌ @ abstractarray.jl:707 within `checkbounds`
242 ─│││││ %923  = Core.tuple(%921)::Tuple{Int64}
│    │││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│    │││││┌ @ abstractarray.jl:381 within `eachindex`
│    ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:69 within `length`
│    │││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││ %924  = Base.getfield(encodings, :len)::Int64
│    ││││││└└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %925  = Base.slt_int(%924, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %926  = Core.ifelse(%925, 0, %924)::Int64
│    │││││└└└└└
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %927  = Base.sle_int(1, %921)::Bool
│    │││││││ %928  = Base.sle_int(%921, %926)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %929  = Base.and_int(%927, %928)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:709 within `checkbounds`
└────│││││         goto #244 if not %929
     │││││ @ abstractarray.jl:710 within `checkbounds`
243 ─│││││         goto #245
     │││││ @ abstractarray.jl:709 within `checkbounds`
244 ─│││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %923::Tuple{Int64})::Union{}
└────│││││         unreachable
245 ─│││││         nothing::Nothing
     ││││└
     ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:90 within `#setindex!`
     ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:63 within `pointer`
     │││││┌ @ Base.jl:37 within `getproperty`
246 ┄││││││ %935  = Base.getfield(encodings, :ptr)::Core.LLVMPtr{Float32, 1}
│    ││││└└
│    ││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:88 within `unsafe_store!`
│    │││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `pointerset`
│    ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
│    │││││││ %936  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(i8 addrspace(1)* %0, float %1, i64 %2) #0 {\nentry:\n  %3 = bitcast i8 addrspace(1)* %0 to float addrspace(1)*\n  %4 = getelementptr inbounds float, float addrspace(1)* %3, i64 %2\n  store float %1, float addrspace(1)* %4, align 4, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %937  = Base.sub_int(%921, 1)::Int64
│    │││││││└
│    │││││││         Base.llvmcall(%936, Nothing, Tuple{Core.LLVMPtr{Float32, 1}, Float32, Int64}, %935, %887, %937)::Nothing
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
249 ─││ %942  = Base.mul_float(2.8906114f0, %381)::Float32
│    ││ %943  = Base.mul_float(%942, %377)::Float32
│    │└
│    │┌ @ abstractarray.jl:1397 within `setindex!`
│    ││┌ @ indices.jl:350 within `to_indices` @ indices.jl:355 @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %944  = Core.zext_int(Core.Int64, %221)::Int64
│    ││└└└└└└
│    ││┌ @ abstractarray.jl:1419 within `_setindex!`
└────│││         goto #254 if not false
     │││┌ @ abstractarray.jl:707 within `checkbounds`
250 ─││││ %946  = Core.tuple(11, %944)::Tuple{Int64, Int64}
│    ││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:688
│    ││││┌ @ abstractarray.jl:98 within `axes`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
│    ││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││ %947  = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    │││││└└
│    │││││┌ @ tuple.jl:274 within `map`
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %948  = Base.getfield(%947, 1, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %949  = Base.slt_int(%948, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %950  = Core.ifelse(%949, 0, %948)::Int64
│    ││││││└└└└
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %951  = Base.getfield(%947, 2, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %952  = Base.slt_int(%951, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %953  = Core.ifelse(%952, 0, %951)::Int64
│    ││││└└└└└└
│    ││││┌ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %954  = Base.sle_int(1, 11)::Bool
│    │││││││ %955  = Base.sle_int(11, %950)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %956  = Base.and_int(%954, %955)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices` @ abstractarray.jl:735
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %957  = Base.sle_int(1, %944)::Bool
│    │││││││ %958  = Base.sle_int(%944, %953)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %959  = Base.and_int(%957, %958)::Bool
│    │││││└└
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %960  = Base.and_int(%959, true)::Bool
│    │││││└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %961  = Base.and_int(%956, %960)::Bool
│    ││││└└
│    ││││ @ abstractarray.jl:709 within `checkbounds`
└────││││         goto #252 if not %961
     ││││ @ abstractarray.jl:710 within `checkbounds`
251 ─││││         goto #253
     ││││ @ abstractarray.jl:709 within `checkbounds`
252 ─││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %946::Tuple{Int64, Int64})::Union{}
└────││││         unreachable
253 ─││││         nothing::Nothing
     │││└
     │││ @ abstractarray.jl:1420 within `_setindex!`
     │││┌ @ abstractarray.jl:1333 within `_to_linear_index`
     ││││┌ @ abstractarray.jl:2933 within `_sub2ind`
     │││││┌ @ abstractarray.jl:98 within `axes`
     ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
     │││││││┌ @ Base.jl:37 within `getproperty`
254 ┄││││││││ %967  = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    ││││││└└
│    ││││││┌ @ tuple.jl:274 within `map`
│    │││││││┌ @ tuple.jl:29 within `getindex`
│    ││││││││ %968  = Base.getfield(%967, 1, true)::Int64
│    │││││││└
│    │││││││┌ @ range.jl:459 within `oneto`
│    ││││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    │││││││││┌ @ promotion.jl:510 within `max`
│    ││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││ %969  = Base.slt_int(%968, 0)::Bool
│    ││││││││││└
│    ││││││││││┌ @ essentials.jl:575 within `ifelse`
│    │││││││││││ %970  = Core.ifelse(%969, 0, %968)::Int64
│    │││││└└└└└└
│    │││││ @ abstractarray.jl:2933 within `_sub2ind` @ abstractarray.jl:2949
│    │││││┌ @ abstractarray.jl:2965 within `_sub2ind_recurse`
│    ││││││┌ @ abstractarray.jl:2969 within `nextL`
│    │││││││┌ @ int.jl:88 within `*`
│    ││││││││ %971  = Base.mul_int(1, %970)::Int64
│    ││││││└└
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %972  = Base.sub_int(11, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %973  = Base.mul_int(%972, 1)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %974  = Base.add_int(1, %973)::Int64
│    ││││││└
│    ││││││ @ abstractarray.jl:2965 within `_sub2ind_recurse` @ abstractarray.jl:2965
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %975  = Base.sub_int(%944, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %976  = Base.mul_int(%975, %971)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %977  = Base.add_int(%974, %976)::Int64
│    │││└└└└
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:88 within `#setindex!`
└────││││         goto #259 if not false
     ││││┌ @ abstractarray.jl:707 within `checkbounds`
255 ─│││││ %979  = Core.tuple(%977)::Tuple{Int64}
│    │││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│    │││││┌ @ abstractarray.jl:381 within `eachindex`
│    ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:69 within `length`
│    │││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││ %980  = Base.getfield(encodings, :len)::Int64
│    ││││││└└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %981  = Base.slt_int(%980, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %982  = Core.ifelse(%981, 0, %980)::Int64
│    │││││└└└└└
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %983  = Base.sle_int(1, %977)::Bool
│    │││││││ %984  = Base.sle_int(%977, %982)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %985  = Base.and_int(%983, %984)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:709 within `checkbounds`
└────│││││         goto #257 if not %985
     │││││ @ abstractarray.jl:710 within `checkbounds`
256 ─│││││         goto #258
     │││││ @ abstractarray.jl:709 within `checkbounds`
257 ─│││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %979::Tuple{Int64})::Union{}
└────│││││         unreachable
258 ─│││││         nothing::Nothing
     ││││└
     ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:90 within `#setindex!`
     ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:63 within `pointer`
     │││││┌ @ Base.jl:37 within `getproperty`
259 ┄││││││ %991  = Base.getfield(encodings, :ptr)::Core.LLVMPtr{Float32, 1}
│    ││││└└
│    ││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:88 within `unsafe_store!`
│    │││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `pointerset`
│    ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
│    │││││││ %992  = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(i8 addrspace(1)* %0, float %1, i64 %2) #0 {\nentry:\n  %3 = bitcast i8 addrspace(1)* %0 to float addrspace(1)*\n  %4 = getelementptr inbounds float, float addrspace(1)* %3, i64 %2\n  store float %1, float addrspace(1)* %4, align 4, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %993  = Base.sub_int(%977, 1)::Int64
│    │││││││└
│    │││││││         Base.llvmcall(%992, Nothing, Tuple{Core.LLVMPtr{Float32, 1}, Float32, Int64}, %991, %943, %993)::Nothing
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
262 ─││ %998  = Base.mul_float(5.0f0, %386)::Float32
│    │└
│    │┌ @ float.jl:409 within `-`
│    ││ %999  = Base.sub_float(1.0f0, %998)::Float32
│    │└
│    │┌ @ operators.jl:578 within `*` @ float.jl:410
│    ││ %1000 = Base.mul_float(0.4570458f0, %327)::Float32
│    ││ %1001 = Base.mul_float(%1000, %999)::Float32
│    │└
│    │┌ @ abstractarray.jl:1397 within `setindex!`
│    ││┌ @ indices.jl:350 within `to_indices` @ indices.jl:355 @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %1002 = Core.zext_int(Core.Int64, %221)::Int64
│    ││└└└└└└
│    ││┌ @ abstractarray.jl:1419 within `_setindex!`
└────│││         goto #267 if not false
     │││┌ @ abstractarray.jl:707 within `checkbounds`
263 ─││││ %1004 = Core.tuple(12, %1002)::Tuple{Int64, Int64}
│    ││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:688
│    ││││┌ @ abstractarray.jl:98 within `axes`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
│    ││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││ %1005 = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    │││││└└
│    │││││┌ @ tuple.jl:274 within `map`
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %1006 = Base.getfield(%1005, 1, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %1007 = Base.slt_int(%1006, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %1008 = Core.ifelse(%1007, 0, %1006)::Int64
│    ││││││└└└└
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %1009 = Base.getfield(%1005, 2, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %1010 = Base.slt_int(%1009, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %1011 = Core.ifelse(%1010, 0, %1009)::Int64
│    ││││└└└└└└
│    ││││┌ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %1012 = Base.sle_int(1, 12)::Bool
│    │││││││ %1013 = Base.sle_int(12, %1008)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %1014 = Base.and_int(%1012, %1013)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices` @ abstractarray.jl:735
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %1015 = Base.sle_int(1, %1002)::Bool
│    │││││││ %1016 = Base.sle_int(%1002, %1011)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %1017 = Base.and_int(%1015, %1016)::Bool
│    │││││└└
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %1018 = Base.and_int(%1017, true)::Bool
│    │││││└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %1019 = Base.and_int(%1014, %1018)::Bool
│    ││││└└
│    ││││ @ abstractarray.jl:709 within `checkbounds`
└────││││         goto #265 if not %1019
     ││││ @ abstractarray.jl:710 within `checkbounds`
264 ─││││         goto #266
     ││││ @ abstractarray.jl:709 within `checkbounds`
265 ─││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %1004::Tuple{Int64, Int64})::Union{}
└────││││         unreachable
266 ─││││         nothing::Nothing
     │││└
     │││ @ abstractarray.jl:1420 within `_setindex!`
     │││┌ @ abstractarray.jl:1333 within `_to_linear_index`
     ││││┌ @ abstractarray.jl:2933 within `_sub2ind`
     │││││┌ @ abstractarray.jl:98 within `axes`
     ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
     │││││││┌ @ Base.jl:37 within `getproperty`
267 ┄││││││││ %1025 = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    ││││││└└
│    ││││││┌ @ tuple.jl:274 within `map`
│    │││││││┌ @ tuple.jl:29 within `getindex`
│    ││││││││ %1026 = Base.getfield(%1025, 1, true)::Int64
│    │││││││└
│    │││││││┌ @ range.jl:459 within `oneto`
│    ││││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    │││││││││┌ @ promotion.jl:510 within `max`
│    ││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││ %1027 = Base.slt_int(%1026, 0)::Bool
│    ││││││││││└
│    ││││││││││┌ @ essentials.jl:575 within `ifelse`
│    │││││││││││ %1028 = Core.ifelse(%1027, 0, %1026)::Int64
│    │││││└└└└└└
│    │││││ @ abstractarray.jl:2933 within `_sub2ind` @ abstractarray.jl:2949
│    │││││┌ @ abstractarray.jl:2965 within `_sub2ind_recurse`
│    ││││││┌ @ abstractarray.jl:2969 within `nextL`
│    │││││││┌ @ int.jl:88 within `*`
│    ││││││││ %1029 = Base.mul_int(1, %1028)::Int64
│    ││││││└└
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %1030 = Base.sub_int(12, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %1031 = Base.mul_int(%1030, 1)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %1032 = Base.add_int(1, %1031)::Int64
│    ││││││└
│    ││││││ @ abstractarray.jl:2965 within `_sub2ind_recurse` @ abstractarray.jl:2965
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %1033 = Base.sub_int(%1002, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %1034 = Base.mul_int(%1033, %1029)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %1035 = Base.add_int(%1032, %1034)::Int64
│    │││└└└└
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:88 within `#setindex!`
└────││││         goto #272 if not false
     ││││┌ @ abstractarray.jl:707 within `checkbounds`
268 ─│││││ %1037 = Core.tuple(%1035)::Tuple{Int64}
│    │││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│    │││││┌ @ abstractarray.jl:381 within `eachindex`
│    ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:69 within `length`
│    │││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││ %1038 = Base.getfield(encodings, :len)::Int64
│    ││││││└└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %1039 = Base.slt_int(%1038, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %1040 = Core.ifelse(%1039, 0, %1038)::Int64
│    │││││└└└└└
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %1041 = Base.sle_int(1, %1035)::Bool
│    │││││││ %1042 = Base.sle_int(%1035, %1040)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %1043 = Base.and_int(%1041, %1042)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:709 within `checkbounds`
└────│││││         goto #270 if not %1043
     │││││ @ abstractarray.jl:710 within `checkbounds`
269 ─│││││         goto #271
     │││││ @ abstractarray.jl:709 within `checkbounds`
270 ─│││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %1037::Tuple{Int64})::Union{}
└────│││││         unreachable
271 ─│││││         nothing::Nothing
     ││││└
     ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:90 within `#setindex!`
     ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:63 within `pointer`
     │││││┌ @ Base.jl:37 within `getproperty`
272 ┄││││││ %1049 = Base.getfield(encodings, :ptr)::Core.LLVMPtr{Float32, 1}
│    ││││└└
│    ││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:88 within `unsafe_store!`
│    │││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `pointerset`
│    ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
│    │││││││ %1050 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(i8 addrspace(1)* %0, float %1, i64 %2) #0 {\nentry:\n  %3 = bitcast i8 addrspace(1)* %0 to float addrspace(1)*\n  %4 = getelementptr inbounds float, float addrspace(1)* %3, i64 %2\n  store float %1, float addrspace(1)* %4, align 4, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %1051 = Base.sub_int(%1035, 1)::Int64
│    │││││││└
│    │││││││         Base.llvmcall(%1050, Nothing, Tuple{Core.LLVMPtr{Float32, 1}, Float32, Int64}, %1049, %1001, %1051)::Nothing
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
275 ─││ %1056 = Base.mul_float(5.0f0, %386)::Float32
│    │└
│    │┌ @ float.jl:409 within `-`
│    ││ %1057 = Base.sub_float(%1056, 3.0f0)::Float32
│    │└
│    │┌ @ operators.jl:578 within `*` @ float.jl:410
│    ││ %1058 = Base.mul_float(0.37317634f0, %377)::Float32
│    ││ %1059 = Base.mul_float(%1058, %1057)::Float32
│    │└
│    │┌ @ abstractarray.jl:1397 within `setindex!`
│    ││┌ @ indices.jl:350 within `to_indices` @ indices.jl:355 @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %1060 = Core.zext_int(Core.Int64, %221)::Int64
│    ││└└└└└└
│    ││┌ @ abstractarray.jl:1419 within `_setindex!`
└────│││         goto #280 if not false
     │││┌ @ abstractarray.jl:707 within `checkbounds`
276 ─││││ %1062 = Core.tuple(13, %1060)::Tuple{Int64, Int64}
│    ││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:688
│    ││││┌ @ abstractarray.jl:98 within `axes`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
│    ││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││ %1063 = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    │││││└└
│    │││││┌ @ tuple.jl:274 within `map`
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %1064 = Base.getfield(%1063, 1, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %1065 = Base.slt_int(%1064, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %1066 = Core.ifelse(%1065, 0, %1064)::Int64
│    ││││││└└└└
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %1067 = Base.getfield(%1063, 2, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %1068 = Base.slt_int(%1067, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %1069 = Core.ifelse(%1068, 0, %1067)::Int64
│    ││││└└└└└└
│    ││││┌ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %1070 = Base.sle_int(1, 13)::Bool
│    │││││││ %1071 = Base.sle_int(13, %1066)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %1072 = Base.and_int(%1070, %1071)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices` @ abstractarray.jl:735
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %1073 = Base.sle_int(1, %1060)::Bool
│    │││││││ %1074 = Base.sle_int(%1060, %1069)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %1075 = Base.and_int(%1073, %1074)::Bool
│    │││││└└
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %1076 = Base.and_int(%1075, true)::Bool
│    │││││└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %1077 = Base.and_int(%1072, %1076)::Bool
│    ││││└└
│    ││││ @ abstractarray.jl:709 within `checkbounds`
└────││││         goto #278 if not %1077
     ││││ @ abstractarray.jl:710 within `checkbounds`
277 ─││││         goto #279
     ││││ @ abstractarray.jl:709 within `checkbounds`
278 ─││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %1062::Tuple{Int64, Int64})::Union{}
└────││││         unreachable
279 ─││││         nothing::Nothing
     │││└
     │││ @ abstractarray.jl:1420 within `_setindex!`
     │││┌ @ abstractarray.jl:1333 within `_to_linear_index`
     ││││┌ @ abstractarray.jl:2933 within `_sub2ind`
     │││││┌ @ abstractarray.jl:98 within `axes`
     ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
     │││││││┌ @ Base.jl:37 within `getproperty`
280 ┄││││││││ %1083 = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    ││││││└└
│    ││││││┌ @ tuple.jl:274 within `map`
│    │││││││┌ @ tuple.jl:29 within `getindex`
│    ││││││││ %1084 = Base.getfield(%1083, 1, true)::Int64
│    │││││││└
│    │││││││┌ @ range.jl:459 within `oneto`
│    ││││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    │││││││││┌ @ promotion.jl:510 within `max`
│    ││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││ %1085 = Base.slt_int(%1084, 0)::Bool
│    ││││││││││└
│    ││││││││││┌ @ essentials.jl:575 within `ifelse`
│    │││││││││││ %1086 = Core.ifelse(%1085, 0, %1084)::Int64
│    │││││└└└└└└
│    │││││ @ abstractarray.jl:2933 within `_sub2ind` @ abstractarray.jl:2949
│    │││││┌ @ abstractarray.jl:2965 within `_sub2ind_recurse`
│    ││││││┌ @ abstractarray.jl:2969 within `nextL`
│    │││││││┌ @ int.jl:88 within `*`
│    ││││││││ %1087 = Base.mul_int(1, %1086)::Int64
│    ││││││└└
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %1088 = Base.sub_int(13, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %1089 = Base.mul_int(%1088, 1)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %1090 = Base.add_int(1, %1089)::Int64
│    ││││││└
│    ││││││ @ abstractarray.jl:2965 within `_sub2ind_recurse` @ abstractarray.jl:2965
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %1091 = Base.sub_int(%1060, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %1092 = Base.mul_int(%1091, %1087)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %1093 = Base.add_int(%1090, %1092)::Int64
│    │││└└└└
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:88 within `#setindex!`
└────││││         goto #285 if not false
     ││││┌ @ abstractarray.jl:707 within `checkbounds`
281 ─│││││ %1095 = Core.tuple(%1093)::Tuple{Int64}
│    │││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│    │││││┌ @ abstractarray.jl:381 within `eachindex`
│    ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:69 within `length`
│    │││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││ %1096 = Base.getfield(encodings, :len)::Int64
│    ││││││└└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %1097 = Base.slt_int(%1096, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %1098 = Core.ifelse(%1097, 0, %1096)::Int64
│    │││││└└└└└
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %1099 = Base.sle_int(1, %1093)::Bool
│    │││││││ %1100 = Base.sle_int(%1093, %1098)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %1101 = Base.and_int(%1099, %1100)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:709 within `checkbounds`
└────│││││         goto #283 if not %1101
     │││││ @ abstractarray.jl:710 within `checkbounds`
282 ─│││││         goto #284
     │││││ @ abstractarray.jl:709 within `checkbounds`
283 ─│││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %1095::Tuple{Int64})::Union{}
└────│││││         unreachable
284 ─│││││         nothing::Nothing
     ││││└
     ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:90 within `#setindex!`
     ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:63 within `pointer`
     │││││┌ @ Base.jl:37 within `getproperty`
285 ┄││││││ %1107 = Base.getfield(encodings, :ptr)::Core.LLVMPtr{Float32, 1}
│    ││││└└
│    ││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:88 within `unsafe_store!`
│    │││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `pointerset`
│    ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
│    │││││││ %1108 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(i8 addrspace(1)* %0, float %1, i64 %2) #0 {\nentry:\n  %3 = bitcast i8 addrspace(1)* %0 to float addrspace(1)*\n  %4 = getelementptr inbounds float, float addrspace(1)* %3, i64 %2\n  store float %1, float addrspace(1)* %4, align 4, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %1109 = Base.sub_int(%1093, 1)::Int64
│    │││││││└
│    │││││││         Base.llvmcall(%1108, Nothing, Tuple{Core.LLVMPtr{Float32, 1}, Float32, Int64}, %1107, %1059, %1109)::Nothing
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
288 ─││ %1114 = Base.mul_float(5.0f0, %386)::Float32
│    │└
│    │┌ @ float.jl:409 within `-`
│    ││ %1115 = Base.sub_float(1.0f0, %1114)::Float32
│    │└
│    │┌ @ operators.jl:578 within `*` @ float.jl:410
│    ││ %1116 = Base.mul_float(0.4570458f0, %277)::Float32
│    ││ %1117 = Base.mul_float(%1116, %1115)::Float32
│    │└
│    │┌ @ abstractarray.jl:1397 within `setindex!`
│    ││┌ @ indices.jl:350 within `to_indices` @ indices.jl:355 @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %1118 = Core.zext_int(Core.Int64, %221)::Int64
│    ││└└└└└└
│    ││┌ @ abstractarray.jl:1419 within `_setindex!`
└────│││         goto #293 if not false
     │││┌ @ abstractarray.jl:707 within `checkbounds`
289 ─││││ %1120 = Core.tuple(14, %1118)::Tuple{Int64, Int64}
│    ││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:688
│    ││││┌ @ abstractarray.jl:98 within `axes`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
│    ││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││ %1121 = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    │││││└└
│    │││││┌ @ tuple.jl:274 within `map`
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %1122 = Base.getfield(%1121, 1, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %1123 = Base.slt_int(%1122, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %1124 = Core.ifelse(%1123, 0, %1122)::Int64
│    ││││││└└└└
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %1125 = Base.getfield(%1121, 2, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %1126 = Base.slt_int(%1125, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %1127 = Core.ifelse(%1126, 0, %1125)::Int64
│    ││││└└└└└└
│    ││││┌ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %1128 = Base.sle_int(1, 14)::Bool
│    │││││││ %1129 = Base.sle_int(14, %1124)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %1130 = Base.and_int(%1128, %1129)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices` @ abstractarray.jl:735
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %1131 = Base.sle_int(1, %1118)::Bool
│    │││││││ %1132 = Base.sle_int(%1118, %1127)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %1133 = Base.and_int(%1131, %1132)::Bool
│    │││││└└
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %1134 = Base.and_int(%1133, true)::Bool
│    │││││└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %1135 = Base.and_int(%1130, %1134)::Bool
│    ││││└└
│    ││││ @ abstractarray.jl:709 within `checkbounds`
└────││││         goto #291 if not %1135
     ││││ @ abstractarray.jl:710 within `checkbounds`
290 ─││││         goto #292
     ││││ @ abstractarray.jl:709 within `checkbounds`
291 ─││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %1120::Tuple{Int64, Int64})::Union{}
└────││││         unreachable
292 ─││││         nothing::Nothing
     │││└
     │││ @ abstractarray.jl:1420 within `_setindex!`
     │││┌ @ abstractarray.jl:1333 within `_to_linear_index`
     ││││┌ @ abstractarray.jl:2933 within `_sub2ind`
     │││││┌ @ abstractarray.jl:98 within `axes`
     ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
     │││││││┌ @ Base.jl:37 within `getproperty`
293 ┄││││││││ %1141 = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    ││││││└└
│    ││││││┌ @ tuple.jl:274 within `map`
│    │││││││┌ @ tuple.jl:29 within `getindex`
│    ││││││││ %1142 = Base.getfield(%1141, 1, true)::Int64
│    │││││││└
│    │││││││┌ @ range.jl:459 within `oneto`
│    ││││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    │││││││││┌ @ promotion.jl:510 within `max`
│    ││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││ %1143 = Base.slt_int(%1142, 0)::Bool
│    ││││││││││└
│    ││││││││││┌ @ essentials.jl:575 within `ifelse`
│    │││││││││││ %1144 = Core.ifelse(%1143, 0, %1142)::Int64
│    │││││└└└└└└
│    │││││ @ abstractarray.jl:2933 within `_sub2ind` @ abstractarray.jl:2949
│    │││││┌ @ abstractarray.jl:2965 within `_sub2ind_recurse`
│    ││││││┌ @ abstractarray.jl:2969 within `nextL`
│    │││││││┌ @ int.jl:88 within `*`
│    ││││││││ %1145 = Base.mul_int(1, %1144)::Int64
│    ││││││└└
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %1146 = Base.sub_int(14, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %1147 = Base.mul_int(%1146, 1)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %1148 = Base.add_int(1, %1147)::Int64
│    ││││││└
│    ││││││ @ abstractarray.jl:2965 within `_sub2ind_recurse` @ abstractarray.jl:2965
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %1149 = Base.sub_int(%1118, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %1150 = Base.mul_int(%1149, %1145)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %1151 = Base.add_int(%1148, %1150)::Int64
│    │││└└└└
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:88 within `#setindex!`
└────││││         goto #298 if not false
     ││││┌ @ abstractarray.jl:707 within `checkbounds`
294 ─│││││ %1153 = Core.tuple(%1151)::Tuple{Int64}
│    │││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│    │││││┌ @ abstractarray.jl:381 within `eachindex`
│    ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:69 within `length`
│    │││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││ %1154 = Base.getfield(encodings, :len)::Int64
│    ││││││└└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %1155 = Base.slt_int(%1154, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %1156 = Core.ifelse(%1155, 0, %1154)::Int64
│    │││││└└└└└
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %1157 = Base.sle_int(1, %1151)::Bool
│    │││││││ %1158 = Base.sle_int(%1151, %1156)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %1159 = Base.and_int(%1157, %1158)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:709 within `checkbounds`
└────│││││         goto #296 if not %1159
     │││││ @ abstractarray.jl:710 within `checkbounds`
295 ─│││││         goto #297
     │││││ @ abstractarray.jl:709 within `checkbounds`
296 ─│││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %1153::Tuple{Int64})::Union{}
└────│││││         unreachable
297 ─│││││         nothing::Nothing
     ││││└
     ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:90 within `#setindex!`
     ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:63 within `pointer`
     │││││┌ @ Base.jl:37 within `getproperty`
298 ┄││││││ %1165 = Base.getfield(encodings, :ptr)::Core.LLVMPtr{Float32, 1}
│    ││││└└
│    ││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:88 within `unsafe_store!`
│    │││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `pointerset`
│    ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
│    │││││││ %1166 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(i8 addrspace(1)* %0, float %1, i64 %2) #0 {\nentry:\n  %3 = bitcast i8 addrspace(1)* %0 to float addrspace(1)*\n  %4 = getelementptr inbounds float, float addrspace(1)* %3, i64 %2\n  store float %1, float addrspace(1)* %4, align 4, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %1167 = Base.sub_int(%1151, 1)::Int64
│    │││││││└
│    │││││││         Base.llvmcall(%1166, Nothing, Tuple{Core.LLVMPtr{Float32, 1}, Float32, Int64}, %1165, %1117, %1167)::Nothing
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
301 ─││ %1172 = Base.sub_float(%384, %385)::Float32
│    │└
│    │┌ @ operators.jl:578 within `*` @ float.jl:410
│    ││ %1173 = Base.mul_float(1.4453057f0, %377)::Float32
│    ││ %1174 = Base.mul_float(%1173, %1172)::Float32
│    │└
│    │┌ @ abstractarray.jl:1397 within `setindex!`
│    ││┌ @ indices.jl:350 within `to_indices` @ indices.jl:355 @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %1175 = Core.zext_int(Core.Int64, %221)::Int64
│    ││└└└└└└
│    ││┌ @ abstractarray.jl:1419 within `_setindex!`
└────│││         goto #306 if not false
     │││┌ @ abstractarray.jl:707 within `checkbounds`
302 ─││││ %1177 = Core.tuple(15, %1175)::Tuple{Int64, Int64}
│    ││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:688
│    ││││┌ @ abstractarray.jl:98 within `axes`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
│    ││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││ %1178 = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    │││││└└
│    │││││┌ @ tuple.jl:274 within `map`
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %1179 = Base.getfield(%1178, 1, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %1180 = Base.slt_int(%1179, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %1181 = Core.ifelse(%1180, 0, %1179)::Int64
│    ││││││└└└└
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %1182 = Base.getfield(%1178, 2, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %1183 = Base.slt_int(%1182, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %1184 = Core.ifelse(%1183, 0, %1182)::Int64
│    ││││└└└└└└
│    ││││┌ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %1185 = Base.sle_int(1, 15)::Bool
│    │││││││ %1186 = Base.sle_int(15, %1181)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %1187 = Base.and_int(%1185, %1186)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices` @ abstractarray.jl:735
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %1188 = Base.sle_int(1, %1175)::Bool
│    │││││││ %1189 = Base.sle_int(%1175, %1184)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %1190 = Base.and_int(%1188, %1189)::Bool
│    │││││└└
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %1191 = Base.and_int(%1190, true)::Bool
│    │││││└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %1192 = Base.and_int(%1187, %1191)::Bool
│    ││││└└
│    ││││ @ abstractarray.jl:709 within `checkbounds`
└────││││         goto #304 if not %1192
     ││││ @ abstractarray.jl:710 within `checkbounds`
303 ─││││         goto #305
     ││││ @ abstractarray.jl:709 within `checkbounds`
304 ─││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %1177::Tuple{Int64, Int64})::Union{}
└────││││         unreachable
305 ─││││         nothing::Nothing
     │││└
     │││ @ abstractarray.jl:1420 within `_setindex!`
     │││┌ @ abstractarray.jl:1333 within `_to_linear_index`
     ││││┌ @ abstractarray.jl:2933 within `_sub2ind`
     │││││┌ @ abstractarray.jl:98 within `axes`
     ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
     │││││││┌ @ Base.jl:37 within `getproperty`
306 ┄││││││││ %1198 = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    ││││││└└
│    ││││││┌ @ tuple.jl:274 within `map`
│    │││││││┌ @ tuple.jl:29 within `getindex`
│    ││││││││ %1199 = Base.getfield(%1198, 1, true)::Int64
│    │││││││└
│    │││││││┌ @ range.jl:459 within `oneto`
│    ││││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    │││││││││┌ @ promotion.jl:510 within `max`
│    ││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││ %1200 = Base.slt_int(%1199, 0)::Bool
│    ││││││││││└
│    ││││││││││┌ @ essentials.jl:575 within `ifelse`
│    │││││││││││ %1201 = Core.ifelse(%1200, 0, %1199)::Int64
│    │││││└└└└└└
│    │││││ @ abstractarray.jl:2933 within `_sub2ind` @ abstractarray.jl:2949
│    │││││┌ @ abstractarray.jl:2965 within `_sub2ind_recurse`
│    ││││││┌ @ abstractarray.jl:2969 within `nextL`
│    │││││││┌ @ int.jl:88 within `*`
│    ││││││││ %1202 = Base.mul_int(1, %1201)::Int64
│    ││││││└└
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %1203 = Base.sub_int(15, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %1204 = Base.mul_int(%1203, 1)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %1205 = Base.add_int(1, %1204)::Int64
│    ││││││└
│    ││││││ @ abstractarray.jl:2965 within `_sub2ind_recurse` @ abstractarray.jl:2965
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %1206 = Base.sub_int(%1175, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %1207 = Base.mul_int(%1206, %1202)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %1208 = Base.add_int(%1205, %1207)::Int64
│    │││└└└└
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:88 within `#setindex!`
└────││││         goto #311 if not false
     ││││┌ @ abstractarray.jl:707 within `checkbounds`
307 ─│││││ %1210 = Core.tuple(%1208)::Tuple{Int64}
│    │││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│    │││││┌ @ abstractarray.jl:381 within `eachindex`
│    ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:69 within `length`
│    │││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││ %1211 = Base.getfield(encodings, :len)::Int64
│    ││││││└└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %1212 = Base.slt_int(%1211, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %1213 = Core.ifelse(%1212, 0, %1211)::Int64
│    │││││└└└└└
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %1214 = Base.sle_int(1, %1208)::Bool
│    │││││││ %1215 = Base.sle_int(%1208, %1213)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %1216 = Base.and_int(%1214, %1215)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:709 within `checkbounds`
└────│││││         goto #309 if not %1216
     │││││ @ abstractarray.jl:710 within `checkbounds`
308 ─│││││         goto #310
     │││││ @ abstractarray.jl:709 within `checkbounds`
309 ─│││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %1210::Tuple{Int64})::Union{}
└────│││││         unreachable
310 ─│││││         nothing::Nothing
     ││││└
     ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:90 within `#setindex!`
     ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:63 within `pointer`
     │││││┌ @ Base.jl:37 within `getproperty`
311 ┄││││││ %1222 = Base.getfield(encodings, :ptr)::Core.LLVMPtr{Float32, 1}
│    ││││└└
│    ││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:88 within `unsafe_store!`
│    │││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `pointerset`
│    ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
│    │││││││ %1223 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(i8 addrspace(1)* %0, float %1, i64 %2) #0 {\nentry:\n  %3 = bitcast i8 addrspace(1)* %0 to float addrspace(1)*\n  %4 = getelementptr inbounds float, float addrspace(1)* %3, i64 %2\n  store float %1, float addrspace(1)* %4, align 4, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %1224 = Base.sub_int(%1208, 1)::Int64
│    │││││││└
│    │││││││         Base.llvmcall(%1223, Nothing, Tuple{Core.LLVMPtr{Float32, 1}, Float32, Int64}, %1222, %1174, %1224)::Nothing
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
314 ─││ %1229 = Base.neg_float(%384)::Float32
│    │└
│    │┌ @ float.jl:410 within `*`
│    ││ %1230 = Base.mul_float(3.0f0, %385)::Float32
│    │└
│    │┌ @ float.jl:408 within `+`
│    ││ %1231 = Base.add_float(%1229, %1230)::Float32
│    │└
│    │┌ @ operators.jl:578 within `*` @ float.jl:410
│    ││ %1232 = Base.mul_float(0.5900436f0, %277)::Float32
│    ││ %1233 = Base.mul_float(%1232, %1231)::Float32
│    │└
│    │┌ @ abstractarray.jl:1397 within `setindex!`
│    ││┌ @ indices.jl:350 within `to_indices` @ indices.jl:355 @ indices.jl:354
│    │││┌ @ indices.jl:359 within `_to_indices1`
│    ││││┌ @ indices.jl:277 within `to_index` @ indices.jl:292
│    │││││┌ @ number.jl:7 within `convert`
│    ││││││┌ @ boot.jl:784 within `Int64`
│    │││││││┌ @ boot.jl:708 within `toInt64`
│    ││││││││ %1234 = Core.zext_int(Core.Int64, %221)::Int64
│    ││└└└└└└
│    ││┌ @ abstractarray.jl:1419 within `_setindex!`
└────│││         goto #319 if not false
     │││┌ @ abstractarray.jl:707 within `checkbounds`
315 ─││││ %1236 = Core.tuple(16, %1234)::Tuple{Int64, Int64}
│    ││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:688
│    ││││┌ @ abstractarray.jl:98 within `axes`
│    │││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
│    ││││││┌ @ Base.jl:37 within `getproperty`
│    │││││││ %1237 = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    │││││└└
│    │││││┌ @ tuple.jl:274 within `map`
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %1238 = Base.getfield(%1237, 1, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %1239 = Base.slt_int(%1238, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %1240 = Core.ifelse(%1239, 0, %1238)::Int64
│    ││││││└└└└
│    ││││││┌ @ tuple.jl:29 within `getindex`
│    │││││││ %1241 = Base.getfield(%1237, 2, true)::Int64
│    ││││││└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %1242 = Base.slt_int(%1241, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %1243 = Core.ifelse(%1242, 0, %1241)::Int64
│    ││││└└└└└└
│    ││││┌ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %1244 = Base.sle_int(1, 16)::Bool
│    │││││││ %1245 = Base.sle_int(16, %1240)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %1246 = Base.and_int(%1244, %1245)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices` @ abstractarray.jl:735
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %1247 = Base.sle_int(1, %1234)::Bool
│    │││││││ %1248 = Base.sle_int(%1234, %1243)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %1249 = Base.and_int(%1247, %1248)::Bool
│    │││││└└
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %1250 = Base.and_int(%1249, true)::Bool
│    │││││└
│    │││││ @ abstractarray.jl:735 within `checkbounds_indices`
│    │││││┌ @ bool.jl:38 within `&`
│    ││││││ %1251 = Base.and_int(%1246, %1250)::Bool
│    ││││└└
│    ││││ @ abstractarray.jl:709 within `checkbounds`
└────││││         goto #317 if not %1251
     ││││ @ abstractarray.jl:710 within `checkbounds`
316 ─││││         goto #318
     ││││ @ abstractarray.jl:709 within `checkbounds`
317 ─││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %1236::Tuple{Int64, Int64})::Union{}
└────││││         unreachable
318 ─││││         nothing::Nothing
     │││└
     │││ @ abstractarray.jl:1420 within `_setindex!`
     │││┌ @ abstractarray.jl:1333 within `_to_linear_index`
     ││││┌ @ abstractarray.jl:2933 within `_sub2ind`
     │││││┌ @ abstractarray.jl:98 within `axes`
     ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:68 within `size`
     │││││││┌ @ Base.jl:37 within `getproperty`
319 ┄││││││││ %1257 = Base.getfield(encodings, :shape)::Tuple{Int64, Int64}
│    ││││││└└
│    ││││││┌ @ tuple.jl:274 within `map`
│    │││││││┌ @ tuple.jl:29 within `getindex`
│    ││││││││ %1258 = Base.getfield(%1257, 1, true)::Int64
│    │││││││└
│    │││││││┌ @ range.jl:459 within `oneto`
│    ││││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    │││││││││┌ @ promotion.jl:510 within `max`
│    ││││││││││┌ @ int.jl:83 within `<`
│    │││││││││││ %1259 = Base.slt_int(%1258, 0)::Bool
│    ││││││││││└
│    ││││││││││┌ @ essentials.jl:575 within `ifelse`
│    │││││││││││ %1260 = Core.ifelse(%1259, 0, %1258)::Int64
│    │││││└└└└└└
│    │││││ @ abstractarray.jl:2933 within `_sub2ind` @ abstractarray.jl:2949
│    │││││┌ @ abstractarray.jl:2965 within `_sub2ind_recurse`
│    ││││││┌ @ abstractarray.jl:2969 within `nextL`
│    │││││││┌ @ int.jl:88 within `*`
│    ││││││││ %1261 = Base.mul_int(1, %1260)::Int64
│    ││││││└└
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %1262 = Base.sub_int(16, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %1263 = Base.mul_int(%1262, 1)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %1264 = Base.add_int(1, %1263)::Int64
│    ││││││└
│    ││││││ @ abstractarray.jl:2965 within `_sub2ind_recurse` @ abstractarray.jl:2965
│    ││││││┌ @ abstractarray.jl:2972 within `offsetin`
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %1265 = Base.sub_int(%1234, 1)::Int64
│    ││││││└└
│    ││││││┌ @ int.jl:88 within `*`
│    │││││││ %1266 = Base.mul_int(%1265, %1261)::Int64
│    ││││││└
│    ││││││┌ @ int.jl:87 within `+`
│    │││││││ %1267 = Base.add_int(%1264, %1266)::Int64
│    │││└└└└
│    │││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:88 within `#setindex!`
└────││││         goto #324 if not false
     ││││┌ @ abstractarray.jl:707 within `checkbounds`
320 ─│││││ %1269 = Core.tuple(%1267)::Tuple{Int64}
│    │││││ @ abstractarray.jl:709 within `checkbounds` @ abstractarray.jl:694
│    │││││┌ @ abstractarray.jl:381 within `eachindex`
│    ││││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:69 within `length`
│    │││││││┌ @ Base.jl:37 within `getproperty`
│    ││││││││ %1270 = Base.getfield(encodings, :len)::Int64
│    ││││││└└
│    ││││││┌ @ range.jl:459 within `oneto`
│    │││││││┌ @ range.jl:457 within `OneTo` @ range.jl:444
│    ││││││││┌ @ promotion.jl:510 within `max`
│    │││││││││┌ @ int.jl:83 within `<`
│    ││││││││││ %1271 = Base.slt_int(%1270, 0)::Bool
│    │││││││││└
│    │││││││││┌ @ essentials.jl:575 within `ifelse`
│    ││││││││││ %1272 = Core.ifelse(%1271, 0, %1270)::Int64
│    │││││└└└└└
│    │││││┌ @ abstractarray.jl:768 within `checkindex`
│    ││││││┌ @ int.jl:488 within `<=`
│    │││││││ %1273 = Base.sle_int(1, %1267)::Bool
│    │││││││ %1274 = Base.sle_int(%1267, %1272)::Bool
│    ││││││└
│    ││││││┌ @ bool.jl:38 within `&`
│    │││││││ %1275 = Base.and_int(%1273, %1274)::Bool
│    │││││└└
│    │││││ @ abstractarray.jl:709 within `checkbounds`
└────│││││         goto #322 if not %1275
     │││││ @ abstractarray.jl:710 within `checkbounds`
321 ─│││││         goto #323
     │││││ @ abstractarray.jl:709 within `checkbounds`
322 ─│││││         invoke Base.throw_boundserror(encodings::AMDGPU.Device.ROCDeviceMatrix{Float32, 1}, %1269::Tuple{Int64})::Union{}
└────│││││         unreachable
323 ─│││││         nothing::Nothing
     ││││└
     ││││ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:90 within `#setindex!`
     ││││┌ @ /home/pxl-th/.julia/packages/AMDGPU/Dl7nN/src/device/gcn/array.jl:63 within `pointer`
     │││││┌ @ Base.jl:37 within `getproperty`
324 ┄││││││ %1281 = Base.getfield(encodings, :ptr)::Core.LLVMPtr{Float32, 1}
│    ││││└└
│    ││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:88 within `unsafe_store!`
│    │││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `pointerset`
│    ││││││┌ @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/pointer.jl:46 within `macro expansion` @ /home/pxl-th/.julia/packages/LLVM/Od0DH/src/interop/base.jl:39
│    │││││││ %1282 = Core.tuple("; ModuleID = 'llvmcall'\nsource_filename = \"llvmcall\"\n\n; Function Attrs: alwaysinline\ndefine void @entry(i8 addrspace(1)* %0, float %1, i64 %2) #0 {\nentry:\n  %3 = bitcast i8 addrspace(1)* %0 to float addrspace(1)*\n  %4 = getelementptr inbounds float, float addrspace(1)* %3, i64 %2\n  store float %1, float addrspace(1)* %4, align 4, !tbaa !0\n  ret void\n}\n\nattributes #0 = { alwaysinline }\n\n!0 = !{!1, !1, i64 0, i64 0}\n!1 = !{!\"custom_tbaa_addrspace(1)\", !2, i64 0}\n!2 = !{!\"custom_tbaa\"}\n", "entry")::Tuple{String, String}
│    │││││││┌ @ int.jl:86 within `-`
│    ││││││││ %1283 = Base.sub_int(%1267, 1)::Int64
│    │││││││└
│    │││││││         Base.llvmcall(%1282, Nothing, Tuple{Core.LLVMPtr{Float32, 1}, Float32, Int64}, %1281, %1233, %1283)::Nothing
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
