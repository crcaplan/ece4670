function x=enc(b)
%i don't think this needs to be a function if we're just sending through
%commcloud oops

%where do we get impulse response?
Ns = 200000;
n_minus = 0;
n_plus = 199999; %N >= n_plus + n_minus + 1, do we want biggest possible n_plus?



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
%should n_minus be zero?
batch0 = zeros(Ns,1);
batch1 = Xtime((Ns-n_minus+1):(Ns)); Xtime(1:Ns);
batch2 = Xtime((2*Ns-n_minus+1):(2*Ns)); Xtime(Ns+1:(2*Ns));
batch3 = Xtime((3*Ns-n_minus+1):(3*Ns)); Xtime(2*Ns+1:(3*Ns));

%generate wav files
%should the zeros pad the front of every batch, or go all at once?
audiowrite('tx0.wav', batch0, 44100, 'BitsPerSample', 24);
audiowrite('tx1.wav', batch1, 44100, 'BitsPerSample', 24);
audiowrite('tx2.wav', batch2, 44100, 'BitsPerSample', 24);
audiowrite('tx3.wav', batch3, 44100, 'BitsPerSample', 24);

end