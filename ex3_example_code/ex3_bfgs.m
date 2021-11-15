clear all
close all
clf

disp('minimizing using BFGS with line search')

%%%%%%%%%%%% minimze x^2 + y^2 %%%%%%%%%%%%
% first let's plot the function:
figure(1)
subplot(211)
[X,Y] = meshgrid(-2:0.01:2, -2:0.01:2);
contour(X, Y, objective_toy(X, Y),20)

% now we solve
x0 = [1;1];
[xopt,x_iters,f_iters] = minimize_bfgs(@(x)objective_toy(x(1), x(2)), x0);
fprintf('toy problem took %d iterations, solution: (%.3g, %.3g)\n', size(x_iters,2), xopt)

% plot the iterations in the solution
hold on
plot(x_iters(1,:), x_iters(2,:),'r.')
plot(x_iters(1,:), x_iters(2,:),'r')
subplot(212)
semilogy(f_iters,'.')
legend('function value')
grid on

%%%%%%%%%%%%% minimize (1-x)^2 + 100*(y - x^2)^2 %%%%%%%%%%%%%%
% first let's plot the function:
figure(2)
subplot(211)
[X,Y] = meshgrid(-2:0.01:2, -1.5:0.01:3);
contour(X, Y, objective_rosenbrock(X, Y),40)

% solve
x0 = [-1.5;1];
[xopt,x_iters,f_iters] = minimize_bfgs(@(x)objective_rosenbrock(x(1), x(2)), x0);
fprintf('rosenbrock took %d iterations, solution: (%.3g, %.3g)\n', size(x_iters,2), xopt)

% plot the iterations in the solution
hold on
plot(x_iters(1,:), x_iters(2,:),'r.')
plot(x_iters(1,:), x_iters(2,:),'r')
subplot(212)
semilogy(f_iters,'.')
legend('function value')
grid on
