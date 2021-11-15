clc
clear all
close all

% simple hanging chain
N = 40;

% initial conditions
y0 = []; error('set initial condition here')

% solve with fmincon
opt = fminunc(@(x)(objective_hanging_chain_x_constant(x)), y0, optimset('LargeScale','off'));
% add y_1 = y_N = 1
xopt = linspace(-2,2,N+2);
yopt = [1;opt;1]         ;

% plot fmincon solution
figure()
subplot(211)
plot(xopt,yopt,'b')
hold on
plot(xopt,yopt,'b.')
legend('fmincon solution','')

% solve with my bfgs solver
[opt2,~,f_iters] = minimize_bfgs(@(x)(objective_hanging_chain_x_constant(x)), y0);
% add y_1 = y_N = 1
yopt2 = [1;opt2;1];

% plot my bfgs solver solution
plot(xopt,yopt2,'r-.')
plot(xopt,yopt2,'ro')
legend('fmincon solution','','bfgs solution','')
subplot(212)
semilogy(f_iters,'.')
legend('function value')
grid on