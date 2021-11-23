function [J,X] = pendulum(x0,u)

% computes the cost J and trajectory x_k over the horizon length(u) 
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
xk1=x0(1);
xk2=x0(2);

for k=1:N
    
    % compute x_{k+1}
    z1=h*xk2;
    z2=sin(xk1);
    z3=-gh*z2;
    z4=-ch*xk2;
    z5=h*u(k);
    z6=z3+z4;
    z7=z5+z6;
    xk1=xk1+z1;
    xk2=xk2+z7;

    % compute cost of this step
    z8=xk1^2;
    z9=xk2^2;
    z10=10*z8;
    z11=10*z9;
    z12=u(k)^2;
    Jstep=z10+z11;
    Jstep=Jstep+z12;
   
    % add to J
    J=J+Jstep;
    
    % store trajectory (not needed for computation of J)
    X(k,1)=xk1;
    X(k,2)=xk2;
end

    
    
    
