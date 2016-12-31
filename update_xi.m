%--------------------------- Input ----------------------------------------
% W       A matrix of size n_1 * n_2, where n_1 is the number of nodes in
%         the upper layer, and n_2 is the number of nodes in the lower
%         layer.
% mu      A column vector of length n_1.
% h       A column vector of length n_2.
%--------------------------- Output ---------------------------------------
% xi      A column vector of length n_2.

function xi = update_xi(W, mu, h)
Input_1 = num2cell(W, 1);

Input_2 = repmat(mu, 1, size(W,2));
Input_2 = num2cell(Input_2, 1);

Input_3 = num2cell(h');

xi = cellfun(@optimize_xi_one_component, Input_1, Input_2, Input_3);
xi = xi';
end