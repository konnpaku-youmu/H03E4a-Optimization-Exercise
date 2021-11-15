function ex4_nl()
	clc
	close all
	% first let's plot the function:
	figure(1)
	[X,Y] = meshgrid(linspace(-1,4,40), linspace(-3,4,40));
	obj   = X                                             ;
	for k=1:size(X,1)
		for j=1:size(X,2)
			obj(k,j) = ffun([X(k,j),Y(k,j)]);
		end
	end
	contour(X, Y, obj, 40)
	hold on
	t = linspace(-1,4,400);
	plot(t, 3 + (t-1).^2 - t,'k','LineWidth',2)
	xlim([-1,4])
	ylim([-3,4])

% 	x0 = [3;1]  ;
	x0 = [3;2];
	[~,x,grad_iters] = minimize_nl(@(x)ffun(x),@(x)hfun(x),x0);

	% plot solution
	hold on
	plot(x(1,:), x(2,:),'r')
	plot(x(1,:), x(2,:),'ro')
    xlabel('x','Interpreter','latex','Fontsize',12);
    ylabel('y','Interpreter','latex','Fontsize',12);
    legend('Objective','Constraint','Interpreter','latex','Fontsize',12,'Location','Southeast');
    title('Solution of the constrained optimization problem', 'Interpreter', 'latex', 'Fontsize', 12);


	figure(2)
	semilogy(grad_iters,'.','MarkerSize',16)
	grid on
	title('Iterations of the gradient norm', 'Interpreter', 'latex', 'Fontsize', 12);
    xlabel('iterations', 'Interpreter', 'latex', 'Fontsize', 12);
    ylabel('$\|\nabla L(x_k, \lambda_k)\|_\infty$', 'Interpreter', 'latex', 'Fontsize', 12);

end

function f = ffun(xy)
x = xy(1);
y = xy(2);

f = (1/2) * (x^2 + (y/2)^2); % ?

end

function h = hfun(xy)

x = xy(1);
y = xy(2);

h = y - ((x - 1)^2 - x + 3); % ?

end