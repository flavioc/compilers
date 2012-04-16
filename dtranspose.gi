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
            unroll_bound,
            tilling_rows,
            tilling_cols) -> let(

   x := var("x", TPtr(datatype)),
   y := var("y", TPtr(datatype)),
   i := var("i", TInt),
   j := var("j", TInt),
   unroll := var("unroll", TInt),
   it := var("it", TInt),
   jt := var("jt", TInt),
   scaledit := var("scaledit", TInt),
   scaledjt := var("scaledjt", TInt),

   a := var("a", datatype),
   b := var("b", datatype),
   
   min := func(datatype, "min", [a, b],
      IF(leq(a, b), ret(a), ret(b))),

   program(
      chain(
         min,
         func(TVoid, "transpose", [x, y],
            decl([i, j, it, jt, scaledit, scaledjt],
               chain(
                  loop(it, rows/tilling_rows,
                     chain(
                        assign(scaledit, mul(it, tilling_rows)),
                        loop(jt, cols/tilling_cols,
                           chain(
                              assign(scaledjt, mul(jt, tilling_cols)),
                              loop(i, tilling_rows,
                                 loop(j, tilling_cols/unroll_bound,
                                    loop(unroll, unroll_bound,
                                       chain(
                                          assign(nth(y, add(mul(add(j, scaledjt), rows), add(add(i, scaledit), unroll))),
                                             nth(x, add(mul(add(i, scaledit), cols), add(add(j, scaledjt), unroll))))
                                       )
                                    ).unroll()
                                 )
                              )
                           )
                        )
                     )
                  )
               )
            )
         )
      )
   )
);


transpose_int := transposesk(TInt, 20, 20, 5, 2, 2);
