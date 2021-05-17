%read in 3 wav files
[s1,fs1]=audioread('rx1.wav');
[s2,fs2]=audioread('rx2.wav');
[s3,fs3]=audioread('rx3.wav');

%ffts of received signals
%indices of prefix
Ns = 200000;
n_minus = 0;

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
S1_freq_left = S1_freq(1:(length(S1_freq)/2));
S2_freq_left = S2_freq(1:(length(S2_freq)/2));
S3_freq_left = S3_freq(1:(length(S3_freq)/2));



%impulse response batch 1
indices1=find(s1==max(s1));
h1=s1(indices1(1)-50:indices1(1)+200);

%impulse response batch 2
indices2=find(s2==max(s2);
h2=s2(indices2(1)-50:indices2(1)+200);

%impulse response batch 3
indices3=find(s3==max(s3));
h3=s3(indices3(1)-50:indices3(1)+200);

%ffts of impulse responses
H1_freq = fft(h1);
H2_freq = fft(h2);
H3_freq = fft(h3);

%A is power 0.25
power = 0.25;

%compare fft left to power*fft of impulse response*.5
compare_metric_s1 = 0.5*power*H1_freq;
compare_metric_s2 = 0.5*power*H2_freq;
compare_metric_s3 = 0.5*power*H3_freq;

%loop through to compare elementwise?
bhat1 = zeros(Ns,1);
for i=1:length(S1_freq_left)
    if S1_freq_left(i) > compare_metric_s1(i)
        bhat1(i) = 1;
    end
end

bhat2 = zeros(Ns,1);
for i=1:length(S2_freq_left)
    if S2_freq_left(i) > compare_metric_s2(i)
        bhat2(i) = 1;
    end
end

bhat3 = zeros(Ns,1);
for i=1:length(S3_freq_left)
    if S3_freq_left(i) > compare_metric_s3(i)
        bhat3(i) = 1;
    end
end
