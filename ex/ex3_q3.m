function FastExp(a,m,n)
	seq := IntegerToSequence(m, 2);
	b := [a mod n];
	for i := (#seq - 1) to 1 by -1 do
		if seq[i] eq 1 then
			b := [ (b[1]^2 * a) mod n] cat b;
		else
			b := [ (b[1]^2) mod n ] cat b;
		end if;
	end for;
	return b[1];
end function;
