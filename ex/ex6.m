function IntegerEuclidean(a, b)
	if a lt b then
		t := a;
		a := b;
		b := t;
	end if;
	while not b eq 0 do
		q, r := Quotrem(a, b);
		a := b;
		b := r;
	end while;
	return Abs(a);
end function;

function IntegerExtendedEuclidean(a, b)
	s := [0, 1];
	t := [1, 0];
	r := [Abs(b), Abs(a)];
	while not r[1] eq 0 do
		quotient, remainder := Quotrem(r[2], r[1]);
		r := [r[2] - quotient * r[1], r[1]];
		s := [s[2] - quotient * s[1], s[1]];
		t := [t[2] - quotient * t[1], t[1]];
	end while;
	return r[2], s[2], t[2];	
	//return [s[2], t[2]], r[2], [t[1], s[1]];
end function;

function PolyEuclidean(f, g)
        if Degree(f) lt Degree(g) then
                t := f;
                f := g;
                g := t;
        end if;
        while not g eq 0 do
                q, r := Quotrem(f, g);
                f := g;
                g := r;
        end while;
        coefficients := Coefficients(f);
        return f / coefficients[#coefficients];
end function;

SimpleGCD := function(a, b)
        f := Factorization(a);
        g := Factorization(b);
        F := AssociativeArray();
        G := AssociativeArray();
        for i in [1 .. #f] do
                F[f[i][1]] := f[i][2];
        end for;
        for i in [1 .. #g] do
                G[g[i][1]] := g[i][2];
        end for;
        gcd := Factorization(1); // Sorry, really couldn't find how to cast [] to RngIntEltFact
        for i in [1 .. #f] do
                b, val := IsDefined(G,f[i][1]);
                if b then
                        min := Minimum(F[f[i][1]], val);
                        Append(~gcd, <f[i][1], min>);
                end if;
        end for;
        return FactorizationToInteger(gcd);
end function;

function SpeedTestGCD(k)
	a := SequenceToInteger([Random(0, 9): i in [1 .. k]]);
	b := SequenceToInteger([Random(0, 9): i in [1 .. k]]);	
	t_1 := Cputime();
	x := IntegerEuclidean(a, b);
	Cputime(t_1);
	t_2 := Cputime();
	y := SimpleGCD(a, b);
	Cputime(t_2);
	t_3 := Cputime();
	z := Gcd(a, b);
	Cputime(t_3);
	return t_1, t_2, t_3;
end function;
