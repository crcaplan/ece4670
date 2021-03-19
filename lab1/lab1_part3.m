%3.3 outputs
[y0,fs0]=audioread('out0_sinusoid.wav');
[y1,fs1]=audioread('out1_sinusoid.wav');
n = linspace(0,50000,50001);

fig0all=figure;
%plot(y0);
%y0sample=y0(4000:4050);
%plot(n(4000:4050),y0sample);
title('Audio 0 Frequency Response');


fig1all=figure;
%plot(y1);
y1sample=y1(20000:20050);
plot(n(20000:20050),y1sample);
title('Audio 1 Frequency Response');


%y1 clipped
y0clip=y0(7790:49141);
y1clip=y1(7770:58400);

%take fft of clip
Z1 = fft(y1clip);
Z0 = fft(y0clip);

figure;
plot(abs(Z1));
title('Audio 1 FFT');
xlabel('Frequency');
ylabel('Amplitude');

figure;
plot(abs(Z0));
title('Audio 0 FFT');
xlabel('Frequency');
ylabel('Amplitude');

figure;
plot(abs(Z1(500:8000)));
title('Audio 1 FFT (500Hz-8kHz)');
xlabel('Frequency');
ylabel('Amplitude');

figure;
plot(abs(Z0(500:8000)));
title('Audio 0 FFT (500Hz-8kHz)');
xlabel('Frequency');
ylabel('Amplitude');




