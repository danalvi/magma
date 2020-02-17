IntegerToBinary := function(n)
	seq := [];
	while n gt 0 do
		b := n mod 2;
		n := n div 2;
		seq := seq cat [b];
	end while;
	return seq;
end function;
