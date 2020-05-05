function GSO(F)
	n := #F;	// F is a sequence, not a vector! Though a sequence of vectors, nonetheless ...
	F_star := [ChangeRing(F[1], Rationals()) ];	// Sequence of f*s (yikes, this sounds like profanity!)
	M := DiagonalMatrix(Rationals(), [1 : x in [1 .. n]]);
	for i := 2 to n do
		f_star := ChangeRing(F[i], Rationals());
		for j := 1 to (i - 1) do
			mu_ij := Rationals() ! ( Rationals() !(InnerProduct(F[i], F_star[j])) / ( Rationals() ! InnerProduct(F_star[j], F_star[j])) ) ;
			M[i,j] :=  mu_ij;
			f_star -:= mu_ij * F_star[j];
		end for;
		Append(~F_star, ChangeRing(f_star, Rationals()));
	end for;
	return F_star, M;
end function;

function MatrixToVectorSequence(M)
	r := NumberOfRows(M);
	V := [];
	for i := 1 to r do
		Append(~V, Vector(Rationals(), M[i]));
	end for;
	return V;
end function;

function MyIndependentLLL(G)
	n := #G;
	G_star, M := GSO(G); M := Matrix(M); G_star := Matrix(G_star); G := Matrix(G);
	i := 2;
	while (i le n) do
		for j := i - 1 to 1 by -1 do
			G[i] := G[i] - Floor(M[i,j] + (1 / 2)) * G[j];
		end for;
		G_star, M := GSO(MatrixToVectorSequence(G)); // Update
		if ( ( i gt 1 ) and (InnerProduct(G_star[i - 1], G_star[i - 1]) gt 2 * InnerProduct(G_star[i], G_star[i]) ) )  then
				SwapRows(~G, i, i - 1);
				i -:= 1;
			else
				i +:= 1;
		end if;
		// print(G); print(M); print(G_star); printf "\n";
	end while;
	
	return [Vector(Rationals(), G[i]) : i in [1 .. n]];
end function;

function MyLLL(G)
	rank := Rank(Matrix(G)); G := G[1 .. rank]; // Obtain only linearly dependent rows 
	G_star, M := GSO(G); M := Matrix(M); G_star := Matrix(G_star);	G := Matrix(G);
	
        i := 2;
        while (i le NumberOfRows(G)) do
                for j := i - 1 to 1 by -1 do
                        G[i] := G[i] - Floor(M[i,j] + (1 / 2)) * G[j];
                end for;
                G_star, M := GSO(MatrixToVectorSequence(G)); // Update
                if ( ( i gt 1 ) and (InnerProduct(G_star[i - 1], G_star[i - 1]) gt 2 * InnerProduct(G_star[i], G_star[i]) ) )  then
                                SwapRows(~G, i, i - 1);
                                i -:= 1;
                        else
                                i +:= 1;
                end if;
                // print(G); print(M); print(G_star); printf "\n";
        end while;

        return [Vector(Rationals(), G[i]) : i in [1 .. NumberOfRows(G)]];
end function;
