G := Graph< 4 | {1, 2}, {2, 3}, {3, 4}, {1, 4}>;
X := Edges(G);
w1w2 := X[1];

for e in EdgeSet(G) do;
	if not w1w2 eq e then
		G +:= 2;
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
