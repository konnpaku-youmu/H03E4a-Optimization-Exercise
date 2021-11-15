function [x, x_iters, grad_iters] = minimize_gn( Ffun, x0 )

% convergence tolerance
grad_tol = 1e-4;
max_iters = 500;

% make sure x0 is a column vector
[~,cols] = size(x0);
if cols ~= 1
    error('x0 needs to be a column vector');
end

% make sure fun returns a column vector
f0 = Ffun(x0);
[~,cols] = size(f0);
if cols ~= 1
    error('fun needs to return a column vector');
end

% a log of the iterations
x_iters = zeros(length(x0), max_iters);
grad_iters = zeros(1,max_iters);

x = x0;
for k=1:max_iters
    % check for divergence
    if max(abs(x)) > 1e6
        error('minimize_gn has diverged, max(abs(x)): %.3g',max(abs(x)))
    end
    
    % evaluate F and it's jacobian J
    [F, J] = finite_difference_jacob(Ffun, x);

    % convergence criteria
    norm_grad = norm(J'*F, inf);

    % store x in the iteration log
    x_iters(:,k) = x;
    grad_iters(k) = norm_grad;
    
    fprintf('iteration: %4d,   norm(J''*F,inf): %.4g\n',k, norm_grad);

    % check for convergence
    if norm_grad < grad_tol
        x_iters = x_iters(:,1:k);
        grad_iters = grad_iters(:,1:k);
        return
    end
    
    %%%%%%%%%%%%%%%%%%%% FILL THIS PART IN %%%%%%%%%%%%%%%%%%%%
    % find the search direction
    dk = -(J' * J) \ (J' * F); % ?
    
    % gradient of the objective f ( where f = 1/2 F'*F)
    f_grad = J' * J; % ?
     
    % take the line search
    sigma = 0.01;
    beta = 0.6;
    x = line_search(@(y)(ffun(Ffun,y)), x, f_grad * dk, dk, sigma, beta);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end

error('minimize_gn: max iterations exceeded')

end

function f = ffun(Ffun,x)

F = Ffun(x);
f = 0.5*(F'*F);

end