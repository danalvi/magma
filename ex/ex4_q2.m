function BinarySieve(B)
	bin := [];
	seq := [2,3,5,7] cat [x : x in [11 .. B] | (x mod 10 eq 1) or (x mod 10 eq 3) or (x mod 10 eq 7) or (x mod 10 eq 9) ];
	for i := 1 to #seq do
		bin := [0] cat bin;
	end for;
	for i := 1 to #seq do
		multiples := [x : x in seq | x mod seq[i] eq 0 and (not x eq seq[i])];
		indices := [x : x in [1 .. #seq] | seq[x] in multiples];
		for j in indices do
			bin[j] := 1;
		end for;
	end for;
	return bin, seq;
end function;
