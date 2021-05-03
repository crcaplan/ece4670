function bhat=dec(sreceived)
%sreceived (double)=the received symbols, including inter symbol interference and noise
%bhat (double)=the estimated bits
%Peter C. Doerschuk March 23, 2021

last_pam_idx = 12;

tmp=(0:length(sreceived)-1)';  % changed to 2
c=(-.99).^tmp;
r=[1 ; zeros(length(sreceived)-1,1)];
H=toeplitz(c,r);

[U,L,V] = svd(H);


yprime = U'*sreceived;

Nb = length(yprime)+(last_pam_idx/2);

bhat=zeros(Nb,1);


for n=(last_pam_idx)/2+1:length(yprime)%(last_pam_idx/2) + (24-last_pam_idx)
  if yprime(n)>=0
    bhat(n+(last_pam_idx/2))=1;
  end
  %no need to consider sreceived(...)<0 because bhat is initialized to zero.
end


power = 0.25;
gamma = sqrt(power/5);

%size(L);
%disp(L);


for k = 1:last_pam_idx/2
    yprime(k) = yprime(k) / L(k,k);
end


bits_idx = 1;

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