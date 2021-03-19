%3.4 multiple frequency components, frequency gain

%3.4 outputs
%[y0,fs0]=audioread('out0_multi.wav');
[y1,fs1]=audioread('out1_multi.wav');


%plot to clip sounds
% fig0all=figure;
% plot(y0);
% title('Audio 0 Frequency Response');


fig1all=figure;
plot(y1);
title('Audio 1 Frequency Response');


%find ffts
% Z0 = abs(fft(y0));
Z1 = abs(fft(y1));

%frequency vector
freq = (500:1:20000);


%gain plot audio0
% figure;
% plot(freq,Z0);
% xlabel('Frequency');
% ylabel('Gain');
% title('Audio 0 Frequency Response Gain');

%gain plot audio1
figure;
plot(Z1);
xlabel('Frequency');
ylabel('Gain');
title('Audio 1 Frequency Response');

f = [500 ; 1000; 2000 ; 4000; 5000 ; 6000 ; 7000 ; 8000 ; 9000 ; 10000 ; 11000 ; 12000 ; 13000 ; 14000 ; 15000 ; 16000 ; 17000 ; 18000 ; 19000 ; 20000];
gain = [];
count = 1;
for i = 1:length(f)
    gain(count) = Z1(f(i));
    count = count + 1;
end



figure;
plot(f,gain)
xlabel('Frequency')
ylabel('Gain')
title('Audio 1 Frequency Response Gain')



f1 = [5000 ; 5100 ; 5200 ; 5300 ; 5400 ; 5500 ; 5600 ; 5700 ; 5800 ; 5900 ; 6000 ; 6100 ; 6200 ; 6300 ; 6400 ; 6500 ; 6700 ; 6800 ; 6900 ; 7000];
gain1 = [];
count = 1;
for i = 1:length(f1)
    gain1(count) = Z1(f1(i));
    count = count + 1;
end

figure;
plot(f1,gain1);
xlabel('Frequency');
ylabel('Gain');
title('Audio 1 Zoomed-In Gain');

