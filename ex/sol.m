IntegerToBinary := function(n)
	seq := [];
	while n gt 0 do
		b := n mod 2;
		n := n div 2;
		seq := seq cat [b];
	end while;
	return seq;
end function;

procedure IntegerToBinaryTest()
	for i in [0 .. 32] do
		if not IntegerToSequence(i, 2) eq IntegerToBinary(i) then
			print(i);
		end if;
	end for;
end procedure;

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

function MyNthPrime(n)
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
