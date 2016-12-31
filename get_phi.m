%-------------------- Input: ----------------------------------------------
%     W      A matrix of size m * n, where m is the number of nodes in the 
%            upper layer, and n is the number of nodes in the lower layer.
%     mu     A column vector of size m * 1, where n is the number o nodes
%            in the upper layer. 
%     h      A column vector of size n * 1, where n is the number of nodes
%            in the lower layer.
%     xi     A column vector of size n * 1, where n is the number of nodes
%            in the lower layer.
%--------------------Output: ----------------------------------------------
%     phi    A vector of size n * 1.
function phi = get_phi(W, mu, h, xi)
phi = zeros(length(h), 1);
for j = 1:length(h)
    stp_1 = zeros(1 + size(W,1),1);
    stp_2 = zeros(1 + size(W,1),1);
    stp_1(1) = exp(-xi(j) * h(j));
    stp_2(1) = exp((1-xi(j)) * h(j));
    stp_1(2:end) = 1 - mu + mu .* exp(-xi(j) * W(:,j));
    stp_2(2:end) = 1 - mu + mu .* exp((1-xi(j)) * W(:,j));
    
    phi(j) = 1 / (1 + prod(stp_1 ./ stp_2));
end
end


