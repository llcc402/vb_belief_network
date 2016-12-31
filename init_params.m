%% Input:
%     n_1, n_2, n_3    Scalars. The number of nodes in each layer, from top
%                      to bottom.
%% Output:
%     W_1, W_2         Matrices. W_1 is with size n_1 * n_2, and W_2 is
%                      with size n_2 * n_3.
%     h_1, h_2         Column vectors. h_1 is with size n_2, and h_2 is
%                      with size n_3.
function [W_1, W_2, h_1, h_2] = init_params(n_1, n_2, n_3)
W_1 = randn(n_1, n_2);
W_2 = randn(n_2, n_3);
h_1 = randn(n_2, 1);
h_2 = randn(n_3, 1);