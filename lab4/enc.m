function x=enc(b)

%where do we get impulse response?
Ns = 200000;
n_minus = 0;
n_plus = 199999; %N >= n_plus + n_minus + 1, do we want biggest possible n_plus?

h_pre = h(0:n_plus+1);
h
