function [x, x_iters, f_iters] = minimize_line_search( fun, x0 )

% convergence tolerance
grad_tol = 1e-4;
max_iters = 50000;

if length(fun(x0)) ~= 1
    error('the function must return a scalar')
end

x = x0;

% a log of the iterations
x_iters = zeros(length(x0), max_iters);
f_iters = zeros(1,max_iters);

for k=1:max_iters
    % store x in the iteration log
    x_iters(:,k) = x;
    f_iters(k) = fun(x);
    
    % check for divergence
    if max(abs(x)) > 1e6
        error('minimize_line_search has diverged, max(abs(x)): %.3g',max(abs(x)))
    end
    
    % evaluate the local gradient
    [~, J] = finite_difference_jacob(fun, x);
    
    % check for convergence
    if norm(J,inf) < grad_tol
        x_iters = x_iters(:,1:k);
        f_iters = f_iters(:,1:k);
        return
    end

    %%%%%%%%%%%%%%%%%%%%%%%%% COMPLETE THIS PART %%%%%%%%%%%%%%%%%%%%%%%%%%
    % find the search direction
    dk = -J'; % set dk here
    
    % take the line search
    sigma = 0.01;
    beta = 0.6;
    x = line_search(@(x)fun(x), x, J, dk, sigma, beta);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

error('minimize_line_search: max iterations exceeded')

end
