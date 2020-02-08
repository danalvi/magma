G := Graph< 3 | {1, 2}, {2, 3}, {1, 3}>;

generalized_K3 := function(G)
	X := Edges(G);
        w1w2 := X[1];
	for e in EdgeSet(G) do;
		if not w1w2 eq e then
			RemoveEdge(~G, Index(InitialVertex(e)), Index(TerminalVertex(e)));
			AddVertices(~G, 2);
			V := Vertices(G);
			u := V[#V];
			v := V[#V - 1];
			x := InitialVertex(e);
			y := TerminalVertex(e);
			AddEdge(~G, Index(u), Index(x));
			AddEdge(~G, Index(u), Index(y));
			AddEdge(~G, Index(v), Index(x));
			AddEdge(~G, Index(v), Index(y));
		end if;
	end for;
	return G;
end function;

generalized_K3(G);
