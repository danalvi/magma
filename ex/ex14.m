load 'ex13.m';

// 14 a

function MyPollardRho(n,k,c)
	if ((n mod 2) eq 0) then
		return 2, 0;
	end if;
	if(not MyIsPrime(n, 50)) then
		d := 1; count := 1;
		while ( (d eq 1) or (d eq n)) do  // Incase one of the variables fails! It can give a repeating sequence
			X := [];
			Append(~X, Random(2, n - 1));
			for i := 1 to k do 
				Append(~X, ((X[i]^2) + c) mod n);
				for j := 1 to i do
					d := Gcd(X[i + 1] - X[j], n);
					if( (d gt 1) and (d lt n )) then
						return d, count; // Count added for iii
					end if;
				end for;
			end for;
			count +:= 1;
		end while;
	else
		return 1, 0; // Here it means the number was simply not composite
	end if;
end function;

// 14 b
// We are going to keep k = Sqrt(n), where n = p_j * q. as one of the factors must be below this

function GenNDigit(N)
        sum := 0;
        for i := 0 to N - 1 do
                if (i eq N - 1) then
                        sum +:= Random(1, 9) * 10^i;
                else
                        sum +:= Random(0, 9) * 10^i;
                end if;
        end for;
        return sum;
end function;

printf "\n14 ii\n";

q := MyNextPrime(GenNDigit(25)); // Just to be a bit unique with our choices, gentlemen
printf "q = %o\n", q;

//for i := 1 to 25 do
//	p_j := NextPrime(GenNDigit(i));
//	n := p_j * q;
//	 printf "N: %o, p_j = %o, Factor Found ! = %o\n", n, p_j,  MyPollardRho(n, Floor(Sqrt(n)), 2);
//end for;

// We see that as N ~ 10^30, life starts getting a bit difficult .... good news for cryptographers! 
// However, it might also have to do with the fact that we are not using Floyd's Cycle Finding Algorithm, where only two variables are stored ...

// 14 c
// I will be honest, I do not know what is the precise answer to this. I suppose it has something to do with the possibility of the sequence not being cyclic (i.e. for some c, there might be a higher number of x_0 seeds where the sequence is not cyclic, lets actually try this from 14 a's while loop having a counter for c = 0, 1, 2, -2

// Will only try some prime numbers 10 - 10^4 and aggregate results

print "\n14 iii\n";

c := 0;
total := 0;
tests := 1000;

for a := 1 to tests do
	for i := 1 to 3 do
		p := MyNextPrime(GenNDigit(i));
		q := MyNextPrime(GenNDigit(4 - i));
		n := p * q;
		d, count := MyPollardRho(n, Floor(Sqrt(n)), c);
		total +:= count;
	end for;
end for;
printf "c := %o, Cycles needed := %o\n", c, total;

c := 1; 
total := 0;

for a := 1 to tests do
        for i := 1 to 3 do
                p := MyNextPrime(GenNDigit(i));
                q := MyNextPrime(GenNDigit(4 - i));
                n := p * q;
                d, count := MyPollardRho(n, Floor(Sqrt(n)), c);
                total +:= count;
        end for;
end for;

printf "c := %o, Cycles needed := %o\n", c, total;


c := 2;
total := 0;

for a := 1 to tests do
        for i := 1 to 3 do
                p := MyNextPrime(GenNDigit(i));
                q := MyNextPrime(GenNDigit(4 - i));
                n := p * q;
                d, count := MyPollardRho(n, Floor(Sqrt(n)), c);
                total +:= count;
        end for;
end for;

printf "c := %o, Cycles needed := %o\n", c, total;


c := -2;
total := 0;

for a := 1 to tests do
        for i := 1 to 3 do
                p := MyNextPrime(GenNDigit(i));
                q := MyNextPrime(GenNDigit(4 - i));
                n := p * q;
                d, count := MyPollardRho(n, Floor(Sqrt(n)), c);
                total +:= count;
        end for;
end for;

printf "c := %o, Cycles needed := %o\n", c, total;


c := -1;
total := 0;

for a := 1 to tests do
        for i := 1 to 3 do
                p := MyNextPrime(GenNDigit(i));
                q := MyNextPrime(GenNDigit(4 - i));
                n := p * q;
                d, count := MyPollardRho(n, Floor(Sqrt(n)), c);
                total +:= count;
        end for;
end for;

printf "c := %o, Cycles needed := %o\n", c, total;


// 14 iv

function FloydPollardRho(n,k,c)
	function f(x)
		return (x^2 + c) mod n;
	end function;
	if ( ( n mod 2 ) eq 0) then
       		return 2;
	end if;
	if (not MyIsPrime(n, 50)) then	
		x := Random(2, n - 1); y := x; p := 1;
		while (p eq 1) do
			x := f(x);
			y := f(f(y));
			p := Gcd(Abs(x - y), n);
			
			if ( p gt 1 ) then
				return p;
			end if;
		end while;
	else
		return 1;
	end if;
end function;

printf "\n\n 14 iv\n\n";

q := MyNextPrime(GenNDigit(25)); // Just to be a bit unique with our choices, gentlemen
printf "q = %o\n", q;

for i := 1 to 25 do
	p_j := NextPrime(GenNDigit(i));
	n := p_j * q;
       	printf "N: %o, p_j = %o, Factor Found ! = %o\n", n, p_j,  FloydPollardRho(n, Floor(Sqrt(n)), 2);
end for;


