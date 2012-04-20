Read("common.gi");

daxpysk := (datatype,
            loop_bound,
            unroll_bound) -> let(

   x := var("x", TPtr(datatype)),
   y := var("y", TPtr(datatype)),
   a := var("a", datatype),
   it := var("i", TInt),
   it2 := var("ii", TInt),
   actuali := var("act", TArray(TInt, loop_bound)),
   temp := var("temp", TArray(datatype, loop_bound)),

   program(
      chain(
         func(TVoid, "daxpy", [x, y, a],
            decl(Concatenation([it],
                  When(unroll_bound > 1, getVarArrayNames("temp", unroll_bound, datatype), []),
                  When(unroll_bound > 1, getVarArrayNames("act", unroll_bound, datatype), [])),
               chain(
                  loop(it, loop_bound/unroll_bound,
                     When(unroll_bound = 1,
                        chain(
                           assign(nth(y, it), add(nth(y, it), mul(a, nth(x, it))))),
                     FlattenCode(loop(it2, unroll_bound,
                        chain(
                           assign(nthVar(actuali, it2), add(it2, mul(it, unroll_bound))),
                           assign(nthVar(temp, it2), mul(a, nth(x, nthVar(actuali, it2)))),
                           assign(nth(y, nthVar(actuali, it2)),   
                                 add(nth(y, nthVar(actuali, it2)),
                                    nthVar(temp, it2)))
                     )).unroll()))
                  )
               )
            )
         )
   )
));


daxpy_int := daxpysk(TInt, 10, 1);
daxpy_double := daxpysk(T_Real(64), 100, 20);
PrintCode("", daxpy_int, SpiralDefaults);
