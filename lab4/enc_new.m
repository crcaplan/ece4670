function enc_new(b, num_bits, bits_per_batch, batches_per_sym, n_plus)

%set 3/4 info bits
num_info_per_batch = 0.75*bits_per_batch;
num_zeros_per_batch = 0.25*bits_per_batch;

% get the total number of OFDM symbols
num_syms = ceil(num_bits/(num_info_per_batch*batches_per_sym));

% set a bit counter
bits_counter = 0;

% create the vector that is to be transmitted
full_vec_to_transmit = ones(1000,1);

% for each symbol
for i = 1:num_syms
    
    if(i ~= num_syms)
    
        % for each OFDM symbol create a vector of zeros
        batch0 = zeros(bits_per_batch,1);

        % create vector of ones and send through to_cont to convert to symbols
        % then convert to the time domain
        batch_learn = ones(bits_per_batch,1);
        X_learn = to_cont(batch_learn);
        X_time_learn = ifft(X_learn);

        % create the OFDM symbol
        OFDM_sym = [batch0 ; X_time_learn];  % does this reset??????

        % for each batch
        for j = 1:batches_per_sym

            % extract bits in a batch and convert to symbols
            % should be vector of real values in the time domain
            info_batch = b(bits_counter + 1:bits_counter + num_info_per_batch);
            batch = [info_batch; zeros(num_zeros_per_batch,1)];
            Xs_batch = to_cont(batch);
            Xtime_batch = ifft(Xs_batch);

            % add to the OFDM symbol - first need to add prefix
            batch_prefix = Xtime_batch((bits_per_batch - n_plus + 1):bits_per_batch); % added the plus 1

            % concatenate prefix and batch to the OFDM_sym
            OFDM_sym = [OFDM_sym ; batch_prefix ; Xtime_batch];

            % increment the bits counter
            bits_counter = bits_counter + num_info_per_batch;

        end

    
    else
        %do all of the ofdm stuff but only on remaining bits, fill the rest
        %with zeros in the last batch
        
        % for each OFDM symbol create a vector of zeros
        batch0 = zeros(bits_per_batch,1);

        % create vector of ones and send through to_cont to convert to symbols
        % then convert to the time domain
        batch_learn = ones(bits_per_batch,1);
        X_learn = to_cont(batch_learn);
        X_time_learn = ifft(X_learn);

        % create the OFDM symbol
        OFDM_sym = [batch0 ; X_time_learn];  % does this reset??????

        % for each batch
        for j = 1:batches_per_sym
            if((bits_counter+num_info_per_batch)<num_bits)
                disp(j)
                disp('can fill a whole info section')
                % extract bits in a batch and convert to symbols
                % should be vector of real values in the time domain
                info_batch = b(bits_counter + 1:bits_counter + num_info_per_batch);
                batch = [info_batch; zeros(num_zeros_per_batch,1)];
                bits_counter = bits_counter + num_info_per_batch;
            elseif((num_bits-bits_counter)<num_info_per_batch && (num_bits-bits_counter)~=0)
                disp(j)
                disp('can fill a partial info section')
                %can fill partial info section
                remaining_info = num_bits - bits_counter;
                disp(remaining_info)
                info_batch = b(bits_counter + 1:bits_counter + remaining_info);
                batch = [info_batch; zeros((bits_per_batch-remaining_info),1)];
                bits_counter = bits_counter + remaining_info;
                disp(bits_counter)
            else
                disp(j)
                disp('filling batch w zeros')
                %needs to be filled with all zeros
                batch = zeros(bits_per_batch,1);
            end
            
            Xs_batch = to_cont(batch);
            Xtime_batch = ifft(Xs_batch);
            
            % add to the OFDM symbol - first need to add prefix
            batch_prefix = Xtime_batch((bits_per_batch - n_plus + 1):bits_per_batch); % added the plus 1

            % concatenate prefix and batch to the OFDM_sym
            OFDM_sym = [OFDM_sym ; batch_prefix ; Xtime_batch];

        end
        
    end
    
    % add symbol to the full vector that is to be transmitted
    full_vec_to_transmit = [full_vec_to_transmit ; OFDM_sym];

end

%generate wav file
audiowrite(strcat('tx.wav'), full_vec_to_transmit, 44100, 'BitsPerSample', 24);

length(full_vec_to_transmit)

end


% helper function for the above code
function Xs = to_cont(b)

% input: vector of bits
% output: complex-valued vector of symbols

% initialize the Xs vector
b_len = length(b);
Xs_left = zeros(b_len+1, 1);

% initialize the power and random phase
pow = 0.75;
rng(5);
theta = 2*pi*(rand(b_len,1));

% loop through the bits and assign corresponding symbol value
for i = 1:b_len
    if b(i) == 1
       % start at i+1 because the left-most value must be zero
       % magnitude is the power and the phase is the random phase
       Xs_left(i+1) = pow*exp(sqrt(-1)*theta(i));   
    end
end

% flip the left half and take the complex conjugate and concatenate
Xs_right = flip(conj(Xs_left(2:end)));
Xs = [Xs_left ; Xs_right];

% always should be an odd number
%disp(length(Xs));

end