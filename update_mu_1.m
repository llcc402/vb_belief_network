%--------------------------- Input: ---------------------------------------
%    W_1      A matrix of size n_1 * n_2.
%    mu_2     A column vector of length n_2.
%    xi_2     A column vector of length n_2.
%    h_1      A column vector of length n_2.
%--------------------------- Output: --------------------------------------
%    mu_1     A column vector of length n_1.

function mu_1 = update_mu_1(W_1, mu_1, mu_2, xi_2, h_1)

% get phi
phi = get_phi(W_1, mu_1, h_1, xi_2);

% init grad
grad = zeros(length(mu_1), 1);

for l = 1:length(mu_1)
    grad(l) = W_1(l,:) * (mu_2 - xi_2);
    stp = (exp(-W_1(l,:)' .* xi_2) - 1) ./ (1 - mu_1(l) + mu_1(l) * exp(-W_1(l,:)' .* xi_2));
    grad(l) = grad(l) - sum((1- phi) .* stp);
    stp = (exp(W_1(l,:)' .* (1-xi_2)) - 1) ./ (1 - mu_1(l) + mu_1(l) * exp(W_1(l,:)' .* (1-xi_2)));
    grad(l) = grad(l) - sum(phi .* stp);
    
    % update mu_1
    mu_1(l) = 1 ./ (1+ exp(-grad(l)));
    
    % update phi
    phi = get_phi(W_1, mu_1, h_1, xi_2);
end


end
    