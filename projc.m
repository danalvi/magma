// Hoon Hong's Improved Projection Operator in Cylindrical Algebraic Decomposition
// Based on "Quantifier Elimination and Cylindrical Algebraic Decomposition" ( https://www.springer.com/gp/book/9783211827949 ), referred to as (Collins 1993) herafter
// Implemented by Danish A. Alvi as part of completion of the  Computer Algebra course, supervised by Wieb Bosma

// Declaration of Global variables , dimensions , to be alterated later after testing period //

N := 2; P<[X]> := PolynomialRing(RealField(10), N);

A1 := 144*(X[2])^2 + 96*(X[1]^2)*(X[2]) + 9*(X[1])^4 + 105*(X[1])^2 + 70*(X[1]) - 98;
A2 := (X[1])*(X[2])^2 +6*(X[1])*(X[2]) + (X[1])^3 + 9*(X[1]);

// A := { A1, A2 };

// F := (X[2]^2 + X[1]^1 - 1)*(X[3]^3) + (X[1] - 1)*((X[3])^2) + (X[1] - 1)^2 + (X[2])^2;

function red(F, k, var)
	if (k eq 0) then
		return F;
	end if;
	return red(Reductum(F, var), k - 1, var);
end function;

function RED(F, var)
	return { red(F, i, var) : i in [ 0 .. Degree(F, var) ] | red(F, i, var) ne 0  };
end function;

function psc(F, G, j, var)
	m := Degree(F, var); n := Degree(G, var);
	// Based on Collins 1993, p. 109 (last paragraph where psc is mechanised)
	// Constructing the Sylvester Matrix. Highly influenced in mechanism to Wolfram's method (https://mathworld.wolfram.com/SylvesterMatrix.html)
	seq := []; Coefficients_F := Reverse(Coefficients(F, var)); Coefficients_G := Reverse(Coefficients(G, var));
	for i := 1 to n do
		if (i eq 1) then
			if (n ne 0) then
				Append(~seq, Coefficients_F cat [0 : x in [1 .. n - 1 ] ] );
			else 
				Append(~seq, Coefficients_F );
			end if;
		else
			//Append(~seq, [0 : x in [1 .. i ] ] cat Coefficients_F cat [0 : x in [1 .. n - i - 1 ] ] );
			Append(~seq, [0] cat Remove(seq[#seq], #seq[#seq])); 
		end if;
	end for;
	for i := 1 to m do
		if (i eq 1) then
			if (m ne 0) then
				Append(~seq, Coefficients_G cat [0 : x in [1 .. m - 1 ] ] );
			else
				Append(~seq, Coefficients_G );
			end if;
		else
                	//Append(~seq, [0 : x in [1 .. i  ] ] cat Coefficients_G cat [0 : x in [1 .. m - i - 1] ] );
        		Append(~seq, [0] cat Remove(seq[#seq], #seq[#seq])); 
		end if;
	end for;
	A := Matrix(seq);
	//print "Printing A\n"; print A;
	if ( ( j gt 0 ) and (j lt n) ) then // Added new condition
		for i := 0 to (j - 1) do
			RemoveRow(~A, m - i);
		end for;
		for i := 0 to (j - 1) do
			RemoveRow(~A, m + n - j - i ); // m + n because that is the dimension of A. - j as we have removed j rows from the previous four. + 1 due to the same reason, i is counter
		end for;
		//print "Printing A after row removals\n"; print A;
		v := ExtractBlock(A, 1, m + n - 2*j, m + n - 2*j, 1); // Saving the column m + n - i - j (here, i = j as we are considering M_{j,j} )
		//print "Printing v\n"; print v;
		M := ZeroMatrix(BaseRing(A), m + n - 2*j, m + n - 2*j); // Initialise new matrix
		InsertBlock(~M, ExtractBlock(A, 1, 1, m + n - 2*j, m + n - 2*j - 1 ), 1, 1);
		InsertBlock(~M, v, 1, m + n - 2*j );
		//print "Printing M\n"; print M;
		return Determinant(M);
	else
		return Determinant(A); // This part may or definitely is wrong
	end if;
end function;

function PSC(F, G, var) // Collins 1993 p 143 - 144
	n := Min(Degree(F, var), Degree(G, var));
        if ( (F eq 0) or (G eq 0) ) then
		return { };
	end if;
	return { psc(F, G, j, var) : j in [ 0 .. n ] | psc(F, G, j, var) ne 0  };
end function;

//psc(A1, Derivative(A1, 2), 1, 2); 
//psc(A2, Derivative(A2, 2), 1, 2);
//psc(A1, A2, 1, 2);

// Implemented just as defined by Collins 1993 p 144

function PROJH(A, var) // A must be indexed set of polynomials!!
	PROJ1 := { };
	for i := 1 to #A do
	  	R_i := RED(A[i], var); 
		for G_i in R_i do
			U := {LeadingCoefficient(G_i, var)} join PSC(G_i, Derivative(G_i, var), var);
			PROJ1 := PROJ1 join U;
		end for;
	end for;

	// The comment portion below is the original PROJ2 . We now are implementing the "improved" PROJ2 as mentioned on Collins 1993 p 168 2.2
	//PROJ2 := {};
	//for i := 1 to (#A - 1)  do
	//	for j := i + 1 to #A do
	//		// print i; print " , "; print j; print "\n";
	//		R_i := RED(A[i], var); R_j := RED(A[j], var);
	//		U := {@ <x,y> : x in R_i, y in R_j @};
	//		for i := 1 to #U do
	//			PROJ2 := PROJ2 join PSC(U[i][1], U[i][2], var);
	//		end for;
	//	end for;
	//end for;
	
	// Improved PROJ2 Collins 1993 p 168 2.2
	// The linear ordering is aribtary, so we will simply take the ascending ordering of indices on the (indexed) set A
	
	PROJ2 := { };
	for i := 1 to (#A - 1) do
		for j := i + 1 to #A do
	       		F := A[i]; G := A[j];
			RED_F := RED(F, var);
			for F_star in RED_F do
				PROJ2 := PROJ2 join PSC(F_star, G, var);
			end for;
		end for;	
	end for;
	return PROJ1 join PROJ2;
end function;
