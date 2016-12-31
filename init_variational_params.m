%% Input:
%     n_1, n_2, n_3    Scalars. The number of nodes in each layer, from top
%                      to bottom.
%% Output:
%     mu, xi           Matrices. mu is with size n_1 * n_2. amd xi is with 
%                      size n_2 * n_3.              
function [mu, xi] = init_variational_params(n_1, n_2, n_3)
mu = randn(n_1, n_2);
xi = randn(n_2, n_3);