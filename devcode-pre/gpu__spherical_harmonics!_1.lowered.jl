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
│   %22  = Base.getindex(directions@_18, 1, i)
│   %23  = Base.getindex(directions@_18, 2, i)
│   %24  = Base.getindex(directions@_18, 3, i)
│   %25  = Core.tuple(%22, %23, %24)
│   %26  = Base.indexed_iterate(%25, 1)
│          x = Core.getfield(%26, 1)
│          @_6 = Core.getfield(%26, 2)
│   %29  = Base.indexed_iterate(%25, 2, @_6)
│          y = Core.getfield(%29, 1)
│          @_6 = Core.getfield(%29, 2)
│   %32  = Base.indexed_iterate(%25, 3, @_6)
│          z = Core.getfield(%32, 1)
│          val@_7 = %25
│          nothing
│          val@_7
│   %37  = x * y
│   %38  = x * z
│   %39  = y * z
│          xy = %37
│          xz = %38
│          yz = %39
│   %43  = Nerf.:^
│   %44  = x
│   %45  = Core.apply_type(Base.Val, 2)
│   %46  = (%45)()
│   %47  = Base.literal_pow(%43, %44, %46)
│   %48  = Nerf.:^
│   %49  = y
│   %50  = Core.apply_type(Base.Val, 2)
│   %51  = (%50)()
│   %52  = Base.literal_pow(%48, %49, %51)
│   %53  = Nerf.:^
│   %54  = z
│   %55  = Core.apply_type(Base.Val, 2)
│   %56  = (%55)()
│   %57  = Base.literal_pow(%53, %54, %56)
│          x² = %47
│          y² = %52
│          z² = %57
│          nothing
│          Base.setindex!(encodings, 0.2820948f0, 1, i)
│   %63  = -0.48860252f0 * y
│          Base.setindex!(encodings, %63, 2, i)
│   %65  = 0.48860252f0 * z
│          Base.setindex!(encodings, %65, 3, i)
│   %67  = -0.48860252f0 * x
│          Base.setindex!(encodings, %67, 4, i)
│   %69  = 1.0925485f0 * xy
│          Base.setindex!(encodings, %69, 5, i)
│   %71  = -1.0925485f0 * yz
│          Base.setindex!(encodings, %71, 6, i)
│   %73  = 0.9461747f0 * z²
│   %74  = %73 - 0.31539157f0
│          Base.setindex!(encodings, %74, 7, i)
│   %76  = -1.0925485f0 * xz
│          Base.setindex!(encodings, %76, 8, i)
│   %78  = 0.54627424f0 * x²
│   %79  = 0.54627424f0 * y²
│   %80  = %78 - %79
│          Base.setindex!(encodings, %80, 9, i)
│   %82  = y
│   %83  = -3.0f0 * x²
│   %84  = %83 + y²
│   %85  = 0.5900436f0 * %82 * %84
│          Base.setindex!(encodings, %85, 10, i)
│   %87  = 2.8906114f0 * xy * z
│          Base.setindex!(encodings, %87, 11, i)
│   %89  = y
│   %90  = 5.0f0 * z²
│   %91  = 1.0f0 - %90
│   %92  = 0.4570458f0 * %89 * %91
│          Base.setindex!(encodings, %92, 12, i)
│   %94  = z
│   %95  = 5.0f0 * z²
│   %96  = %95 - 3.0f0
│   %97  = 0.37317634f0 * %94 * %96
│          Base.setindex!(encodings, %97, 13, i)
│   %99  = x
│   %100 = 5.0f0 * z²
│   %101 = 1.0f0 - %100
│   %102 = 0.4570458f0 * %99 * %101
│          Base.setindex!(encodings, %102, 14, i)
│   %104 = z
│   %105 = x² - y²
│   %106 = 1.4453057f0 * %104 * %105
│          Base.setindex!(encodings, %106, 15, i)
│   %108 = x
│   %109 = -x²
│   %110 = 3.0f0 * y²
│   %111 = %109 + %110
│   %112 = 0.5900436f0 * %108 * %111
│          Base.setindex!(encodings, %112, 16, i)
│          val@_5 = %112
│          nothing
└──        val@_5
3 ┄        return Nerf.nothing
)
