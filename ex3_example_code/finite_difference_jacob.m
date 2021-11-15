function [f0, J] = finite_difference_jacob( fun, x0 )
% make sure x0 is a column vector
[Nx,cols] = size(x0);
if cols ~= 1
    error('x0 needs to be a column vector');
end

% make sure fun returns a column vector
f0 = fun(x0);
[Nf,cols] = size(f0);
if cols ~= 1
    error('fun needs to return a column vector');
end

% initialize empty J
J = zeros(Nf, Nx);

% perform the finite difference jacobian evaluation
h = 1e-8;
for k = 1:Nx
    %%%%%%%%%%%%%  FILL THIS IN %%%%%%%%%%%%%
    x0_diff = x0;
    x0_diff(k) = x0_diff(k) + h;
    df = (fun(x0_diff) - fun(x0)) / h;
    J(:,k) = df;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
