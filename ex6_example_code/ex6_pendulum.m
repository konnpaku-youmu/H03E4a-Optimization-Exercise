close all;
clear;

% supply inputs
x0 = [pi/2;0];
u = zeros(50,1);

% compute derivative to u_0;
du = zeros(50,1); du(1)=1;
[J, dJ, X] = pendulum_forward(x0,u,du); 

% compare with finite-differences
J0 = J;
Jdu = pendulum_forward(x0,u+1e-4*du,du);
dJfindif = (Jdu-J0)/1e-4;
display([dJ, dJfindif]);

% COMPLETE HERE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% plot solution
subplot(2,1,1);
plot(X(:,1))
xlabel('k')
ylabel('x_k');
subplot(2,1,2);
plot(u)
xlabel('k+1');
ylabel('u_k');
