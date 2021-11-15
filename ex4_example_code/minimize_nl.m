function [x, x_iters, f_iters] = minimize_nl( ffun, hfun, x0 )

% convergence tolerance
grad_tol = 1e-4;
max_iters = 1000;

% make sure x0 is a column vector
[~,cols] = size(x0);
if cols ~= 1
    error('x0 needs to be a column vector');
end

% make sure ffun returns a scalar
f0 = ffun(x0);
if length(f0) ~= 1
    error('ffun must return a scalar')
end

% make sure hfun returns a column vector
h0 = hfun(x0);
[~,cols] = size(h0);
if cols ~= 1
    error('hfun needs to return a column vector');
end


% a log of the iterations
x_iters = zeros(length(x0), max_iters);
f_iters = zeros(1,max_iters);

x = x0;
lambda = zeros(length(h0), 1);

% initialize B
B = eye(length(x0));

% evaluate the initial f and its jacobian J
[~, J] = finite_difference_jacob(ffun, x);

% evaluate the initial h and its jacobian J_h
[h, J_h] = finite_difference_jacob(hfun, x);


for k=1:max_iters
    % check for divergence
    if max(abs(x)) > 1e6
        error('minimize_nl has diverged, max(abs(x)): %.3g',max(abs(x)))
    end
    
    % store x in the iteration log
    norm_grad_L = norm([J' + J_h'*lambda; h], inf);
    x_iters(:,k) = x;
    f_iters(k) = norm_grad_L;
    
    fprintf('iteration: %4d,   norm_grad_L: %.4g\n',k, norm_grad_L);

    % check for convergence
    if norm_grad_L < grad_tol
        x_iters = x_iters(:,1:k);
        f_iters = f_iters(:,1:k);
        return
    end
    
    x_old = x;
    
    %%%%%%%%%%%%%%%%%%%% FILL THIS PART IN %%%%%%%%%%%%%%%%%%%%%%%%
    % find the search direction
    % ?
    % ?
    % ?
    % ?
    
    A = [B, J_h' ; J_h, 0];
    b = [-J'; -h];
    
    x_lambda = A \ b;
    
    dk = x_lambda(1:length(x)); % ?
    lambda_hat = x_lambda(length(x)+1:end); % ?

    % take the line search
    sigma = 0.01;
    beta = 0.6;
    c = 100;
    [x, alpha] = line_search(@(y)(merit_fun(ffun,hfun,c,y)), x, J*dk - c*norm(h,1), dk, sigma, beta);
    lambda = lambda_hat;

    % update BFGS hessian approximation
    J_old = J;
    J_h_old = J_h;
    
    % evaluate F and it's jacobian J
    [~, J] = finite_difference_jacob(ffun, x);

    % evaluate h and it's jacobian J_h
    [h, J_h] = finite_difference_jacob(hfun, x);
    
    Lx_old = J_old' + J_h_old' * lambda; % ?
    Lx     = J' + J_h' * lambda; % ?
    
    s = x - x_old;
    y = Lx - Lx_old;
    
    B = B + (y * y') / (y' * s) - ((B * s) * s' * B) / (s' * B * s); % ?
    B = (B + B') / 2; % Symmetrize Hessian, only needed due to numerical inaccuracy, so that quadprog doesn't complain
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

error('minimize_nl: max iterations exceeded')

end


function ret = merit_fun(ffun, hfun, c, x)
    f = ffun(x);
    h = hfun(x);
    ret = f + c*norm(h,1);
end
