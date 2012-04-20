
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

MyUnrollCode := (c) -> let( When(IsLoop(c) and c.range >1, c.unroll(),c));

