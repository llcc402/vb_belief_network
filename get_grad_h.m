%------------------------- Input ------------------------------------------
% W_1        A matrix of size n_1 * n_2, where n_1 and n_2 denote the
%            number of nodes in the upper and the bottom layer.
% mu_2       A column vector of length n_2.
% mu_1       A column vector of length n_1.
% xi_2       A column vector of length n_2.
% h_1        A column vector of length n_2.
%------------------------- Output -----------------------------------------
% grad_h_1   A column vector of length n_2.

function grad_h_1 = get_grad_h(W_1, mu_1, mu_2, xi_2, h_1)

phi = get_phi(W_1, mu_1, h_1, xi_2); % column vector
grad_h_1 = mu_2 - phi;

