%3.1 outputs
[y0,fs0]=audioread('out_audio0.wav');
[y1,fs1]=audioread('out_audio1.wav');

fig0all=figure;
plot(y0);

indices0=find(y0==max(y0));
y0nearpeak=y0(indices0(1)-50:indices0(1)+200);
fig0nearpeak=figure;
plot(y0nearpeak);
xlabel('Sample Number 1');
ylabel('Amplitude');
title('Audio 0 Impulse Response');
print(fig0nearpeak,'-dpdf','ECE4670Lab1Audio0.pdf');

y0nearpeak2=y0(indices0-50+44100:indices0+200+44100);
fig0nearpeak2=figure;
plot(y0nearpeak2);
xlabel('Sample Number 2');
ylabel('Amplitude');
title('Audio 0 Impulse Response');

y0nearpeak3=y0(indices0-50+2*44100:indices0+200+2*44100);
fig0nearpeak3=figure;
plot(y0nearpeak3);
xlabel('Sample Number 3');
title('Audio 0 Impulse Response');


fig1all=figure;
plot(y1);

indices1=find(y1==max(y1));
y1nearpeak=y1(indices1(1)-50:indices1(1)+200);
fig1nearpeak=figure;
plot(y1nearpeak);
xlabel('Sample Number 1');
ylabel('Amplitude');
title('Audio 1 Impulse Response');
print(fig1nearpeak,'-dpdf','ECE4670Lab1Audio1.pdf');

y1nearpeak2=y1(indices1-50+44100:indices1+200+44100);
fig1nearpeak2=figure;
plot(y1nearpeak2);
xlabel('Sample Number 2');
ylabel('Amplitude');
title('Audio 1 Impulse Response');

y1nearpeak3=y1(indices1-50+2*44100:indices1+200+2*44100);
fig1nearpeak3=figure;
plot(y1nearpeak3);
xlabel('Sample Number 3');
ylabel('Amplitude');
title('Audio 1 Impulse Response');

%saved audio0 and audio1 impulses from 3.1
ysaved0 = y0nearpeak;
ysaved1 = y1nearpeak;


%part 3.6 dft of impulse response
pad = zeros(10000,1);
ysaved0 = [pad ; ysaved0 ; pad];
ysaved1 = [pad ; ysaved1 ; pad];
Z0 = abs(fft(ysaved0));
Z1 = abs(fft(ysaved1));


gain0 = [];
count0 = 1;
for i = 500:100:20000
    gain0(count0) = Z0(i);
    count0 = count0 + 1;
end

gain1 = [];
count1 = 1;
for i = 500:100:20000
    gain1(count1) = Z1(i);
    count1 = count1 + 1;
end

fr = [500:100:20000];

figure;
plot(fr,gain0)
xlabel('Frequency')
ylabel('Gain')
title('Audio 0 Frequency Response Gain')

figure;
plot(fr,gain1)
xlabel('Frequency')
ylabel('Gain')
title('Audio 1 Frequency Response Gain')





