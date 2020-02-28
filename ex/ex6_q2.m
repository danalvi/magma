function IntegerExtendedEuclidean(a, b)
	s := [0, 1];
	t := [1, 0];
	r := [Abs(b), Abs(a)];
	while not r[1] eq 0 do
		quotient, remainder := Quotrem(r[2], r[1]);
		r := [r[2] - quotient * r[1], r[1]];
		s := [s[2] - quotient * s[1], s[1]];
		t := [t[2] - quotient * t[1], t[1]];
	end while;
	return r[2], s[2], t[2];	
	//return [s[2], t[2]], r[2], [t[1], s[1]];
end function;
