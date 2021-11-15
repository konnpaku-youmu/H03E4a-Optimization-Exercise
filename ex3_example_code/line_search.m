function x_ret = line_search( fun, x0, J, dk, sigma, beta )
% Line search using Armijo conditions and backtracking
% fun - scalar function
% x0 - initial guess
% J - jacobian of fun at x0
% dk - search direction
% sigma - armijo condition scaling function
% beta - backtracking parameter

% make sure sigma and beta are in reasonable range
if sigma <= 0 || 1 <= sigma
    error('sigma must be in (0,1)')
end

if beta <= 0 || 1 <= beta
    error('beta must be in (0,1)')
end

too_many_steps_counter = 10000;

% initialize t, evaluate function
f0 = fun(x0);

%%%%%%%%%%%%%%%%%%%%% FILL IN THE LINE SEARCH HERE %%%%%%%%%%%%%%%%%%%%
alpha = 1;   % fill me in
while (fun(x0 + alpha * dk) - f0 > (sigma * alpha * J * dk))   % fill me in
    alpha = beta * alpha; % fill me in

    % if the line search takes too many iterations, throw an error
    too_many_steps_counter = too_many_steps_counter - 1;
    if too_many_steps_counter == 0
        error('line search fail - took too many iterations')
    end
end

x_ret = x0 + alpha * dk;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end