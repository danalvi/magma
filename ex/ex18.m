load 'ex17.m';

function MinPolynomial(a, N, d)
	G := ZeroMatrix(Rationals(), d, d + 1);
	InsertBlock(~G, DiagonalMatrix(Rationals(), [1 : x in [1 .. d]]), 1, 1);	
	v := Vector(Rationals(), [N * a^(d-i-1) : i in [1 .. (d ) ]]);
	InsertBlock(~G, Transpose(Matrix(v)), 1, d + 1);
	return G;
end function;
