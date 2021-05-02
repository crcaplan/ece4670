function x=enc(b)
%b (double)=vector of input bits.
%s (double)=resulting vector of input symbols.
%Peter C. Doerschuk March 23, 2021

Nb=length(b);

tmp=(0:length(b)-2)';  % changed to 2
c=(-.99).^tmp;
r=[1 ; zeros(length(b)-2,1)];
H=toeplitz(c,r);

[U,L,V] = svd(H);

output = zeros(Nb-1,1);
power = 0.25;
gamma = sqrt(power/5);
       
if b(1) == 0 && b(2) == 0
    output(1) = -3*gamma;
end

if b(1) == 0 && b(2) == 1
    output(1) = -1*gamma;
end

if b(1) == 1 && b(2) == 1
    output(1) = gamma;
end

if b(1) == 1 && b(2) == 0
    output(1) = 3*gamma;
end             

xprime = sqrt(power)*(2*b - 1);
output(2:Nb-1) = xprime(3:Nb);

size(V);
size(output);

x = V*output;















