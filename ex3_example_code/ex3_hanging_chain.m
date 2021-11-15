function ex3_hanging_chain

clc
clear all
close all

% simple hanging chain
N = 40;

% initial conditions
x0 = linspace(-2+0.2, 2-0.2, N);
% error('set initial condition here')
y0 = ones(1, N);
% error('set initial condition here')
assert(all(size(x0)==[1,N]), 'x0 must be size 1 x N')
assert(all(size(y0)==[1,N]), 'x0 must be size 1 x N')
% mix x and y to be [x_0, y_0, x_1, y_1, ...]
xy0 = [x0; y0];
xy0 = xy0(:);

% solve with fmincon
opt = fminunc(@(x)(objective_hanging_chain(x)), xy0, optimset('LargeScale','off'));

% plot fmincon solution
figure()
subplot(211)
xopt = opt(1:2:end);
yopt = opt(2:2:end);
plot(xopt,yopt,'b')
hold on
plot(xopt,yopt,'b.')
legend('fmincon solution','')

% solve with my bfgs solver
[opt,~,f_iters] = minimize_bfgs(@(x)(objective_hanging_chain(x)), xy0);

% plot my bfgs solver solution
xopt2 = opt(1:2:end);
yopt2 = opt(2:2:end);
plot(xopt2,yopt2,'r-.')
plot(xopt2,yopt2,'ro')
legend('fmincon solution','','bfgs solution','')
subplot(212)
semilogy(f_iters,'.')
legend('function value')
grid on

end
