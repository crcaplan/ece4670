function bhat = dec_new(num_bits, bits_per_batch, batches_per_sym, n_plus)

%read in wav file
[s_received,~]=audioread('rx.wav');

%set 3/4 of a batch to be info bits
num_info_per_batch = 0.75*bits_per_batch;
num_zeros_per_batch = 0.25*bits_per_batch;

% find starting point for information, encoded as series of ones
first_point = find_first_symbol(s_received);

% cut off initial channel noise from start of received signal
s_received = s_received(first_point + 1000 : end);

% calculate constants
num_syms = ceil(num_bits/(num_info_per_batch*batches_per_sym));
prefix_len = n_plus;
cont_per_batch = bits_per_batch*2 + 1;
symbol_len = cont_per_batch*batches_per_sym + prefix_len*batches_per_sym + cont_per_batch + bits_per_batch ;  % not includes the zeros or the ones
   
% set a bit counter
bits_counter = 0;

% create the output bits vector and a counter to keep track
bhat = zeros(num_bits, 1);
bhat_count = 1;

for i = 1:num_syms
    
    % first need to grab an OFDM symbol
    OFDM_symbol = s_received(bits_counter + 1: bits_counter + symbol_len);
        
    % first get rid of the zeros and ones vectors that were added
    % extract the learn bits and get fft and isolate left half of fft
    % without the zero bit in the front
    s_short = OFDM_symbol(bits_per_batch + cont_per_batch +1:end);
   
    s_learn = OFDM_symbol(cont_per_batch+1:2*cont_per_batch);
    S_learn = fft(s_learn);
    S_learn_left = S_learn(2:((length(S_learn) - 1)/2)+1);  % check this
    S_learn_mag = abs(S_learn_left);
    
    % counter of bits within the symbol
    counter = 0;
    
    % for each batch in a symbol
    for j = 1:batches_per_sym
        
        % extract a batch and strip off the prefix
        batch_with_prefix = s_short(counter+1:counter + prefix_len + cont_per_batch);
        batch_without_prefix = batch_with_prefix(prefix_len + 1:prefix_len + cont_per_batch);
         
        % increment the counter of bits within the symbol
        counter = counter + prefix_len + cont_per_batch;
         
        % convert batch to the frequency domain
        S_batch = fft(batch_without_prefix);
        S_batch_left = S_batch(2:((length(S_batch) - 1)/2)+1);
        
        % extract information bits in the first part of the batch, get rid
        % of the extra zeros
        S_batch_left_info = S_batch_left(1:num_info_per_batch);
         
        power = 0.75;
        % compare S_batch_left to power*fft of impulse response*.5
        compare_metric = 0.5*power*S_learn_mag; 
         
        % loop through the batch and decode to bhat based on comparison
        % metric
         for k = 1:length(S_batch_left_info)
            if(bhat_count<=num_bits)
                if (abs(S_batch_left_info(k)) > compare_metric(k))
                    bhat(bhat_count) = 1;
                end
                bhat_count = bhat_count + 1;
            end
         end
    end   
    
    % increment the symbol bits counter 
    bits_counter = bits_counter + symbol_len; 
    
end 
end

% helper function for finding index of start of information
function first_point = find_first_symbol(s_received)

% define counter and averaging constants
sample_count = 0;
window_len = 1;
thresh = 0.0001;
found = 0;

while(found == 0)
    
    % calculate average power over window
    power = sum((s_received(sample_count+1:sample_count+window_len)).^2)/(window_len);
    sample_count = sample_count + 1;
    
    % check power against threshold value
    if power > thresh
        found = 1;
        first_point = sample_count + window_len;
    end 
end
end
