load 'ex13.m';

function MyPollardRho(n,k,c)
	if ((n mod 2) eq 0) then
		return 2;
	end if;
	if(not MyIsPrime(n, 50)) then
		X := [];
		Append(~X, Random(2, n - 1));
		for i := 1 to k do 
			Append(~X, ((X[i]^2) + c) mod n);
			for j := 1 to i do
				d := Gcd(X[i + 1] - X[j], n);
				if( (d gt 1) and (d lt n )) then
					return d;
				end if;
			end for;
		end for;
		return 1; // When it returns from here, it is different when it returns from after the outermost if
	end if;
	return 1; // Here it means the number was simply not compositr
end function;

// Test function

for i := 10 to 100 do
	x := MyPollardRho(i, 1000, 1);
	if (x eq 1) then
       		printf "n: %o, Divisor Found: NONE!\n", i;
	else 
		printf "n: %o, Divisor      : %o   \n", i, x;
	end if;
end for;
