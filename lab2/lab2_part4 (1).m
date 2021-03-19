% DAC Pulse Shape

% send through audio0 only

N=8000; %duration measured in samples
fs=8000; %samples per second
xoneperiod=zeros(N,1);
xoneperiod(end)=1;
xsilence = zeros(N,1);
x = [xoneperiod ; xsilence];

audiowrite('impulse8.wav', x, fs, 'BitsPerSample', 16);

%%

[y8_imp, fs8_imp] = audioread('out0_impulse8.wav');

%%

indices0=find(y8_imp==max(y8_imp));
y0nearpeak=y8_imp(indices0(1)-300:indices0(1)+200);
fig0nearpeak=figure;
plot(y0nearpeak);
xlabel('Sample Number');
ylabel('Amplitude');
title('Audio 0 Impulse Response - 192kHz sampling rate');

%%

Z1 = abs(fft(y8_imp));
n = length(Z1);
Ts = 1/8000;
kvalues=[-n/2+1:n/2];
omegavalues=kvalues.*(2*pi/(n*Ts));
fvalues = omegavalues/(2*pi);
plot(fvalues, Z1);
xlabel('Frequency (Hz');
ylabel('Amplitude');
title('Audio 0 Frequency Response - 8kHz sampling rate');
