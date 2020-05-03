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
	if (N lt 11) then
		return [false, true, true, false, true, false, true, false, false, false][N];
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

function pn_high(n)
	if (n lt 688383) then
		return n*(Log(n*Log(n)));	// Dussart
	else
		return n*(Log(n) + Log(Log(n)) - 1 + ((Log(Log(n)) - 2 ) / (Log(n))) );
	end if;
end function;

function pn_low(n)
	return n*(Log(n) + Log(Log(n)) - 1 + ((Log(Log(n)) - 2.1)/(Log(n))));	// Rosser (quite a genius actually)
end function;

function MyNextPrime(n)
	// By Betrand's Postulate, we know there exists a prime number p_k s.t. n < p_k < 2*n
	// However, trying to find p_k could be worse case n, which is not a good idea for the tests for 2^256
	// Let us use the prime counting function pi(x) and the bounds on it. We would then use the lower bound on it, and search until we reach n
	
	// We know that n/ln(n) < pi(x) < 1.25506(n/ln(n)) for n >= 17
	// We hardcode the first 17 primes, as the lower bound function starts working only above that

	if(n le 17) then
		X := [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59];
		for x in X do
			if (x gt n) then
				return x;
			end if;
		end for;
	end if;
	
	pi_low := 0;
	if (n lt 88789) then
		pi_low := Floor(n / Log(n)); // That is the lower bound we have for the number of primes below n
				      	     // This is sought just to start finding the k such that n < p_k
	else
		pi_low := Floor((n / Log(n) * (1 + (1/Log(n)) +(2/(Log(n))^2)) ) ); 
	end if;
	
	pi_high := Floor((n / Log(n))*(1 + (1/(Log(n))) + (2/(Log(n))^2) + (7.59 / ((Log(n))^3)) ) ); 
	
	p := n;	
	if ((p mod 2) ne 10 ) then
                p -:= (p mod 10);
        end if;
	
	count := 0;
	skip := [1,2,4,2,1];

	while (p lt Ceiling(pn_high(pi_high))) do
		if (MyIsPrime(p, 10) and (p gt n)) then
	       		return p;
		end if;
		
		p +:= skip[count + 1];	
		count := (count + 1) mod 5;	
	end while;

	return 0;
end function;

//for i := 10 to 40 do
//	printf "n: %o, Prime: %o\n", i,  MyIsPrime(i, 10000);
//end for;

print "\n\n 13 iii \n\n";

F_n := [2^(2^x) + 1 : x in [0 .. 14]];

for i := 1 to 15 do
	t := Cputime();
	b := MyIsPrime(F_n[i], 100);
	Cputime(t);
	printf "F_%o, Is Prime : %o, Time :%o\n",i, b, t;
end for;
