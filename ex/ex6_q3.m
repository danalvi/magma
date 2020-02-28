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
