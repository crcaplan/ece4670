%3.1 inputs
N=44100; %duration measured in samples
fs=44100; %samples per second
xoneperiod=zeros(N,1);
xoneperiod(end)=1;
x=[xoneperiod ; xoneperiod ; xoneperiod ; xoneperiod ; xoneperiod];
audiowrite('impulses.wav', x, fs, 'BitsPerSample', 16);

%3.2 inputs
fs=44100; %samples per second
n = linspace(0,50000,50001);
x = cos(2*pi*4410*n*(1/fs));
audiowrite('sinusoid.wav', x, fs, 'BitsPerSample', 16);




%3.4 multiple frequency components, frequency gain inputs
%only put in 3 or 4 frequencies for superposition
%should see 6 peaks in fft
x= 0;
n = linspace(0,19500,19501);
f = [500 ; 1000; 2000 ; 3000 ; 4000; 5000 ; 6000 ; 7000 ; 8000 ; 9000 ; 10000 ; 11000 ; 12000 ; 13000 ; 14000 ; 15000 ; 16000 ; 17000 ; 18000 ; 19000 ; 20000];
for i=1:length(f)
   sig = cos(2*pi*f(i).*n*(1/fs));
   x = x + sig;
    
end
xmax = max(x);
x = x./xmax;
%fix dividing by max of sig to get rid of clip input data error
audiowrite('multi_sinusoid.wav', x, fs, 'BitsPerSample', 16);


%4 inputs
fs=44100; %samples per second
N=44100;
x=zeros(5*N,1);
audiowrite('noise.wav', x, fs, 'BitsPerSample', 24);


%5 inputs
f1= 44100;
zero_gap = zeros(882000,1);
x = [1 ; zero_gap ; 1];
audiowrite('sampling_sync.wav', x, fs, 'BitsPerSample', 16);


