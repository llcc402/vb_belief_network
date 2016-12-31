function x = post_draw(mu_1, W_1, W_2, h_1, h_2)

% the middle layer
x = W_1' * mu_1 + h_1;
x = 1 ./ (1 + exp(-x));

% the bottom layer
x = W_2' * x + h_2;
x = 1 ./ (1 + exp(-x));
% r = rand(length(h_2), 1);
% x(x > r) = 1;
% x(x ~= 1) = 0;

% draw x
img = zeros(8,1);
for i = 1:8
	img(:,i) = x((i-1) * 8 + 1 : (i-1) * 8 + 8);
end

imshow(img)