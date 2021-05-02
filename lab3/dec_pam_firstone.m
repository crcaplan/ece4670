function bhat=dec(sreceived)
%sreceived (double)=the received symbols, including inter symbol interference and noise
%bhat (double)=the estimated bits
%Peter C. Doerschuk March 23, 2021

tmp=(0:length(sreceived)-1)';
c=(-.99).^tmp;
r=[1 ; zeros(length(sreceived)-1,1)];
H=toeplitz(c,r);

[U,L,V] = svd(H);

yprime = U'*sreceived;

Nb = length(yprime)+1;

bhat=zeros(Nb,1);

for n=2:Nb-1
  if yprime(n)>=0
    bhat(n+1)=1;
  end
  %no need to consider sreceived(...)<0 because bhat is initialized to zero.
end

power = 0.25;
gamma = sqrt(power/5);
yprime(1) = yprime(1) / L(1,1);
    
if yprime(1) < -2*gamma
    bhat(1) = 0;
    bhat(2) = 0;
end

if yprime(1) > -2*gamma && yprime(1) < 0
    bhat(1) = 0;
    bhat(2) = 1;
end

if yprime(1) > 0 && yprime(1) < 2*gamma
    bhat(1) = 1;
    bhat(2) = 1;
end

if yprime(1) > 2*gamma
    bhat(1) = 1;
    bhat(2) = 0;
end
    

         
end