%------------------------ Input:-------------------------------------------
%     W_1, W_2   Matrices. W1 is of size n_1 * n_2, W_2 is of size n_2 *
%                n_3.
%     s          A column vector of length n_3.
%     h_1        A column vector of length n_2.
%     h_2        A column vector of length n_3.
%     xi_3       A column vector of length n_3.
%-------------------------- Output:----------------------------------------
%     mu_2       A column vector of length n_2.
function mu_2 = update_mu_2(W_1, W_2, s, mu_1, mu_2, h_1, h_2, xi_3)
% get phi
phi = get_phi(W_2, mu_2, h_2, xi_3);

% init grad
grad = zeros(length(mu_2), 1);

for l = 1:length(mu_2)
    grad(l) = W_2(l,:) * (s - xi_3) + sum(W_1(:,l) .* mu_1) + h_1(l);
    stp_1 = (exp(-xi_3 .* W_2(l,:)') - 1) ./ (1 - mu_2(l) + mu_2(l) * exp(-xi_3 .* W_2(l,:)'));
    grad(l) = grad(l) - sum(stp_1 .* (1-phi));
    stp_2 = (exp((1-xi_3) .* W_2(l,:)') - 1) ./ (1 - mu_2(l) + mu_2(l) * exp((1-xi_3) .* W_2(l,:)'));
    grad(l) = grad(l) - sum(stp_2 .* phi);
    
    mu_2(l) = 1 / (1 + exp(-grad(l)));
end


