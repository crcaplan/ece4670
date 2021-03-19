% 3 Anti-Aliasing Filter

% send through audio0 only

f = 10000;
falias = 2000;
%fs8=8000; %samples per second
fs192=192000; %samples per second
n = linspace(0,1000000,1000001);
%x8 = cos(2*pi*f*n*(1/fs8));
x192 = cos(2*pi*f*n*(1/fs192));
%xalias = cos(2*pi*falias*n*(1/fs8));


%audiowrite('sinusoid.wav', x8, fs8, 'BitsPerSample', 16);
audiowrite('sinusoid.wav', x192, fs192, 'BitsPerSample', 16);

%audiowrite('sinusoid_alias.wav', xalias, fs8, 'BitsPerSample', 16);

%%

%[y8, fs8_out] = audioread('out0_sinusoid8.wav');
[y2, fs2] = audioread('out0_sinusoid2.wav');
%[yalias, fsalias_out] = audioread('out0_sinusoid_alias.wav');

% control in python ccplay, there is another argument, primer has arg
% --rate


%%

Z1 = abs(fft(y192));
n = length(Z1);
Ts = 1/8000;
kvalues=[-n/2+1:n/2];
omegavalues=kvalues.*(2*pi/(n*Ts));
fvalues = omegavalues/(2*pi);
plot(fvalues, Z1);

% plot(y192);
%plot(yalias);

% convert to freq domain, then find amp