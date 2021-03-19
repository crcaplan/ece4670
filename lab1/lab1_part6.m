%5 inputs
[y0,fs0]=audioread('out0_sync.wav');
[y1,fs1]=audioread('out1_sync.wav');

%y0 zero count
count0_zeros = 0;
for i = 1:length(y0)
    if (y0(i)<0.0005)
        count0_zeros = count0_zeros + 1;
    end
end
audio0 = count0_zeros/20

%y1 zero count
count1_zeros = 0;
for i = 1:length(y1)
    if (y1(i)<0.0005)
        count1_zeros = count1_zeros + 1;
    end
end
audio1 = count1_zeros/20