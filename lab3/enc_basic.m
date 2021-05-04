function x=enc_basic(b)
% b (double) = vector of input bits.
% x (double) = resulting vector of input symbols.

% H matrix calcs taken from lab3 channel function
tmp=(0:length(b)-1)';
c=(-.99).^tmp;
r=[1 ; zeros(length(b)-1,1)];
H=toeplitz(c,r);

% SVD to get pre/post-distortion matrices
[U,L,V] = svd(H);

power = 0.25;

% xprime with antipodal keying
xprime = sqrt(power)*(2*b - 1);

% pre-distortion
x = V*xprime;


