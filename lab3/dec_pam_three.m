function bhat=dec(sreceived)
%sreceived (double)=the received symbols, including inter symbol interference and noise
%bhat (double)=the estimated bits
%Peter C. Doerschuk March 23, 2021

tmp=(0:length(sreceived)-1)';
c=(-.99).^tmp;
r=[1 ; zeros(length(sreceived)-1,1)];
H=toeplitz(c,r);

[U,L,V] = svd(H);

size(U')
size(sreceived)

yprime = U'*sreceived;

Nb = length(yprime)+2;

bhat=zeros(Nb,1);

for n=2:Nb-2
  if yprime(n)>=0
    bhat(n+2)=1;
  end
  %no need to consider sreceived(...)<0 because bhat is initialized to zero.
end

power = 0.25;
gamma = sqrt(power/5);
yprime(1) = yprime(1) / L(1,1);
    
if yprime(1) < -6*gamma
    bhat(1) = 0;
    bhat(2) = 0;
    bhat(3) = 0;

end

if yprime(1) > -6*gamma && yprime(1) < -4*gamma
    bhat(1) = 0;
    bhat(2) = 0;
    bhat(3) = 1;

end

if yprime(1) > -4*gamma && yprime(1) < -2*gamma
    bhat(1) = 0;
    bhat(2) = 1;
    bhat(3) = 0;

end

if yprime(1) > -2*gamma && yprime(1) < 0
    bhat(1) = 0;
    bhat(2) = 1;
    bhat(3) = 1;

end

if yprime(1) > 0 && yprime(1) < 2*gamma
    bhat(1) = 1;
    bhat(2) = 0;
    bhat(3) = 0;

end

if yprime(1) > 2*gamma && yprime(1) < 4*gamma
    bhat(1) = 1;
    bhat(2) = 0;
    bhat(3) = 1;

end

if yprime(1) > 4*gamma && yprime(1) < 6*gamma
    bhat(1) = 1;
    bhat(2) = 1;
    bhat(3) = 0;

end

if yprime(1) > 6*gamma
    bhat(1) = 1;
    bhat(2) = 1;
    bhat(3) = 1;

end
        
end