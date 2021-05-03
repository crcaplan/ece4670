% testing script

%input = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]';
%input = [1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1]';
input = [0 1 1 0 0 1 1 0 0 1 1 0 0 1 1 0 0 1 1 0 0 1 1 0]';
%input = [1 1 1 1 0 1 1 0 0 1 1 0 0 1 1 0 0 1 1 0 0 1 1 0]';

%input = [0 0 0 0]';
x=enc(input);
y=lab3_channel(x);
output=dec(y)

% is inconsistent
% consistently wrong?



% %%
% 
% input = [1 1 1 1]';
% x=enc_pam_all(input);
% y=lab3_channel(x);
% output=dec_pam_all(y);
% 
% 
% 
% %%
% 
% input = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]';
% x=enc_pam_firstone(input);
% y=lab3_channel(x);
% output=dec_pam_firstone(y);