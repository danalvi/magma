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
