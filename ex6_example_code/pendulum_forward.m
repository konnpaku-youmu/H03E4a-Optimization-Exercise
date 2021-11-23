function [J,dJ,X] = pendulum_forward(x0,u,du)

% pendulum_forward(x0,u,du)  computes the cost J and trajectory x_k over the horizon length(u) 
% for a trajectory initialised at x0 with input u=[u_0;...;u_{n-1}] for the damped nonlinear pendulum
% where Q=[10 0;0 10], F=[1 0;0 1], R=1;

% system parameters
h=.2; c=2; g=9.81;
gh=g*h;
ch=c*h;

N=length(u);
X=zeros(N,2); % to store matrix with elements x^k_i=X(k,i), i=1,2;

% Compute trajectory and cost function;
J=0;
dJ=0;
xk1=x0(1);
dxk1=0;
xk2=x0(2);
dxk2=0;

for k=1:N
    
    % COMPLETE HERE %%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
    % store trajectory (not needed for computation of J)
    X(k,1)=xk1;
    X(k,2)=xk2;
end

% add terminal cost

