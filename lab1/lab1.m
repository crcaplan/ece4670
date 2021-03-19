N=44100; %duration measured in samples
fs=44100; %samples per second
xoneperiod=zeros(N,1);
xoneperiod(end)=1;
x=[xoneperiod ; xoneperiod ; xoneperiod ; xoneperiod ; xoneperiod];
audiowrite('impulses.wav', x, fs, 'BitsPerSample', 16);


