function [x, x_iters, f_iters] = minimize_sqp( ffun, hfun, gfun, x0, callback )

    % convergence tolerance
    grad_tol = 1e-4;
    feasible_tol = 1e-4;
    max_iters = 1000;
    
    % qp options
    % qpopts = optimset('Display','off','algorithm','active-set');
    qpopts = optimset('Display','off','algorithm','interior-point-convex');    
    qp_status = 999;
    
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
    
    % make sure gfun returns a column vector
    g0 = gfun(x0);
    [~,cols] = size(g0);
    if cols ~= 1
        error('gfun needs to return a column vector');
    end
    
    
    % a log of the iterations
    x_iters = zeros(length(x0), max_iters);
    f_iters = zeros(1,max_iters);
    
    % initial variables
    x      = x0;
    lambda = 0 * h0;
    mu     = 0 * g0;
    
    % set these so the first printout doesn't fail
    s     = 0 * x0;
    alpha = 0;
    
    % initialize B
    B = eye(length(x0));
    
    % evaluate the initial f and it's jacobian J
    [~, J] = finite_difference_jacob(ffun, x);
    
    % evaluate the initial h and it's jacobian J_h
    [h, J_h] = finite_difference_jacob(hfun, x);
    
    % evaluate the initial g and it's jacobian J_g
    [g, J_g] = finite_difference_jacob(gfun, x);
    
    
    for k=1:max_iters
        % check for divergence
        if max(abs(x)) > 1e6
            error('minimize_sqp has diverged, max(abs(x)): %.3g',max(abs(x)))
        end
        
        % check for bad BFGS update
        if any(any(isnan(B)))
            error('BFGS has NaNs in it, step size is probably very small')
        end
        
        % store x in the iteration log
        norm_grad_L = norm(J' + J_h'*lambda + J_g'*mu, inf);
        feasible = norm( [h; max(g,0*g)], inf);
    
        x_iters(:,k) = x;
        f_iters(k) = norm_grad_L;
        
        if mod(k,10) == 1
            fprintf('\niter qpstatus |grad_L| |feasible|  |step|     t\n')
        end
        fprintf('%4d %6d   %.2e  %.2e  %.2e %.2e\n',k, qp_status, norm_grad_L, feasible, norm(s,inf), alpha);
        if nargin > 4
            callback(x)
        end
        
        % check for convergence
        if norm_grad_L < grad_tol && feasible < feasible_tol
            x_iters = x_iters(:,1:k);
            f_iters = f_iters(:,1:k);
            fprintf('acceptable solution found\n')
            return
        end
        
        x_old = x;
        
        %%%%%%%%%%%%%%%%%%%% FILL THIS PART IN %%%%%%%%%%%%%%%%%%%%%%%%
        % find the search direction
        [dk,~,qp_status,~,lambdas] = quadprog(B, J', J_g, -g, J_h, -h,[],[],[],qpopts);
        lambda = lambdas.eqlin;
        mu     = lambdas.ineqlin;
    
        % take the line search
        sigma = 0.01;
        beta  = 0.6;
        c     = 100;
        x     = line_search(@(y)(merit_fun(ffun,hfun,gfun,c,y)), x, J*dk-c*(norm(h, 1) + norm(max(g, 0), 1)), dk, sigma, beta);
    
        % update BFGS hessian approximation
        J_old   = J;
        J_h_old = J_h;
        J_g_old = J_g;
        
        % evaluate F and it's jacobian J
        [~, J] = finite_difference_jacob(ffun, x);
    
        % evaluate h and it's jacobian J_h
        [h, J_h] = finite_difference_jacob(hfun, x);
        
        % evaluate g and it's jacobian J_g
        [g, J_g] = finite_difference_jacob(gfun, x);
        
        Lx_old = J_old' + J_g_old'*mu + J_h_old'*lambda;
        Lx     = J' + J_g'*mu + J_h'*lambda;
        
        s = x - x_old;
        y = Lx - Lx_old;

        theta_k = 1;
        if((s'*y) >= 0.2 *(s'*B*s))
            theta_k = 1;
        else
            theta_k = (0.8*s'*B*s) / ((s'*B*s) - s'*y);
        end
        
        y_tilde = theta_k*y + (1-theta_k) * B * s;
%         y_tilde = y;
        
        B = B - ((B*s)*s'*B)/(s'*B*s) + (y_tilde*y_tilde')/(y_tilde'*s);
        B = (B + B') / 2; % Symmetrize Hessian, only needed due to numerical inaccuracy, so that quadprog doesn't complain
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
    
    error('minimize_sqp: max iterations exceeded')

end


function ret = merit_fun(ffun, hfun, gfun, c, x)

    f = ffun(x);    
    h = hfun(x);
    g = gfun(x);
    
    ret = f + c * (norm(h, 1) + norm(max(g, 0), 1));

end
