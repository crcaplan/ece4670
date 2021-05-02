function x=enc(b)
%b (double)=vector of input bits.
%s (double)=resulting vector of input symbols.
%Peter C. Doerschuk March 23, 2021

Nb=length(b);

tmp=(0:length(b)-2)';  % changed to 2
c=(-.99).^tmp;
r=[1 ; zeros(length(b)-2,1)];
H=toeplitz(c,r);

[U,L,V] = svd(H);

output = zeros(Nb-1,1);
power = 0.25;
gamma = sqrt(power/5);

out_idx = 1;
last_pam_idx = 4;

for i = 1:2:last_pam_idx
       
    if b(i) == 0 && b(i+1) == 0
        output(out_idx) = -3*gamma;
    end

    if b(i) == 0 && b(i+1) == 1
        output(out_idx) = -1*gamma;
    end

    if b(i) == 1 && b(i+1) == 1
        output(out_idx) = gamma;
    end

    if b(i) == 1 && b(i+1) == 0
        output(out_idx) = 3*gamma;
    end        
    
    out_idx = out_idx + 1;

end

xprime = sqrt(power)*(2*b - 1);
output(last_pam_idx:Nb-1) = xprime(last_pam_idx+1:Nb);

size(V);
size(output);

x = V*output;















