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

last_pam_idx = 4;

for n=last_pam_idx:Nb-1
  if yprime(n)>=0
    bhat(n+1)=1;
  end
  %no need to consider sreceived(...)<0 because bhat is initialized to zero.
end

power = 0.25;
gamma = sqrt(power/5);
yprime(1) = yprime(1) / L(1,1);
yprime(2) = yprime(2) / L(2,2);


bits_idx = 1;

for i = 1:(last_pam_idx/2)
    
    if yprime(i) < -2*gamma
        bhat(bits_idx) = 0;
        bhat(bits_idx+1) = 0;
    end

    if yprime(i) > -2*gamma && yprime(1) < 0
        bhat(bits_idx) = 0;
        bhat(bits_idx+1) = 1;
    end

    if yprime(i) > 0 && yprime(1) < 2*gamma
        bhat(bits_idx) = 1;
        bhat(bits_idx+1) = 1;
    end

    if yprime(i) > 2*gamma
        bhat(bits_idx) = 1;
        bhat(bits_idx+1) = 0;
    end
    
    bits_idx = bits_idx + 1;

         
end