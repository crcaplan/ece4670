function bhat1 = dec()

%read in wav file
[s0,~]=audioread('rx0.wav');

% constants
b_len = 3000;
Ns = 2*b_len + 1;
n_minus = 0;
n_plus = 150; % or 175
batch_size = 1000;

prefix1_len = length(s0((batch_size-n_plus+1):(batch_size)));
prefix2_len = length(s0((2*batch_size-n_plus+1):(2*batch_size)));
prefix3_len = length(s0((3*batch_size-n_plus+1):(3*batch_size)));

start = Ns + 2*b_len + 1;

% could this be wrong? are we grabbing the wrong symbols?
s1 = s0(start + prefix1_len+1 : start + prefix1_len + batch_size);
s2 = s0(start + prefix1_len+1 + batch_size + prefix2_len : start + prefix1_len + batch_size*2 + prefix2_len);
s3 = s0(start + prefix1_len+1 + batch_size*2 + prefix2_len + prefix3_len : start + prefix1_len + batch_size*3 + prefix2_len + prefix3_len);

s_whole = [s1; s2; s3];

length(s1)
length(s2)
length(s3)


s_learn = s0(Ns+1:Ns+1+ 2*b_len+1);

S_freq = fft(s_whole);
S_learn = fft(s_learn);

%isolate left side of fft (do we need to round)
% get rid of the zero entry, no bits were put there
S_freq_left = S_freq(2:(length(S_freq)/2));
S_learn_left = S_learn(2:(length(S_learn)/2));

learn_sym_mag = abs(S_learn_left);

% learn batch, bits one with random phases, directly getting the freq
% response - do once just for the bits from the learning batch

% divide the output by the input to get mag of freq reponse

%learn_symb = s0(2*Ns+1:2*Ns+1+(Ns/2)); % freq domain - check this

%learn_symb = s0(Ns+1:Ns+1 + 2*b_len); % freq domain - check this
%learn_sym_mag = abs(learn_symb); % get rid of phases (should divide by 1)

% mag of yc, complex num got out of the fft, compare


%A is power 0.25
power = 0.5;

%compare fft left to power*fft of impulse response*.5
compare_metric_s0 = 0.5*power*learn_sym_mag; % this is a vector

%length(compare_metric_s1)
%length(S_freq_left)

%loop through to compare elementwise?
bhat1 = zeros(b_len,1);
for i=1:length(S_freq_left)
    if abs(S_freq_left(i)) > compare_metric_s0(i)
        bhat1(i) = 1;
    end
end

end