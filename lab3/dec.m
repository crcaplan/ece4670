function bhat=dec(sreceived)
%sreceived (double)=the received symbols, including inter symbol interference and noise
%bhat (double)=the estimated bits
%Peter C. Doerschuk March 23, 2021

Npause=375;

Nb=length(sreceived)/375;
if round(Nb)~=Nb
  fprintf(1,'dec: round(Nb) %g Nb %d\n',round(Nb),Nb);
  error('dec error');
end

bhat=zeros(Nb,1);
for n=1:Nb
  if sreceived( (n-1)*Npause+1 )>=0
    bhat(n)=1;
  end
  %no need to consider sreceived(...)<0 because bhat is initialized to zero.
end
