function bhat=dec_pam_all(sreceived)
%sreceived (double)=the received symbols, including inter symbol interference and noise
%bhat (double)=the estimated bits
%Peter C. Doerschuk March 23, 2021

tmp=(0:length(sreceived)-1)';
c=(-.99).^tmp;
r=[1 ; zeros(length(sreceived)-1,1)];
H=toeplitz(c,r);

[U,L,V] = svd(H);

yprime = U'*sreceived;

Nb = length(sreceived);

bhat=zeros(Nb,1);
% for n=1:Nb
%   if sreceived(n)>=0
%     bhat(n)=1;
%   end
%   %no need to consider sreceived(...)<0 because bhat is initialized to zero.
% end

count = 1;
gamma = 1;

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