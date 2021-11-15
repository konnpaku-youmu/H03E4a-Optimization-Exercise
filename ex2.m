N_p = 20;
D = 70 * N_p;
g = 9.81;
m = 40 / N_p;

% find the Hessian
H = zeros(2*N_p, 2*N_p);
block = [1 -1 ; -1 1];
for i = 1:N_p - 1
    H(i:i+1, i:i+1) = H(i:i+1, i:i+1) + block;
end

H(N_p + 1:2 * N_p, N_p + 1:2 * N_p) = H(1:N_p, 1:N_p);
H = D * H;

% find the f
f = zeros(1, 2 * N_p);
f(N_p + 1:2 * N_p) = m * g;

% add constraints: hanging points
lb = -Inf(1, 2 * N_p);
ub = Inf(1, 2 * N_p);

lb(1) = -2;
ub(1) = -2;
lb(N_p) = 2;
ub(N_p) = 2;
lb(N_p + 1) = 1;
ub(N_p + 1) = 1;
lb(2 * N_p) = 1;
ub(2 * N_p) = 1;

x0 = ones(1, 2 * N_p);
x0(1:20) = linspace(-2+0.1, 2-0.1, N_p);

% add constraints: ground
A = zeros(N_p, 2 * N_p);
A(1:N_p, N_p + 1:2 * N_p) = -eye(N_p);
b = -0.5 * ones(1, N_p);

% traj = quadprog(H, f, A, b, [], [], lb, ub);
% plot(traj(1:N_p), traj(N_p + 1:2 * N_p));

% non-linear hanging chain
options = optimoptions('fmincon', 'Display','iter');
options.MaxFunctionEvaluations = 5000;

f = @sum_pot_nonlin;
traj_nonlin = fmincon(f, x0);
plot(traj_nonlin(1:N_p), traj_nonlin(N_p + 1:2 * N_p));
