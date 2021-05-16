function x=enc(b)

%where do we get impulse response?
Ns = 200000;
n_minus = 0;
n_plus = 199999; %N >= n_plus + n_minus + 1, do we want biggest possible n_plus?

h_pre = h(0:n_plus+1);
h


% load bits into a complex valued Xs vector
% this is the frequency domain
b_l = length(b);
Xs_left = zeros(b_l, 1);
Xs(1) = 0;

pow = 0.25;

rng(5);
theta = 2*pi(rand(b_1));

for i = 1:b_1
    if b(i) == 1
       Xs_left(i+1) = pow*exp(sqrt(-1)*theta(i+1));   
    else
        Xs_left(i) = 0;
    end
end

Xs_right = flip(conj(Xs_left));
Xs = [X_left ; Xs_right];

Xs_l = length(Xs);

if rem(b_1, 2) == 0
    Xs(Xs_l/2 + 1) = 0;
end

% take iDFT and that gives a real vector

Xtime = ifft(Xs); % 

% prepend and append zeros to Xtime

end