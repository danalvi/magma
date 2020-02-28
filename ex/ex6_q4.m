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
