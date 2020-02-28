procedure IntegerToBinaryTest()
	for i in [0 .. 32] do
		if not IntegerToSequence(i, 2) eq IntegerToBinary(i) then
			print(i);
		end if;
	end for;
end procedure;
