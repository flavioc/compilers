
Read("common.gi");

gersk := (datatype,
            rows,
            cols,
            unroll_bound,
            tilling_rows,
            tilling_cols) -> let(

	a := var("a", TPtr(datatype)),
   x := var("x", TPtr(datatype)),
   y := var("y", TPtr(datatype)),
	alpha := var("alpha", datatype),
   i := var("i", TInt),
   j := var("j", TInt),
   unroll := var("unroll", TInt),
   it := var("it", TInt),
   jt := var("jt", TInt),
   scaledit := var("scaledit", TInt),
   scaledjt := var("scaledjt", TInt),
   b := var("b", datatype),
	temp1 := var("temp1", TArray(TInt, unroll_bound)),
	temp2 := var("temp2", TArray(TInt, unroll_bound)),
	temp3 := var("temp3", TArray(TInt, unroll_bound)),
	temp4 := var("temp4", TArray(datatype, unroll_bound)),

   min := func(datatype, "min", [a, b],
      IF(leq(a, b), ret(a), ret(b))),

   program(
      chain(
         min,
         func(TVoid, "ger", [a, x, y, alpha],
            decl(Concatenation([i, j, it, jt, scaledit, scaledjt],
						getVarArrayNames("temp1", unroll_bound, TInt),
						getVarArrayNames("temp2", unroll_bound, TInt),
						getVarArrayNames("temp3", unroll_bound, TInt),
						getVarArrayNames("temp4", unroll_bound, datatype)),
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
														assign(nthVar(temp3, unroll), add(j, scaledjt)),
														assign(nthVar(temp4, unroll), mul(nth(x, nthVar(temp2, unroll)), nth(y, nthVar(temp3, unroll)))),
														assign(nthVar(temp4, unroll), mul(alpha, nthVar(temp4, unroll))),
														assign(nthVar(temp1, unroll), mul(nthVar(temp1, unroll), cols)),
														assign(nthVar(temp1, unroll), add(nthVar(temp1, unroll), j)),
														assign(nthVar(temp1, unroll), add(nthVar(temp1, unroll), scaledjt)),
														assign(nthVar(temp1, unroll), add(nthVar(temp1, unroll), unroll)),
                                       	assign(nth(a, nthVar(temp1, unroll)),
															add(nth(a, nthVar(temp1, unroll)), nthVar(temp4, unroll)))
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


ger_int := gersk(TInt, 3, 2, 2, 1, 2);
