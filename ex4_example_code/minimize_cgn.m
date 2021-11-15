function [x, x_iters, f_iters] = minimize_cgn( Ffun, hfun, x0 )

% convergence tolerance
grad_tol = 1e-4;
max_iters = 600;

% make sure x0 is a column vector
[~,cols] = size(x0);
if cols ~= 1
    error('x0 needs to be a column vector');
end

% make sure Ffun returns a column vector
F0 = Ffun(x0);
[~,cols] = size(F0);
if cols ~= 1
    error('Ffun needs to return a column vector');
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
lambda = 0*h0;
for k=1:max_iters
    % check for divergence
    if max(abs(x)) > 1e6
        error('minimize_gn has diverged, max(abs(x)): %.3g',max(abs(x)))
    end
    
    % evaluate F and it's jacobian J
    [F, J] = finite_difference_jacob(Ffun, x);

    % evaluate h and it's jacobian J_h
    [h, J_h] = finite_difference_jacob(hfun, x);

    %%%%%%%%%%%%%%%%%%%% FILL THIS PART IN %%%%%%%%%%%%%%%%%%%%%%%%
    % store x in the iteration log
    norm_grad_L = norm([J'*F + J_h'*lambda; h], inf); % ?
    x_iters(:,k) = x;
    f_iters(k) = norm_grad_L;
    
    fprintf('iteration: %4d,   norm_grad_L: %.4g\n',k, norm_grad_L);

    % check for convergence
    if norm_grad_L < grad_tol
        x_iters = x_iters(:,1:k);
        f_iters = f_iters(:,1:k);
        return
    end    
    
    % find the search direction
    % ?
    % ?
    % ?
    % ?
    % ?
    A = [J' * J, J_h'; J_h, 0];
    b = [-J' * F; -h];
    
    x_lambda = A \ b;
    
    dk = x_lambda(1:length(x)); % ?
    lambda = x_lambda(length(x)+1:end); % ?

    % gradient of the objective f (f = 1/2 F'*F)
    f_grad = J' * F; % ?
    
    % take the line search
    sigma = 0.01;
    beta = 0.6;
    c = 100;
    x = line_search(@(y)(merit_fun(Ffun,hfun,c,y)), x, f_grad'*dk-c*norm(h,1), dk, sigma, beta);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end

error('minimize_cgn: max iterations exceeded')

end


function ret = merit_fun(Ffun, hfun, c, x)

F = Ffun(x);
h = hfun(x);

%%%%%%%%%%%%%%%%%%% FILL THIS IN %%%%%%%%%%%%%%%%
ret = (F'*F)/2 + c * norm(h, 1); % ?
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
