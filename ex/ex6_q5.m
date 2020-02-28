load "ex6_q1.m";
load "ex6_q4.m";

function SpeedTestGCD(k)
	a := SequenceToInteger([Random(0, 9): i in [1 .. k]]);
	b := SequenceToInteger([Random(0, 9): i in [1 .. k]]);	
	t_1 := Cputime();
	x := IntegerEuclidean(a, b);
	Cputime(t_1);
	t_2 := Cputime();
	y := SimpleGCD(a, b);
	Cputime(t_2);
	t_3 := Cputime();
	z := Gcd(a, b);
	Cputime(t_3);
	return t_1, t_2, t_3;
end function;
