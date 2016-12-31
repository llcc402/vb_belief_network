% init 
W_1 = randn(2,4);
W_2 = randn(4,6);
h_1 = randn(4,1);
h_2 = randn(6,1);

s = [0; 0; 1; 0; 0; 1];

%----------------------------------------------------------------------------------------
%                                   empirical test 
%----------------------------------------------------------------------------------------
% number of instances
NUM = 10000000;

mu_1_mat = rand(2, NUM);
mu_1_mat(mu_1_mat > 0.5) = 1;
mu_1_mat(mu_1_mat <= 0.5) = 0;

% generate mu_2_mat
mu_2_mat = W_1' * mu_1_mat + repmat(h_1, 1, NUM);

% transform to probabilies
mu_2_mat = 1 ./ (1 + exp(-mu_2_mat));

% sample mu_2_mat
R = rand(4, NUM);
mu_2_mat(mu_2_mat > R) = 1;
mu_2_mat(mu_2_mat ~= 1) = 0;

% generate mu_3_mat
mu_3_mat = W_2' * mu_2_mat + repmat(h_2, 1, NUM);
mu_3_mat = 1 ./ (1 + exp(-mu_3_mat));

% sample mu_3_mat
R = rand(6, NUM);
mu_3_mat(mu_3_mat > R) = 1;
mu_3_mat(mu_3_mat ~= 1) = 0;

% effective_sample_num
effective_sample_num = 0;
mu_1_vec = zeros(2,1);
mu_2_vec = zeros(4,1);
for i = 1:NUM
	if mu_3_mat(:,i) == s
		effective_sample_num = effective_sample_num + 1;
		mu_1_vec = mu_1_vec + mu_1_mat(:,i); 
		mu_2_vec = mu_2_vec + mu_2_mat(:,i); 
	end
end

mu_1_vec = mu_1_vec / effective_sample_num;
mu_2_vec = mu_2_vec / effective_sample_num;
fprintf('-----------------------------------------------------------\n')
fprintf(['effective sample number is ', num2str(effective_sample_num), '\n'])
fprintf('empirical mu_1 is ')
mu_1_vec
fprintf('\n')
fprintf('empirical test done \n')
fprintf('-----------------------------------------------------------\n')
%-----------------------------------------------------------------------------------
%                           variational inference
%-----------------------------------------------------------------------------------
mu_1 = predict(s, W_1, W_2, h_1, h_2);
fprintf('variational mu_1 is ')
mu_1
fprintf('\n')
fprintf('-----------------------------------------------------------\n')




