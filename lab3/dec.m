function bhat=dec(sreceived)
% sreceived (double)=the received symbols, including ISI and noise
% bhat (double) = the estimated bits

% H matrix calcs taken from lab3 channel function
tmp=(0:length(sreceived)-1)';
c=(-.99).^tmp;
r=[1 ; zeros(length(sreceived)-1,1)];
H=toeplitz(c,r);

% SVD to get pre/post-distortion matrices
[U,L,V] = svd(H);

% post-distortion
yprime = U'*sreceived;

% antipodal decoding for non-2-PAM symbols
Nb = length(yprime)+1;
bhat=zeros(Nb,1);
for n=2:Nb-1
  if yprime(n)>=0
    bhat(n+1)=1;
  end
end

power = 0.25;
gamma = sqrt(power/5); % 2-PAM gamma
yprime(1) = yprime(1) / L(1,1); % account for gain

% decode based on thresholds in 2-PAM constellation plot
if yprime(1) <= -2*gamma
    bhat(1) = 0;
    bhat(2) = 0;
end

if yprime(1) > -2*gamma && yprime(1) <= 0
    bhat(1) = 0;
    bhat(2) = 1;
end

if yprime(1) > 0 && yprime(1) <= 2*gamma
    bhat(1) = 1;
    bhat(2) = 1;
end

if yprime(1) > 2*gamma
    bhat(1) = 1;
    bhat(2) = 0;
end       
end