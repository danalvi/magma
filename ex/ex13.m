function factrd(n)
	r := 0;
	n := n - 1;
	while ((n  mod 2) eq 0) do
		n := IntegerRing() ! (n / 2);
		r +:= 1;
	end while;
	return r, n;
end function;

function MyIsPrime(N, k)
	if (N le 6) then
		return [false, false, true, true, false, true][N];
	elif ((N mod 2) eq 0) then
       		return false;	
	end if;	
	s, d := factrd(N);
	for i := 1 to k do	
		a := Random(2, N - 2);
		x := Modexp(a, d, N);
		if ( ((x eq 1) or (x eq (N - 1) ) )) then
			continue;
		end if;
		r := 0;
		while (r lt s) do
			x := Modexp(x, 2, N);
			if (x eq N) then
				return false;
			end if;
			if (x eq (N - 1)) then
				break;
			end if;
			r +:= 1;
		end while;
		if (r eq s) then
			return false;
		end if;
	end for;
	return true;
end function;

for i := 10 to 40 do
	printf "n: %o, Prime: %o\n", i,  MyIsPrime(i, 10000);
end for;

