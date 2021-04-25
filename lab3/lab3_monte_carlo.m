seed=134982840; %seed for random number generator
rng(seed); %set the seed for the random number generator, both rand and randn

L=24; %length of bit string, both input and output
tot=100; %total iterations
p=0.5; %probability that the bit to be transmitted is a 1 bit

R=zeros(tot, 1);
N=zeros(tot, 1);
P=zeros(tot, 1);

%tot=1

%%fprintf(1,'tot %d:');

for i=1:tot
%%  fprintf(1,' %d',i);
%%  if mod(i,20)==0
%%    fprintf(1,'\n');
%%  end

  data=double(rand(L,1)>=(1-p)); %bit string to be transmitted

%  fig_data=figure;
%  stem(data);
%  ylabel('input bits');

  in_chan=enc(data); %symbols to be transmitted

%  fig_symbolsin=figure;
%  stem(1:500,in_chan(1:500));
%  ylabel('input symbols');

  out_chan=lab3_channel(in_chan); %corrupted symbols from the channel

%  fig_symbolsout=figure;
%  stem(1:500,out_chan(1:500));
%  ylabel('output symbols');

  dec_data=dec(out_chan); %decoded bit string

%  fig_estimates=figure;
%  stem(dec_data);
%  ylabel('estimated bits');

  R(i)=L/length(in_chan); %data rate, the higher the better
  N(i)=sum(data~=dec_data); %number of bit errors, the lower the better
  P(i)=1/length(in_chan) * sum(in_chan.^2); %average power

end
%%fprintf(1,'\n');

R_avg=sum(R)/tot;
N_avg=sum(N)/tot;
P_avg=sum(P)/tot;

M=(min(R_avg, L) * (1 - N_avg/L)^6)/ max(1,4*P_avg);

fprintf('average data rate is %f\n', R_avg)
fprintf('average number of incorrect bits is %f\n', N_avg)
fprintf('average power is %f\n', P_avg)
fprintf('average performance is %f\n', M)
