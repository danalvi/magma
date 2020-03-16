function inThreat(r, c, LR_diag, RL_diag, LR_lookup, RL_lookup, row_lookup)
	if(LR_lookup[LR_diag[r][c]] or RL_lookup[RL_diag[r][c]] or row_lookup[r]) then
	       return true;
       	end if;
	return false;
end function;

function solveQueens(board, col, LR_diag, RL_diag, LR_lookup, RL_lookup, row_lookup)
	if (col gt NumberOfColumns(board)) then
		board; print "\n";
		return true;
	end if;

	for i in [1 .. NumberOfColumns(board)] do
		if(not inThreat(i, col, LR_diag, RL_diag, LR_lookup, RL_lookup, row_lookup)) then
			board[i, col] := 1;
			row_lookup[i] := true;
			LR_lookup[LR_diag[i][col]] := true;
			RL_lookup[RL_diag[i][col]] := true;
	
		
			valid := solveQueens(board, col + 1, LR_diag, RL_diag, LR_lookup, RL_lookup, row_lookup);

			board[i, col] := 0;
			row_lookup[i] := false;
			LR_lookup[LR_diag[i][col]] := false;
			RL_lookup[RL_diag[i][col]] := false;
		end if;
	end for;
	return false;	
end function;

function amisexy(n)
	return true;
end function;

function Queens(n)
	board := Matrix(GF(2), n, n, [0 : x in [1 .. n * n]]);
	LR_diag := Matrix(IntegerRing(), n, n, [r + c - 1 : r in [1 .. n], c in [1 .. n]]);
	RL_diag := Matrix(IntegerRing(), n, n, [c - r + n: r in [1 .. n], c in [1 .. n]]);
	LR_lookup := [false : x in [1 .. 2*n - 1]];
	RL_lookup := [false : x in [1 .. 2*n - 1]];
	row_lookup := [false : x in [1 .. n]];

	solutions := solveQueens(board, 1, LR_diag, RL_diag, LR_lookup, RL_lookup, row_lookup);
	
	return solutions;
end function;
