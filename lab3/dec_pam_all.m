function bhat=dec(sreceived)
%sreceived (double)=the received symbols, including inter symbol interference and noise
%bhat (double)=the estimated bits
%Peter C. Doerschuk March 23, 2021

tmp=(0:length(sreceived)-12)';
c=(-.99).^tmp;
r=[1 ; zeros(length(sreceived)-12,1)];
H=toeplitz(c,r);

[U,L,V] = svd(H);

yprime = U'*sreceived;

Nb = 24;

bhat=zeros(Nb,1);
% for n=1:Nb
%   if sreceived(n)>=0
%     bhat(n)=1;
%   end
%   %no need to consider sreceived(...)<0 because bhat is initialized to zero.
% end

count = 1;
power = 0.25;
gamma = sqrt(power/5);

for k = 1:length(yprime)
    yprime(k) = yprime(k) / L(k,k);
end


for i = 1:length(yprime)
    
    if yprime(i) < -2*gamma
        bhat(count) = 0;
        bhat(count + 1) = 0;
    end
    
    if yprime(i) > -2*gamma && yprime(i) < 0
        bhat(count) = 0;
        bhat(count + 1) = 1;
    end
    
    if yprime(i) > 0 && yprime(i) < 2*gamma
        bhat(count) = 1;
        bhat(count + 1) = 1;
    end
    
    if yprime(i) > 2*gamma
        bhat(count) = 1;
        bhat(count + 1) = 0;
    end
    

count = count + 2;   
         
end