function enc(b)

Ns = 2*length(b) + 1;
n_minus = 0;
n_plus = 150; % or 175

% convert inputted bits to symbols
Xs = to_cont(b);

% convert "test batch" of ones to symbols
Xlearn = to_cont(ones(length(b),1));

% take iDFT of the symbols - get a vector of real values in the time domain
Xtime = ifft(Xs); % fft of batch before prefix on batch

if any(Xtime ~= real(Xtime))
    disp('bad news, buddy - Xtime');
end

batch_learn = ifft(Xlearn);

if any(batch_learn ~= real(batch_learn))
    disp('bad news, buddy - Xlearn');
end

% create a batch of zeros so know where signal starts
batch0 = zeros(Ns,1);

% determine the number of batches/wav files generated
num_batches = 3;
batch_size = 1000;
num_iterations = ceil(length(b)/(num_batches*batch_size));

for k = 0: num_iterations - 1
    
    %disp(k)
    
    start = batch_size*k;
    
    batch1 = [Xtime((start + batch_size-n_plus+1):(start + batch_size)); Xtime(start + 1 : start + batch_size)];
    batch2 = [Xtime((2*(start+batch_size)-n_plus+1):(2*(start+batch_size))); Xtime(start+ batch_size+1:(2*(start+batch_size)))];
    batch3 = [Xtime((3*(start+batch_size)-n_plus+1):(3*(start+batch_size))); Xtime(2*(start+batch_size)+1:(3*(start+batch_size)))];
    full_batch = [batch0; batch_learn; batch1; batch2; batch3];
    
    % add zeros to end of the last one
    if k == num_iterations
        
        % find num of leftover bits that cannot fit in a full batch
        remainder = rem(length(b),num_batches);
        
        % check if those bits can fill a mini batch
        if (remainder ~= 0 && rem(remainder, batch_size) == 0)
            
            % fill in the remaining mini batches with these bits
            num_data_batches = remainder/batch_size;
            full_batch = [batch0; batch_learn];
            for i = 1:num_batches
                if (i <= num_data_batches)
                    full_batch = [full_batch ; [Xtime((i*(start+batch_size)-n_plus+1):(i*(start+batch_size))) ; Xtime(start+ batch_size+1:(2*(start+batch_size)))]];
                else
                    full_batch = [full_batch ; zeros(1000,1)];
                end
            end
        
        % check if those bits cannot fill a mini batch
        % elseif remainder ~= 0 && rem(remainder, batch_size) ~= 0
        end
    end
    
%generate wav file

name = strcat('tx', int2str(k));

audiowrite(strcat(name, '.wav'), full_batch, 44100, 'BitsPerSample', 24);

end

end

% helper function for the above code
function Xs = to_cont(b)

% input: vector of bits
% output: complex-valued vector of symbols

% initialize the Xs vector
b_len = length(b);
Xs_left = zeros(b_len+1, 1);

% initialize the power and random phase
pow = 0.5;
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