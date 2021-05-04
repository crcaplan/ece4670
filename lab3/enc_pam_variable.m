function x=enc_pam_variable(b)
% b (double) = vector of input bits.
% s (double) = resulting vector of input symbols.

% variable representing how many bits to encode with 2-PAM
last_pam_idx = 4;

% H matrix calcs taken from lab3 channel function
% changed indices to reflect variable 2-PAM
tmp=(0:length(b)-(last_pam_idx/2)-1)';
c=(-.99).^tmp;
r=[1 ; zeros(length(b)-(last_pam_idx/2)-1,1)];
H=toeplitz(c,r);

% SVD to get pre/post-distortion matrices
[U,L,V] = svd(H);

Nb=length(b);
output = zeros((last_pam_idx/2) + (24-last_pam_idx),1);
power = 0.25;
gamma = sqrt(power/5); %2-PAM gamma

out_idx = 1; %symbol vector indexing

% encode based on 2-PAM constellation plot
% iterate up to variable to cover all 2-PAM bits
for i = 1:2:last_pam_idx
       
    if b(i) == 0 && b(i+1) == 0
        output(out_idx) = -3*gamma;
    end

    if b(i) == 0 && b(i+1) == 1
        output(out_idx) = -1*gamma;
    end

    if b(i) == 1 && b(i+1) == 1
        output(out_idx) = gamma;
    end

    if b(i) == 1 && b(i+1) == 0
        output(out_idx) = 3*gamma;
    end        
    
    out_idx = out_idx + 1;

end

% encode rest of bits with antipodal keying
xprime = sqrt(power)*(2*b - 1);
output((last_pam_idx/2)+1:(last_pam_idx/2) + (24-last_pam_idx)) = xprime(last_pam_idx+1:Nb);

% pre-distortion
x = V*output;

end















