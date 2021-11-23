close all;
clear;

load('nls_data.mat');

x0 = ones(6,1);

options = optimoptions('fminunc', 'GradObj', 'off', 'Algorithm', 'quasi-newton');
[xstar1,fval1,exitflag1,output1] = fminunc(@(x) nls(x, ys, ts), x0, options);
[t_fit1, y_fit1] = decay_oscillation(xstar1, 0, 20, 100, 0, 0);
subplot(2,1,1);
plot(ts, ys, '.'); hold on
plot(t_fit1, y_fit1, 'ob');
legend('data points', 'finite differences');

options = optimoptions('fminunc', 'GradObj', 'on', 'Algorithm', 'quasi-newton');
[xstar2,fval2,exitflag2,output2] = fminunc(@(x) nls_backward(x, ys, ts), x0, options);
[t_fit2, y_fit2] = decay_oscillation(xstar2, 0, 20, 100, 0, 0);
subplot(2,1,2);
plot(ts, ys, '.'); hold on
plot(t_fit2, y_fit2, 'xr');
legend('data points', 'backward AD');

