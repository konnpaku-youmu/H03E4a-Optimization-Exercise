function [x, x_iters, f_iters] = minimize_grad_desc( fun, x0, alpha )

% convergence tolerance
grad_tol = 1e-4;
max_iters = 10000;

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
        error('minimize_grad_desc has diverged, max(abs(x)): %.3g',max(abs(x)))
    end
    
    % evaluate the local gradient
    [~, J] = finite_difference_jacob(fun, x);
    
    % check for convergence
    if norm(J,inf) < grad_tol
        x_iters = x_iters(:,1:k);
        f_iters = f_iters(:,1:k);
        return
    end
    
    % take the gradient descent step
    %%%%%%%%%%%%%%%%% FILL THIS PART IN %%%%%%%%%%%%%%%%%%%%%%%
    % search direction
    dk = J'; % fill this in
    
    % step
    x = x - alpha * dk; % fill this in 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

error('minimize_grad_desc: max iterations exceeded')

end
