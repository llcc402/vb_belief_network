%----------------------- Input ----------------------------------
% W_1      A matrix of size n_1 * n_2.
% W_2      A matrix of size n_2 * n_3, where n_3 is the dimension of the observations.
% h_1      A column vector of length n_2. It is the middle layer biases.
% h_2      A column vector of length n_3. It is the bottom layer biases.
%----------------------- Output ---------------------------------
% mu_1     A column vector of length n_1. It deontes the probabilities of the classes.

function mu_1 = predict(data, W_1, W_2, h_1, h_2)

% init
[n_1, n_2] = size(W_1);
n_3 = length(h_2);
mu_1 = rand(n_1,1);
mu_2 = rand(n_2,1);
mu_1 = mu_1 / sum(mu_1);
mu_2 = mu_2 / sum(mu_2);
xi_1 = rand(n_2);
xi_2 = rand(n_3);
xi_1 = xi_1 / sum(xi_1);
xi_2 = xi_2 / sum(xi_2);
epsilon = 1e-5;
s = 10000;
s_2 = 0;
iter = 1;

% main loops
while s > epsilon && iter <= 100
    mu_2 = update_mu_2(W_1, W_2, data, mu_1, mu_2, h_1, h_2,xi_2);
    mu_1 = update_mu_1(W_1, mu_1, mu_2, xi_1, h_1);
    xi_2 = update_xi(W_2, mu_2, h_2);
    xi_1 = update_xi(W_1, mu_1, h_1);
    s_1 = sum(mu_1 .^ 2);
    s = s_1 - s_2;
    s_2 = s_1;
    iter = iter + 1;
end



