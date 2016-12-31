%------------------- Input ------------------------------------------------
% ww    A column vector of length n_1.
% mu    A column vector of length n_1.
% hh    A scalar.
%------------------- Output -----------------------------------------------
% xi_k  A scalar.

function xi_k = optimize_xi_one_component(ww, mu, hh)

stp_1_1 = @(x) - x * hh;
stp_2_1 = @(x) (1 - x) * hh;

stp_1_2 = @(x) 1 - mu + mu .* exp(-x * ww);
stp_2_2 = @(x) 1 - mu + mu .* exp((1-x) * ww);

f = @(x) (stp_1_1(x) + sum(log(stp_1_2(x))))...
    + log(1 + exp(stp_2_1(x)) / exp(stp_1_1(x)) * prod(stp_2_2(x) ./ stp_1_2(x)));

xi_k = fminbnd(f, 0, 1);
end

