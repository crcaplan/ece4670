function dec()

%read in 3 wav files
[s1,fs1]=audioread('rx1.wav');
[s2,fs2]=audioread('rx2.wav');
[s3,fs3]=audioread('rx3.wav');

%ffts of received signals
%indices of prefix
Ns = 200000; % hard code this, num bits per batch *2 + 1
n_minus = 0;
n_plus = 150; % or 175

prefix1_len = length(s1((Ns-n_minus+1):(Ns)));
prefix2_len = length(s2((2*Ns-n_minus+1):(2*Ns)));
prefix3_len = length(s3((3*Ns-n_minus+1):(3*Ns)));

s1 = s1(prefix1_len+1:end);
s2 = s2(prefix2_len+1:end);
s3 = s3(prefix3_len+1:end);

S1_freq = fft(s1);
S2_freq = fft(s2);
S3_freq = fft(s3);

%isolate left side of each fft (do we need to round)
% get rid of the zero entry, no bits were put there
S1_freq_left = S1_freq(2:(length(S1_freq)/2));
S2_freq_left = S2_freq(2:(length(S2_freq)/2));
S3_freq_left = S3_freq(2:(length(S3_freq)/2));

% learn batch, bits one with random phases, directly getting the freq
% response - do once just for the bits from the learning batch

% divide the output by the input to get mag of freq reponse

learn_symb = s(2*Ns+1:2*Ns+1+(Ns/2)); % freq domain - check this
learn_sym_mag = abs(learn_symb); % get rid of phases (should divide by 1)

% mag of yc, complex num got out of the fft, compare


%A is power 0.25
power = 0.25;

%compare fft left to power*fft of impulse response*.5
compare_metric_s1 = 0.5*power*learn_sym_mag; % this is a vector

length(compare_metric_s1)
length(S1_freq_left)

%loop through to compare elementwise?
bhat1 = zeros(Ns,1);
for i=1:length(S1_freq_left)
    if abs(S1_freq_left(i)) > compare_metric_s1(i)
        bhat1(i) = 1;
    end
end



end