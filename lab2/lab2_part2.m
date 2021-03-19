% 2 Quantization

fs=96000; %samples per second
N=96000;
x=zeros(5*N,1); % 5 seconds of zeros

audiowrite('silence8.wav', x, fs, 'BitsPerSample', 8);
audiowrite('silence16.wav', x, fs, 'BitsPerSample', 16);
audiowrite('silence24.wav', x, fs, 'BitsPerSample', 24);



%%

[y0_8,fs0_8]=audioread('out0_silence8.wav');
[y1_8,fs1_8]=audioread('out1_silence8.wav');
[y0_16,fs0_16]=audioread('out0_silence16.wav');
[y1_16,fs1_16]=audioread('out1_silence16.wav');
[y0_24,fs0_24]=audioread('out0_silence24.wav');
[y1_24,fs1_24]=audioread('out1_silence24.wav');

y0_8_pos = y0_8(y0_8>0);
y1_8_pos = y1_8(y1_8>0);
y0_16_pos = y0_16(y0_16>0);
y1_16_pos = y1_16(y1_16>0);
y0_24_pos = y0_24(y0_24>0);
y1_24_pos = y1_24(y1_24>0);


y0_8_min = min(y0_8_pos);
y1_8_min = min(y1_8_pos);
y0_16_min = min(y0_16_pos);
y1_16_min = min(y1_16_pos);
y0_24_min = min(y0_24_pos);
y1_24_min = min(y1_24_pos);


% look for function to return second smallest, or sort

y0_8_sort = sort(y0_8_pos);
y0_16_sort = sort(y0_16_pos);
y0_24_sort = sort(y0_24_pos);

y1_8_sort = sort(y1_8_pos);
y1_16_sort = sort(y1_16_pos);
y1_24_sort = sort(y1_24_pos);

