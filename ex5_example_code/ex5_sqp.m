function ex5_sqp()

clc
close all

% first let's plot the function:
figure(1)
[X,Y] = meshgrid(linspace(-1,4,40), linspace(-3,4,40));
obj = X;
for k=1:size(X,1)
    for j=1:size(X,2)
        obj(k,j) = ffun([X(k,j),Y(k,j)]);
    end
end
contour(X, Y, obj, 40)
t = linspace(-4,4,400);
hold on
plot(t, 3 + (t-1).^2 - t,'black')
plot(t, 2*t - 0.4*t.^2,'black')
xlim([-1 4])
ylim([-3 4])


x0 = [3;1];
[~,x,grad_iters] = minimize_sqp(@(x)ffun(x),@(x)hfun(x),@(x)gfun(x),x0);

% plot solution
hold on
plot(x(1,:), x(2,:),'r')
plot(x(1,:), x(2,:),'ro')
xlabel('x','Interpreter','latex','Fontsize',12);
ylabel('y','Interpreter','latex','Fontsize',12);


figure(2)
semilogy(grad_iters,'.','MarkerSize',16)
grid on
title('Gradient norm iterations', 'Interpreter', 'latex', 'FontSize', 12)
xlabel('iterations', 'Interpreter', 'latex', 'Fontsize', 12);
ylabel('$\|\nabla L(x_k, \lambda_k, \mu_k)\|_\infty$', 'Interpreter', 'latex', 'Fontsize', 12);

end

function f = ffun(xy)
    x = xy(1);
    y = xy(2);
    
    f = 0.5*(y/2)^2 + 0.5*x^2;
end

function h = hfun(xy)
    x = xy(1);
    y = xy(2);
    
    h = y - (3 + (x-1).^2 - x);
end

function g = gfun(xy)
    % such that g(x) <= 0
    x = xy(1);
    y = xy(2);
    
    g = -2*x + 0.4*x^2 + y;
end