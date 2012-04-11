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

transposesk := (datatype,
            rows,
            cols,
            unroll_bound) -> let(

   x := var("x", TPtr(datatype)),
   y := var("y", TPtr(datatype)),
   i := var("i", TInt),
   j := var("j", TInt),
   unroll := var("unroll", TInt),

   program(
      chain(
         func(TVoid, "transpose", [x, y],
            decl([i, j],
               chain(
                  loop(i, rows,
                     loop(j, cols/unroll_bound,
                        loop(unroll, unroll_bound,
                           chain(
                              assign(nth(y, add(mul(j, cols), add(i, unroll))),
                                 nth(x, add(mul(i, rows), add(j, unroll))))
                           )
                        ).unroll()
                     )
                  )
               )
            )
         )
   )
));


transpose_int := transposesk(TInt, 10, 10, 2);