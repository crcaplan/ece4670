function x=enc_pam_three(b)
% b (double) = vector of input bits.
% s (double) = resulting vector of input symbols.

% H matrix calcs taken from lab3 channel function
% changed indices to reflect 3-PAM
tmp=(0:length(b)-3)';
c=(-.99).^tmp;
r=[1 ; zeros(length(b)-3,1)];
H=toeplitz(c,r);

% SVD to get pre/post-distortion matrices
[U,L,V] = svd(H);

Nb=length(b);
output = zeros(Nb-2,1);
power = 0.25;
gamma = sqrt(power/5); % 2-PAM gamma (better performance than 3-PAM gamma)

% encode based on 3-PAM constellation plot
if b(1) == 0 && b(2) == 0 && b(3) == 0
    output(1) = -7*gamma;
end

if b(1) == 0 && b(2) == 0 && b(3) == 1
    output(1) = -5*gamma;
end

if b(1) == 0 && b(2) == 1 && b(3) == 0
    output(1) = -3*gamma;
end

if b(1) == 0 && b(2) == 1 && b(3) == 1
    output(1) = -1*gamma;
end

if b(1) == 1 && b(2) == 0 && b(3) == 0
    output(1) = 1*gamma;
end

if b(1) == 1 && b(2) == 0 && b(3) == 1
    output(1) = 3*gamma;
end

if b(1) == 1 && b(2) == 1 && b(3) == 0
    output(1) = 5*gamma;
end

if b(1) == 1 && b(2) == 1 && b(3) == 1
    output(1) = 7*gamma;
end

% encode rest of bits with antipodal keying
xprime = sqrt(power)*(2*b - 1);
output(2:Nb-2) = xprime(4:Nb);

% pre-distortion
x = V*output;

end
