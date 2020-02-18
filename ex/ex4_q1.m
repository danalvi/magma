function PrimeSieve(B)
	seq := [2 .. B];
	primes := [];
	while not IsEmpty(seq) do
		n := seq[1];
		primes :=  primes cat [n];
		multiples := [x : x in seq | x mod n eq 0];
		seq := [x : x in seq | x notin multiples];
	end while;
	return primes;
end function;
