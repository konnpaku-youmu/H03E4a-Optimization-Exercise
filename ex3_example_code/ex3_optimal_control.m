U0 = zeros(120, 1);

[xopt,x_iters,f_iters] = minimize_bfgs(@(x)astro_objective(x), U0);

state = Integrate_controls(xopt);

pos_x = state(1:4:end);
pos_y = state(3:4:end);

figure();
subplot(3, 1, 1);
plot(pos_x, pos_y);
title('Position');
subplot(3, 1, 2);
plot(state(2:4:end));
hold on
plot(state(4:4:end));
title('Velocity');
subplot(3, 1, 3);
plot(xopt(1:60));
hold on
plot(xopt(61:end));
title('Control');
