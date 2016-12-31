%---------------------- Input ---------------------------------------------
% data:     A matrix of m * n_3, where rows correspond to observations and
%           columns correspond to features.
% maxIter:  A scalar.
% n_1:      A scalar. The number of the top layer nodes.
% n_2:      A scalar. The number of the middle layer nodes.
%---------------------- Output --------------------------------------------
% W_1:      A matrix of size n_1 * n_2, where n_1 is the number of top 
%           layer nodes, and n_2 is the number of the middle layer nodes.
% W_2:      A matrix of size n_2 * n_3.
% h_1:      A column vector of length n_2. It corresponds to the biases of
%           the middle layer.
% h_2:      A column vector of length n_3. It corresponds to the biases of
%           the bottom layer.

function [W_1, W_2, h_1, h_2, mu_1_mat, mu_2_mat] = vb_belief_net(data, maxIter, n_1, n_2, step_size)
%------------------------------ init --------------------------------------
[m, n_3] = size(data);
W_1 = randn(n_1, n_2);
W_2 = randn(n_2, n_3);
h_1 = randn(n_2, 1);
h_2 = randn(n_3, 1);
loss = zeros(maxIter, 1);

mu_1_mat = rand(n_1, m);
mu_2_mat = rand(n_2, m);
xi_1_mat = rand(n_2, m);
xi_2_mat = rand(n_3, m);

epsilon = 1e-5;
LOOP_NUM = 100;

%------------------------------ main loops --------------------------------
for iter = 1:maxIter
    tic
    % update parameters for every observation
    for i = 1:m
        % update mu_2 and mu_1
        difference = 1000;
        s_2 = 0;
        loop = 0;
        while difference > epsilon && loop < LOOP_NUM
            mu_2_mat(:,i) = update_mu_2(W_1, W_2, data(i,:)', mu_1_mat(:,i), mu_2_mat(:,i), h_1, h_2, xi_2_mat(:,i));
            mu_1_mat(:,i) = update_mu_1(W_1, mu_1_mat(:,i), mu_2_mat(:,i), xi_1_mat(:,i), h_1);
        
            % update xi_2 and xi_1
            xi_2_mat(:,i) = update_xi(W_2, mu_2_mat(:,i), h_2);
            xi_1_mat(:,i) = update_xi(W_1, mu_1_mat(:,i), h_1);

            s_1 = sum(mu_1_mat(:,i) .^ 2);
            difference = s_2 - s_1;
            s_2 = s_1;
            loop = loop + 1;
        end
        
        % update W_2 and W_1
        grad_W_2 = get_grad_W(W_2, mu_2_mat(:,i), data(i,:)', xi_2_mat(:,i), h_2);
        W_2 = W_2 + step_size * grad_W_2;
        grad_W_1 = get_grad_W(W_1, mu_1_mat(:,i), mu_2_mat(:,i), xi_1_mat(:,i), h_1);
        W_1 = W_1 + step_size * grad_W_1;
        
        % update h_2 and h_1
        grad_h_2 = get_grad_h(W_2, mu_2_mat(:,i), data(i,:)', xi_2_mat(:,i), h_2);
        h_2 = h_2 + step_size * grad_h_2;
        grad_h_1 = get_grad_h(W_1, mu_1_mat(:,i), mu_2_mat(:,i), xi_1_mat(:,i), h_1);
        h_1 = h_1 + step_size * grad_h_1;
%         fprintf(['data ', num2str(i), ' done\n'])
    end
    X = W_1' * mu_1_mat + repmat(h_1, 1, m);
    X = 1 ./ (1 + exp(-X));
    X = W_2' * X + repmat(h_2, 1, m);
    X = 1 ./ (1 + exp(-X));
    loss(iter) = sum(sum((data - X') .^ 2));
%     fprintf(['iteration ', num2str(iter), ' done\n'])
    toc
end
plot(loss)

