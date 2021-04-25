function y=lab3_channel(x)
tmp=(0:length(x)-1)';
c=(-.99).^tmp;
r=[1 ; zeros(length(x)-1,1)];
H=toeplitz(c,r);

z=0.10*randn(length(x),1);

y=H*x + z;
