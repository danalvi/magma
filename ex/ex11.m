function MyMersenne(p)
	s := 4;
	M := 2^(p) - 1;
       	for i := 1 to (p - 2) do
		s := ((s ^ 2) - 2) mod M;
	end for;
	if (s eq 0) then
		return true;
	else
		return false;
	end if;
end function;

// It is important we use some sort of a "dynamic Sieving mechanism" which ensures that our values are stored when we want to find the next Mersenne Prime
// Using the theorem that if a Mersenne Number 2^p - 1 is prime, then p must be prime, so searching for prime numbers will optimise the search process

load 'ex4_q2.m';

function MersennePrimes(n)
	bin := []; // As same from the Binary Sieve
	seq := [2,3,5,7];; // Start with some initial numbers, first four, where i is the counter of the number of first n primes found
	M := [ (2^x - 1) : x in seq]; // Mersenne Primes to be sought
	count := 5;;
	while (#M ne n) do
		p := NthPrime(count); 
		if (MyMersenne(p)) then
			M := M cat [(2^p - 1)];
		end if;
		count +:= 1;
	end while;	
	return M;
end function;
