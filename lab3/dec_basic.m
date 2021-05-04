function bhat=dec_basic(sreceived)
% sreceived (double) = the received symbols, including ISI and noise
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

% antipodal keying to get bhat values
Nb = length(yprime);
bhat=zeros(Nb,1);
for n=1:Nb
  if yprime(n)>=0
    bhat(n)=1;
  end
end

