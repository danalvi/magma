function BinarySieve(B)
	bin := [];
	seq := [2,3,5,7] cat [x : x in [11 .. B] | (x mod 10 eq 1) or (x mod 10 eq 3) or (x mod 10 eq 7) or (x mod 10 eq 9) ];
	for i := 1 to #seq do
		bin := [1] cat bin;
	end for;
	for i := 1 to #seq do
		multiples := [x : x in seq | x mod seq[i] eq 0 and (not x eq seq[i])];
		indices := [x : x in [1 .. #seq] | seq[x] in multiples];
		for j in indices do
			bin[j] := 0;
		end for;
	end for;
	return bin, seq;
end function;

// For Question (ii), I am going to use the fact that the nth prime is bounded below n * ln( n ln (n) ) and then use the BinarySieve

function NthPrime(n)
	p_n := Round(n * Log(n * Log(n)) + 1);
	bin, seq := BinarySieve(p_n);
	sum := 0; ret := 0;
	for i := 1 to #seq do
		sum +:=  bin[i];
		if sum eq n then
			ret := seq[i];
			break;
		end if;
	end for;
	return ret;
end function;
