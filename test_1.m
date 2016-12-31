clear
clc

s = [0 0 1 0 0 1; 1 0 0 1 0 0; 0 1 0 0 1 1];

[W_1, W_2, h_1, h_2, mu_1_mat, mu_2_mat] = vb_belief_net(s, 3000, 6, 6, 1);

mu_1_1 = predict(s(1,:)', W_1, W_2, h_1, h_2);
x_1 = post_draw(mu_1_1, W_1, W_2, h_1, h_2);
x_1'

mu_1_2 = predict(s(2,:)', W_1, W_2, h_1, h_2);
x_2 = post_draw(mu_1_2, W_1, W_2, h_1, h_2);
x_2'

mu_1_3 = predict(s(3,:)', W_1, W_2, h_1, h_2);
x_3 = post_draw(mu_1_3, W_1, W_2, h_1, h_2);
x_3'


