// 13 i

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

// 13 ii

// I intend to use Bertrand's Postulate as a ground for my search for the next prime
// I also believe that this "process" could be further optimised by keeping the track of the number of prime which was last found, 
// hence, allowing us to use Rosser's Theorem . I will, however, not try to do that, as I understand that the tester Erik might be using
// is very mechanical, and do not want conflicts with it (having a database of stored primes, and then going forward from there).

// The idea is we want to narrow our "search domain" using the available theorems in Number Theory. 
// I would also have been a fan of using probabilistic methods (i.e. any distributions on the prime gaps), but for simplicity, would avoid it 


function MyNextPrime(n)
	// By Betrand's Postulate, we know there exists a prime number p_k s.t. n < p_k < 2*n
	// However, trying to find p_k could be worse case n, which is not a good idea for the tests for 2^256
	// Let us use the prime counting function and the bounds on it. We would then use the lower bound on it, and search until we reach n
end function;


//for i := 10 to 40 do
//	printf "n: %o, Prime: %o\n", i,  MyIsPrime(i, 10000);
//end for;

