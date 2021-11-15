% Least square fitting

a = linspace(0,1,50)';
b = 4 * a - 1;

b = b + randn(50, 1);
A = [a ones(50, 1)];

coeffs = (A'*A)\(A'*b);

plot(a, b)
hold on
plot(a, coeffs(1) * a + coeffs(2))
hold on

% Chebychev approx
A_bar = [a, ones(50, 1), -ones(50, 1) ; -a, -ones(50, 1), -ones(50, 1)];
b_bar = [b, -b];
f = [0, 0, 1];

res = linprog(f, A_bar, b_bar);
plot(a, res(1) * a - res(2));
hold on

% L1 approx
A_bar_0 = [a, ones(50, 1), -eye(50,50) ; -a, -ones(50, 1), -eye(50,50)];
f_0 = [0, 0, ones(1, 50)];
res_0 = linprog(f_0, A_bar_0, b_bar);

plot(a, res_0(1) * a - res_0(2));
hold on
