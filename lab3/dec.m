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


bhat=zeros(Nb,1);
for n=1:Nb
  if sreceived(n)>=0
    bhat(n)=1;
  end
  %no need to consider sreceived(...)<0 because bhat is initialized to zero.
end
