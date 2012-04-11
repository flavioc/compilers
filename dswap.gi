Class(TVarArray, TArray);
Class(nthVar, nth);

getVarArrayNames := function(nm, size, datatype)
   local ll, i;
   ll := [];
   for i in [0 .. size - 1] do
      ll := Concatenation(ll, [var(Concatenation(nm, "_", String(i)), datatype)]);
   od;
   return ll;
end;

myopts := Copy(SpiralDefaults);
myopts.unparser.nthVar := (self,o,i,is) >> Print(self(o.loc,i,is), "_", self(o.idx,i,is));

swapsk := (datatype,
            loop_bound,
            unroll_bound) -> let(

   x := var("x", TPtr(datatype)),
   y := var("y", TPtr(datatype)),
   it := var("i", TInt),
   it2 := var("ii", TInt),
   actuali := var("act", TArray(TInt, loop_bound)),
   temp := var("temp", TArray(datatype, loop_bound)),

   program(
      chain(
         func(TVoid, "swap", [x, y],
            decl(Concatenation([it],
                  getVarArrayNames("temp", unroll_bound, datatype),
                  getVarArrayNames("act", unroll_bound, datatype)),
               chain(
                  loop(it, loop_bound/unroll_bound,
                     FlattenCode(loop(it2, unroll_bound,
                        chain(
                           assign(nthVar(actuali, it2), add(it2, mul(it, unroll_bound))),
                           assign(nthVar(temp, it2), nth(x, nthVar(actuali, it2))),
                           assign(nth(x, nthVar(actuali, it2)), nth(y, nthVar(actuali, it2))),
                           assign(nth(y, nthVar(actuali, it2)), nthVar(temp, it2))
                     )).unroll())
                  )
               )
            )
         )
   )
));


swap_int := swapsk(TInt, 10, 2);
swap_double := swapsk(T_Real(64), 100, 20);