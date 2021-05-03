function s=enc(b)
%b (double)=vector of input bits.
%s (double)=resulting vector of input symbols.
%Peter C. Doerschuk March 23, 2021

Nb=length(b);
Npause=375;

sshort=2*b-1;
s=zeros(Nb*Npause,1);
for n=1:Nb
  s( (n-1)*Npause+1 )=sshort(n);
end
