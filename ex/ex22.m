function PolyFastExp(a,m,n)
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

function PolyFactor(p)
	q := Characteristic(Parent(Name(Parent(p),1)));
	h := [Name(Parent(p),1)]; f := [p]; g := []; i := 1;
	while ((f[i] ne 1) ) do
		i +:= 1;
		h[i] := PolyFastExp(h[i - 1], q, p);
		g[i] := Gcd(h[i] - Name(Parent(p),1), f[i - 1]); f[i] := f[i - 1] / g[i];	
		if ( Degree(f[i]) lt 2 * (i + 1) ) then
			break;
		end if;
		//print h[i]; print g[i]; print f[i]; print p;
		//printf "\n";
	end while;
	s := i;
	return [g[x] : x in [2 .. s]];
end function;


function Berlekamp(p)
	q := Characteristic(Parent(Name(Parent(p),1)));
	if ( ( (q mod 2) ne 1) or (not IsPrime(q) ) ) then
		return 0;
	end if;
       		
	x := PolyFastExp((Name(Parent(p),1)),q,p);
	n :=  Degree(p); Q := ZeroMatrix(BaseRing(Parent(Name(Parent(p),1))), n, n);
	for i := 1 to n do
		for j := 1 to n do
      			Q[i, j] := Coefficient(x^i, j); 
		end for;
	end for;
	//print Q;
	reduced_Q := EchelonForm(Q - IdentityMatrix(Rationals(),n)); r := Rank(reduced_Q);
       	
	if (r eq 1) then
		return p;
	end if;

	a_vector := Vector(BaseRing(Parent(Name(Parent(p),1))), [0 : x in [1 ..n]]); // Initialise the vector
	for i := 1 to r do
		a_vector +:= Random(BaseRing(Parent(Name(Parent(p),1)))) * reduced_Q[i];
	end for;

	a := 0;

	for i := 1 to n do
	   a +:= (a_vector[i] * (Name(Parent(p),1))^(i-1)); 
	end for;
		
	g_1 := Gcd(a, p);
	if ( (g_1 ne 1) and (g_1 ne p) ) then
		return g_1;
	end if;
	b := PolyFastExp(a, Integers() ! ( (q - 1) / 2 ), p);
	g_2 := Gcd(b - 1, p);
	if ( (g_2 ne 1) and (g_2 ne p) ) then
		return g_2;
	else 
		return 0; // Failure
	end if;
end function;

P<x> := PolynomialRing(GF(3));
//f := x^8 + x^7 - x^6 + x^5 - x^3 - x^2 - x;
f := x^4 + x^3 + x + 2;
//PolyFactor(f);
Berlekamp(f);
