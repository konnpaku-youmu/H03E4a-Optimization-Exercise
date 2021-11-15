function [x, x_iters, f_iters] = minimize_bfgs( fun, x0 )

% convergence tolerance
grad_tol = 1e-4;
max_iters = 10000;

if length(fun(x0)) ~= 1
    error('the function must return a scalar')
end

% a log of the iterations
x_iters = zeros(length(x0), max_iters);
f_iters = zeros(1,max_iters);

x = x0;

% initialize B
B = eye(length(x0));

% evaluate the initial gradient
[~, J] = finite_difference_jacob(fun, x);

for k=1:max_iters
    % store x in the iteration log
    x_iters(:,k) = x;
    f_iters(k) = fun(x);
    
    % check for divergence
    if max(abs(x)) > 1e6
        error('minimize_bfgs has diverged, max(abs(x)): %.3g',max(abs(x)))
    end
    
    % check for convergence
    if norm(J,inf) < grad_tol
        x_iters = x_iters(:,1:k);
        f_iters = f_iters(:,1:k);
        return
    end
    fprintf('iteration: %4d,   residual: %.4g\n',k,norm(J,inf));


    %%%%%%%%%%%%%%%%%%%%%%%% FILL THIS PART IN %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % find the search direction
    dk = B \ (-J'); % set dk here
    
    % take the line search
    gamma = 0.01;
    beta = 0.6;
    x_old = x;
    x = line_search(@(x)fun(x), x, J, dk, gamma, beta);
    
    % update BFGS hessian approximation
    J_old = J;
    [~, J] = finite_difference_jacob(fun, x);
    
    y_k = J' - J_old';
    s_k = x - x_old;
    
    B = B + (y_k * y_k')/(y_k' * s_k) - ((B * s_k) * s_k' * B)/(s_k' * B * s_k); % update B here
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

error('minimize_bfgs: max iterations exceeded')

end
