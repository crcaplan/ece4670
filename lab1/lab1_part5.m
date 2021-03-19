%4 outputs
[y0,fs0]=audioread('out0_noise.wav');
[y1,fs1]=audioread('out1_noise.wav');


%y0 power calc
y0power = (1/length(y0))*sum(y0.^2)

%y1 power calc
y1power = (1/length(y1))*sum(y1.^2)



%take DFTs
Z0 = abs(fft(y0));
Z1 = abs(fft(y1));

%plot 500Hz-20kHz
figure;
%code from lab report
N = 44100;
Ts = 1/N;
kvalues=[-N/2+1:N/2];
omegavalues=kvalues*2*pi/(N*Ts);
%plot(omegavalues,something);
semilogy(omegavalues(500:end),Z0(500:end));
xlabel('Frequency');
ylabel('Log Amplitude');
title('Audio 0 Noise DFT from 500Hz-20kHz');

figure;
semilogy(omegavalues(500:end),Z1(500:end));
xlabel('Frequency');
ylabel('Log Amplitude');
title('Audio 1 Noise DFT from 500Hz-20kHz');

%plot 1Hz-500Hz
figure;
semilogy(omegavalues(1:500),Z0(1:500));
xlabel('Frequency');
ylabel('Log Amplitude');
title('Audio 0 Noise DFT from 1Hz-500Hz');

figure;
semilogy(omegavalues(1:500),Z1(1:500));
xlabel('Frequency');
ylabel('Log Amplitude');
title('Audio 1 Noise DFT from 1Hz-500Hz');

