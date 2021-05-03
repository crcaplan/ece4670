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
output = zeros(Nb/2, 1);
power = 0.25;
gamma = sqrt(power/5);
count = 1;

for i = 1:2:length(x)
       
    if x(i) == 0 && x(i+1) == 0
        output(count) = -3*gamma;
    end
    
    if x(i) == 0 && x(i+1) == 1
        output(count) = -1*gamma;
    end
    
    if x(i) == 1 && x(i+1) == 1
        output(count) = gamma;
    end
    
    if x(i) == 1 && x(i+1) == 0
        output(count) = 3*gamma;
    end
    
   count = count + 1;
             
end


x = output;









