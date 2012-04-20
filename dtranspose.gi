
Read("common.gi");

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
	temp1 := var("temp1", TArray(TInt, unroll_bound)),
	temp2 := var("temp2", TArray(TInt, unroll_bound)),
	temp3 := var("temp3", TArray(TInt, unroll_bound)),

   a := var("a", datatype),
   b := var("b", datatype),
   
   min := func(datatype, "min", [a, b],
      IF(leq(a, b), ret(a), ret(b))),

   program(
      chain(
         min,
         func(TVoid, "transpose", [x, y],
            decl(Concatenation([i, j, it, jt, scaledit, scaledjt],
							getVarArrayNames("temp1", unroll_bound, TInt),
							getVarArrayNames("temp2", unroll_bound, TInt),
							getVarArrayNames("temp3", unroll_bound, TInt)),
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
														assign(nthVar(temp1, unroll), add(i, scaledit)),
														assign(nthVar(temp2, unroll), nthVar(temp1, unroll)),
														assign(nthVar(temp1, unroll), add(nthVar(temp1, unroll), unroll)),
														assign(nthVar(temp2, unroll), mul(nthVar(temp2, unroll), cols)),
														assign(nthVar(temp2, unroll), add(nthVar(temp2, unroll), j)),
														assign(nthVar(temp2, unroll), add(nthVar(temp2, unroll), scaledjt)),
														assign(nthVar(temp2, unroll), add(nthVar(temp2, unroll), unroll)),
														assign(nthVar(temp3, unroll), add(j, scaledjt)),
														assign(nthVar(temp3, unroll), mul(nthVar(temp3, unroll), rows)),
														assign(nthVar(temp1, unroll), add(nthVar(temp1, unroll), nthVar(temp3, unroll))),
														assign(nth(y, nthVar(temp1, unroll)), nth(x, nthVar(temp2, unroll)))
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
      )
   )
);

transpose_int := transposesk(TInt, 2, 3, 1, 1, 1);
