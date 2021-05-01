function x=enc(b)
%b (double)=vector of input bits.
%s (double)=resulting vector of input symbols.
%Peter C. Doerschuk March 23, 2021

Nb=length(b);

tmp=(0:length(b)-1)';
c=(-.99).^tmp;
r=[1 ; zeros(length(b)-1,1)];
H=toeplitz(c,r);

[U,L,V] = svd(H);

x = V*b;






