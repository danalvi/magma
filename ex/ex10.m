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

function MyJacobiSymbol(a,m)
	assert (m ge 0 and m mod 2 eq 1);
	a := a mod m;
     	t := 1;	
	while not a eq 0 do 
		while (a mod 2 eq 0) do
			a := IntegerRing() ! (a / 2);
			r := m mod 8;
			if (r eq 3 or r eq 5) then
				t := -t;
			end if;
		end while;
		temp := a; a := m; m := temp; // UGH, I hate using temporary variables, but seems the only way out.
		if ((a mod 4 eq 3) and (m mod 4 eq 3)) then
			t := -t;
		end if;
		a := a mod m;
	end while;
	if m eq 1 then
		return t;
	else
		return 0;
	end if;
end function;

function SolovayStrassenTest(n,k)
	for i := 1 to k do
		a := Random(2, n - 1);
		x := MyJacobiSymbol(a, n);
		m := FastExp(a,IntegerRing() ! ((n - 1) / 2), n);
		if ((x eq 0) or (((m - x) mod n) ne 0)) then
			return a;
		end if;		
	end for;
	return true;
end function;
