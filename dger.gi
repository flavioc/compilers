
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

   min := func(datatype, "min", [a, b],
      IF(leq(a, b), ret(a), ret(b))),

   program(
      chain(
         min,
         func(TVoid, "ger", [a, x, y, alpha],
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
                                       assign(nth(a, add(mul(add(i, scaledit), cols),
																			add(add(j, scaledjt), unroll))),
															add(nth(a, add(mul(add(i, scaledit), cols),
																		add(add(j, scaledjt), unroll))),
																mul(alpha, mul(nth(x, add(i, scaledit)), nth(y, add(j, scaledjt))))))
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
