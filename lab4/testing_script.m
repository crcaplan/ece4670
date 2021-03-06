% testing script for lab 4

num_bits = 200000;
bits_per_batch = 1000;
batches_per_sym = 5;
n_plus = 175; % or 175

rng(42);
b = double(rand(num_bits,1) > 0.5);
enc(b);

disp('here');

%%

bhat = dec();

wrong_count = 0;

for k = 1:num_bits
    if b(k) ~= bhat(k)
        wrong_count = wrong_count + 1;
    end
end

disp('wrong_count = ');
disp(wrong_count);