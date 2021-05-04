function bhat=dec_pam_variable(sreceived)
% sreceived (double) = the received symbols, including ISI and noise
% bhat (double) = the estimated bits

% variable representing how many bits to encode with 2-PAM
last_pam_idx = 4;

% H matrix calcs taken from lab3 channel function
% changed indices to reflect variable 2-PAM
tmp=(0:length(sreceived)-1)';  % changed to 2
c=(-.99).^tmp;
r=[1 ; zeros(length(sreceived)-1,1)];
H=toeplitz(c,r);

% SVD to get pre/post-distortion matrices
[U,L,V] = svd(H);

% post-distortion
yprime = U'*sreceived;

% antipodal decoding for non-2-PAM symbols
Nb = length(yprime)+(last_pam_idx/2);
bhat=zeros(Nb,1);
for n=(last_pam_idx)/2+1:length(yprime)
  if yprime(n)>=0
    bhat(n+(last_pam_idx/2))=1;
  end
end

power = 0.25;
gamma = sqrt(power/5); % 2-PAM gamma

% account for gain
for k = 1:last_pam_idx/2
    yprime(k) = yprime(k) / L(k,k);
end

bits_idx = 1; %bhat vector indexing

% decode based on thresholds in 2-PAM constellation plot
% iterate up to variable to cover all 2-PAM bits
for i = 1:(last_pam_idx/2)
    
    if yprime(i) < -2*gamma
        bhat(bits_idx) = 0;
        bhat(bits_idx+1) = 0;
    end

    if yprime(i) > -2*gamma && yprime(i) < 0
        bhat(bits_idx) = 0;
        bhat(bits_idx+1) = 1;
    end

    if yprime(i) > 0 && yprime(i) < 2*gamma
        bhat(bits_idx) = 1;
        bhat(bits_idx+1) = 1;
    end

    if yprime(i) > 2*gamma
        bhat(bits_idx) = 1;
        bhat(bits_idx+1) = 0;
    end
    
    bits_idx = bits_idx + 1;      
end

end