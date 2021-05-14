function x=enc(b)
% b (double) = vector of input bits.
% s (double) = resulting vector of input symbols.

% H matrix calcs taken from lab3 channel function
tmp=(0:length(b)-2)';  % changed to 2
c=(-.99).^tmp;
r=[1 ; zeros(length(b)-2,1)];
H=toeplitz(c,r);

% SVD to get pre/post-distortion matrices
[U,L,V] = svd(H);

Nb=length(b);
output = zeros(Nb-1,1);
power = 0.25;
gamma = sqrt(power/5); % 2-PAM gamma

% encode based on 2-PAM constellation plot
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

% encode rest of bits with antipodal keying
xprime = sqrt(power)*(2*b - 1);
output(2:Nb-1) = xprime(3:Nb);

% pre-distortion
x = V*output;