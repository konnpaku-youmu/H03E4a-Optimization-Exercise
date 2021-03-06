function ex5_sqp_chain()

clc
close all

N = 30;
x0 = linspace(-1,1,N);
%y0 = ones(1,N);
%y0 = 1+0.2*cos(x0*pi/2);
y0 = 1-0.2*cos(x0*pi/2);
xy0 = [x0,y0]';

[xy,xiters,grad_iters] = minimize_sqp(@ffun,@hfun,@gfun,xy0,@callback);
x = xy(1:N);
y = xy(N+1:end);

% plot solution
figure(1)
plot(x,y,'b'); hold on;
plot(x,y,'ro')
xlabel('x', 'Interpreter', 'latex', 'FontSize', 12);
ylabel('y', 'Interpreter', 'latex', 'FontSize', 12);
ylim([-inf 1])

figure(2)
semilogy(grad_iters,'.','MarkerSize',16)
xlabel('Iterations', 'Interpreter', 'latex', 'Fontsize', 12);
ylabel('$\|\nabla L(x_k, \lambda_k)\|_\infty$', 'Interpreter', 'latex', 'Fontsize', 12);
grid on;
title('Gradient norm iterations', 'Interpreter', 'latex', 'FontSize', 12)

end

function callback(x)
    N = round(length(x)/2);
    clf
    plot(x(1:N), x(N+1:end),'r');
    hold on
    plot(x(1:N), x(N+1:end),'bo');
    axis([-1.3 1.3 -0.1 2.1])
    drawnow
    pause(0.2);
end

function V = ffun(xy)
    N = round(length(xy)/2);
    x = xy(1:N);
    y = xy(N+1:end);
    
    V = sum(y);
end

function h = hfun(xy)
    N = round(length(xy)/2);
    x = xy(1:N);
    y = xy(N+1:end);
    
    r = 1.4*2/N;
    
    h = zeros(N+3, 1);
    for i=2:N
        h(i-1) = (x(i)-x(i-1))^2 + (y(i)-y(i-1))^2 - r^2;
    end

    h(N) = x(1) + 1;
    h(N+1) = x(N) - 1;
    h(N+2) = y(1) - 1;
    h(N+3) = y(N) - 1;
end

function g = gfun(xy)
    N = round(length(xy)/2);
    x = xy(1:N);
    y = xy(N+1:end);
    
    g = -0.6*x.^2 + 0.15 * x + 0.5 - y;
end