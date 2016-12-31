%----------------------- Input -------------------------------------------- 
%    W_1        A matrix of size n_1 * n_2.
%    mu_1       A column vector of length n_1.
%    mu_2       A column vector of length n_2.
%    xi_2       A column vector of length n_2.
%    h_1        A column vector of length n_2.
%------------------------Output--------------------------------------------
%    grad_W_1   A matrix of size n_1 * n_2.
function grad_W_1 = get_grad_W(W_1, mu_1, mu_2, xi_2, h_1)
grad_W_1 = zeros(size(W_1));

% update grad_W_1 by row
for k = 1:size(grad_W_1, 1)
    grad_W_1(k,:) = mu_1(k) * (mu_2 - xi_2)'; % row vector
    phi = get_phi(W_1, mu_1, h_1, xi_2); % column vector
    
    stp = mu_1(k) * exp(-W_1(k,:)' .* xi_2) .*  xi_2 ...
        ./ (1 - mu_1(k) + mu_1(k) * exp(-W_1(k,:)' .* xi_2)); % column vector
    grad_W_1(k,:) = grad_W_1(k,:) + ((1-phi) .* stp)';
    
    stp = mu_1(k) * exp(W_1(k,:)' .* (1-xi_2)) .* (1 - xi_2) ...
        ./ (1 - mu_1(k) + mu_1(k) * exp(W_1(k,:)' .* (1-xi_2)));
    grad_W_1(k,:) = grad_W_1(k,:) - (phi .* stp)';
end