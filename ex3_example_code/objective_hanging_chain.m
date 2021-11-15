function V = objective_hanging_chain( xy )
%objective_hanging_chain: Potential energy of unconstrained hanging chain

% break design variables into [x, y] vectors
x = xy(1:2:end);
y = xy(2:2:end);
assert(length(x) == length(y))

% some constants
N = length(x);
m = 40/N;
D = 70*N;
g = 9.81;
L = 1;

x = [-2; x; 2];
y = [1; y; 1];

%%%%%%%%%%%%%%%%%%%%% COMPUTE THE OBJECTIVE HERE %%%%%%%%%%%%%%%%%%%%%%%%%%
V = 0;

for i = 1:N+1
    V = V + (sqrt((x(i)-x(i+1))^2 + (y(i)-y(i+1))^2) - L/N)^2;
end

V = (1/2) * D * V + m * g * sum(y);

% error('compute hanging chain objective here');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end