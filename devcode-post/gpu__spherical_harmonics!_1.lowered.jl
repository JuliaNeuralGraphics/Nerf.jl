CodeInfo(
1 ─ %1   = (KernelAbstractions.constify)(directions@_4)
│          Core.NewvarNode(:(val@_5))
│          Core.NewvarNode(:(@_6))
│          Core.NewvarNode(:(val@_7))
│          Core.NewvarNode(:(z²))
│          Core.NewvarNode(:(y²))
│          Core.NewvarNode(:(x²))
│          Core.NewvarNode(:(yz))
│          Core.NewvarNode(:(xz))
│          Core.NewvarNode(:(xy))
│          Core.NewvarNode(:(z))
│          Core.NewvarNode(:(y))
│          Core.NewvarNode(:(x))
│          Core.NewvarNode(:(i))
│          directions@_18 = %1
│   %16  = (KernelAbstractions.__validindex)(__ctx__)
└──        goto #3 if not %16
2 ─ %18  = KernelAbstractions.__index_Global_Linear(__ctx__)
│   %19  = Base.convert(Nerf.UInt32, %18)
│          i = Core.typeassert(%19, Nerf.UInt32)
│          nothing
│   %22  = directions@_18
│   %23  = 1 * Nerf.u32
│   %24  = Base.getindex(%22, %23, i)
│   %25  = directions@_18
│   %26  = 2 * Nerf.u32
│   %27  = Base.getindex(%25, %26, i)
│   %28  = directions@_18
│   %29  = 3 * Nerf.u32
│   %30  = Base.getindex(%28, %29, i)
│   %31  = Core.tuple(%24, %27, %30)
│   %32  = Base.indexed_iterate(%31, 1)
│          x = Core.getfield(%32, 1)
│          @_6 = Core.getfield(%32, 2)
│   %35  = Base.indexed_iterate(%31, 2, @_6)
│          y = Core.getfield(%35, 1)
│          @_6 = Core.getfield(%35, 2)
│   %38  = Base.indexed_iterate(%31, 3, @_6)
│          z = Core.getfield(%38, 1)
│          val@_7 = %31
│          nothing
│          val@_7
│   %43  = x * y
│   %44  = x * z
│   %45  = y * z
│          xy = %43
│          xz = %44
│          yz = %45
│   %49  = Nerf.:^
│   %50  = x
│   %51  = Core.apply_type(Base.Val, 2)
│   %52  = (%51)()
│   %53  = Base.literal_pow(%49, %50, %52)
│   %54  = Nerf.:^
│   %55  = y
│   %56  = Core.apply_type(Base.Val, 2)
│   %57  = (%56)()
│   %58  = Base.literal_pow(%54, %55, %57)
│   %59  = Nerf.:^
│   %60  = z
│   %61  = Core.apply_type(Base.Val, 2)
│   %62  = (%61)()
│   %63  = Base.literal_pow(%59, %60, %62)
│          x² = %53
│          y² = %58
│          z² = %63
│          nothing
│   %68  = 1 * Nerf.u32
│          Base.setindex!(encodings, 0.2820948f0, %68, i)
│   %70  = -0.48860252f0 * y
│   %71  = 2 * Nerf.u32
│          Base.setindex!(encodings, %70, %71, i)
│   %73  = 0.48860252f0 * z
│   %74  = 3 * Nerf.u32
│          Base.setindex!(encodings, %73, %74, i)
│   %76  = -0.48860252f0 * x
│   %77  = 4 * Nerf.u32
│          Base.setindex!(encodings, %76, %77, i)
│   %79  = 1.0925485f0 * xy
│   %80  = 5 * Nerf.u32
│          Base.setindex!(encodings, %79, %80, i)
│   %82  = -1.0925485f0 * yz
│   %83  = 6 * Nerf.u32
│          Base.setindex!(encodings, %82, %83, i)
│   %85  = 0.9461747f0 * z²
│   %86  = %85 - 0.31539157f0
│   %87  = 7 * Nerf.u32
│          Base.setindex!(encodings, %86, %87, i)
│   %89  = -1.0925485f0 * xz
│   %90  = 8 * Nerf.u32
│          Base.setindex!(encodings, %89, %90, i)
│   %92  = 0.54627424f0 * x²
│   %93  = 0.54627424f0 * y²
│   %94  = %92 - %93
│   %95  = 9 * Nerf.u32
│          Base.setindex!(encodings, %94, %95, i)
│   %97  = y
│   %98  = -3.0f0 * x²
│   %99  = %98 + y²
│   %100 = 0.5900436f0 * %97 * %99
│   %101 = 10 * Nerf.u32
│          Base.setindex!(encodings, %100, %101, i)
│   %103 = 2.8906114f0 * xy * z
│   %104 = 11 * Nerf.u32
│          Base.setindex!(encodings, %103, %104, i)
│   %106 = y
│   %107 = 5.0f0 * z²
│   %108 = 1.0f0 - %107
│   %109 = 0.4570458f0 * %106 * %108
│   %110 = 12 * Nerf.u32
│          Base.setindex!(encodings, %109, %110, i)
│   %112 = z
│   %113 = 5.0f0 * z²
│   %114 = %113 - 3.0f0
│   %115 = 0.37317634f0 * %112 * %114
│   %116 = 13 * Nerf.u32
│          Base.setindex!(encodings, %115, %116, i)
│   %118 = x
│   %119 = 5.0f0 * z²
│   %120 = 1.0f0 - %119
│   %121 = 0.4570458f0 * %118 * %120
│   %122 = 14 * Nerf.u32
│          Base.setindex!(encodings, %121, %122, i)
│   %124 = z
│   %125 = x² - y²
│   %126 = 1.4453057f0 * %124 * %125
│   %127 = 15 * Nerf.u32
│          Base.setindex!(encodings, %126, %127, i)
│   %129 = x
│   %130 = -x²
│   %131 = 3.0f0 * y²
│   %132 = %130 + %131
│   %133 = 0.5900436f0 * %129 * %132
│   %134 = 16 * Nerf.u32
│          Base.setindex!(encodings, %133, %134, i)
│          val@_5 = %133
│          nothing
└──        val@_5
3 ┄        return Nerf.nothing
)
