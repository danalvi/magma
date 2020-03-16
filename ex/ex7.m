// Using Cayley Graph as mentioned in https://upload.wikimedia.org/wikipedia/commons/9/97/Dih_4_Cayley_Graph%3B_generators_a%2C_b.svg


// F will be the first (unique under transformations of board under D8) matrix found.

function a(M) // Rotation to Right 90 degrees
	N := Matrix(GF(2), NumberOfRows(M), NumberOfColumns(M), [0 : x in [1 .. NumberOfRows(M) * NumberOfColumns(M)]]);
	for i in [1 .. NumberOfRows(M)] do
		for j in [1 .. NumberOfColumns(M)] do
			N[i, j] := M[NumberOfColumns(M) + 1 - j, i];          
		end for;
	end for;
	return N;
end function;

function b(M) // Diagonal Reflection
	N := Matrix(GF(2), NumberOfRows(M), NumberOfColumns(M), [0 : x in [1 .. NumberOfRows(M) * NumberOfColumns(M)]]);
	for i in [1 .. NumberOfRows(M)] do
		for j in [1 .. NumberOfColumns(M)] do
			N[i, j] := M[i, NumberOfColumns(M) + 1 - j];
		end for;
	end for;
	return N;
end function;

function inThreat(r, c, LR_diag, RL_diag, LR_lookup, RL_lookup, row_lookup)
	if(LR_lookup[LR_diag[r][c]] or RL_lookup[RL_diag[r][c]] or row_lookup[r]) then
	       return true;
       	end if;
	return false;
end function;

procedure solveUniqueQueens(board, ~solutions, col, LR_diag, RL_diag, LR_lookup, RL_lookup, row_lookup)
        if (col gt NumberOfColumns(board)) then
                if (not (b(board) in solutions or (a(board) in solutions or b(a(board)) in solutions) or (a(a(board)) in solutions or b(a(a(board))) in solutions) or (a(a(a(board))) in solutions or b(a(a(a(board)))) in solutions))) then
			Include(~solutions, board); 
		end if;
                return;
        end if;

        for i in [1 .. NumberOfColumns(board)] do
                if(not inThreat(i, col, LR_diag, RL_diag, LR_lookup, RL_lookup, row_lookup)) then
                        board[i, col] := 1;
                        row_lookup[i] := true;
                        LR_lookup[LR_diag[i][col]] := true;
                        RL_lookup[RL_diag[i][col]] := true;


                        solveUniqueQueens(board, ~solutions, col + 1, LR_diag, RL_diag, LR_lookup, RL_lookup, row_lookup);

                        board[i, col] := 0;
                        row_lookup[i] := false;
                        LR_lookup[LR_diag[i][col]] := false;
                        RL_lookup[RL_diag[i][col]] := false;
                end if;
        end for;
        return;
end procedure;

procedure solveQueens(board, ~solutions, col, LR_diag, RL_diag, LR_lookup, RL_lookup, row_lookup)
	if (col gt NumberOfColumns(board)) then
		board; print "\n";
		//Include(~solutions, board);
		return;
	end if;

	for i in [1 .. NumberOfColumns(board)] do
		if(not inThreat(i, col, LR_diag, RL_diag, LR_lookup, RL_lookup, row_lookup)) then
			board[i, col] := 1;
			row_lookup[i] := true;
			LR_lookup[LR_diag[i][col]] := true;
			RL_lookup[RL_diag[i][col]] := true;
	
		
			solveQueens(board, ~solutions, col + 1, LR_diag, RL_diag, LR_lookup, RL_lookup, row_lookup);

			board[i, col] := 0;
			row_lookup[i] := false;
			LR_lookup[LR_diag[i][col]] := false;
			RL_lookup[RL_diag[i][col]] := false;
		end if;
	end for;
	return;
end procedure;

function Queens(n)
	solutions := {};
	
	board := Matrix(GF(2), n, n, [0 : x in [1 .. n * n]]);
	LR_diag := Matrix(IntegerRing(), n, n, [r + c - 1 : r in [1 .. n], c in [1 .. n]]);
	RL_diag := Matrix(IntegerRing(), n, n, [c - r + n : r in [1 .. n], c in [1 .. n]]);
	LR_lookup := [false : x in [1 .. 2*n - 1]];
	RL_lookup := [false : x in [1 .. 2*n - 1]];
	row_lookup := [false : x in [1 .. n]];

	solveQueens(board, ~solutions, 1, LR_diag, RL_diag, LR_lookup, RL_lookup, row_lookup);
	
	return #solutions;
end function;

function UniqueQueens(n)
        solutions := {};

        board := Matrix(GF(2), n, n, [0 : x in [1 .. n * n]]);
        LR_diag := Matrix(IntegerRing(), n, n, [r + c - 1 : r in [1 .. n], c in [1 .. n]]);
        RL_diag := Matrix(IntegerRing(), n, n, [c - r + n : r in [1 .. n], c in [1 .. n]]);
        LR_lookup := [false : x in [1 .. 2*n - 1]];
        RL_lookup := [false : x in [1 .. 2*n - 1]];
        row_lookup := [false : x in [1 .. n]];

        solveUniqueQueens(board, ~solutions, 1, LR_diag, RL_diag, LR_lookup, RL_lookup, row_lookup);

        return #solutions;
end function;

procedure solveRemainingQueens(board, ~solutions, col, LR_diag, RL_diag, LR_lookup, RL_lookup, row_lookup, col_lookup)
        if (col gt NumberOfColumns(board)) then
                if (not (b(board) in solutions or (a(board) in solutions or b(a(board)) in solutions) or (a(a(board)) in solutions or b(a(a(board))) in solutions) or (a(a(a(board))) in solutions or b(a(a(a(board)))) in solutions))) then
                        Include(~solutions, board);
                end if;
                return;
        end if;

        for i in [1 .. NumberOfColumns(board)] do
                if(not inThreat(i, col, LR_diag, RL_diag, LR_lookup, RL_lookup, row_lookup)) then
                        board[i, col] := 1;
                        row_lookup[i] := true;
                        LR_lookup[LR_diag[i][col]] := true;
                        RL_lookup[RL_diag[i][col]] := true;


                        solveUniqueQueens(board, ~solutions, col + 1, LR_diag, RL_diag, LR_lookup, RL_lookup, row_lookup);

                        board[i, col] := 0;
                        row_lookup[i] := false;
                        LR_lookup[LR_diag[i][col]] := false;
                        RL_lookup[RL_diag[i][col]] := false;
                end if;
        end for;
        return;
end procedure;

// It is not clear weather we were expected to give Unique remaining queens or not. I am assuming it is so.

function AddRemainingQueens(board)
        
	n := NumberOfRows(board);
	solutions := {};
	
	invert_board := a(board);
	col_lookup :=  [false : x in [1 .. NumberOfColumns(board)]];	
	zeros := [0 : x in [1 .. NumberOfRows(board)]];
	for i in [1 .. NumberOfColumns(board)] do
		if invert_board[i] eq Vector(NumberOfRows(board),zeros) then
			col_lookup[i] := true;
		end if;
	end for;

        LR_diag := Matrix(IntegerRing(), n, n, [r + c - 1 : r in [1 .. n], c in [1 .. n]]);
        RL_diag := Matrix(IntegerRing(), n, n, [c - r + n : r in [1 .. n], c in [1 .. n]]);
        LR_lookup := [false : x in [1 .. 2*n - 1]];
        RL_lookup := [false : x in [1 .. 2*n - 1]];
        row_lookup := [false : x in [1 .. n]];
        solveRemainingQueens(board, ~solutions, 1, LR_diag, RL_diag, LR_lookup, RL_lookup, row_lookup, col_lookup);

        return #solutions;
end function;
