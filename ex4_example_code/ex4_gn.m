function ex4_gn()
	clc
	close all
	%
	x0               = [1;1]                              ;
	[t,rates]        = radioactive_emissions_data()       ;
	[x,~,grad_iters] = minimize_gn(@(x)Ffun(x,t,rates),x0);
	fprintf('\nresults: rate(t) = %.3f * exp(-t / %.2f)\n',x)
	fprintf('half life: %.3f years\n', x(2))

	figure()
	subplot(211)
	plot(t, rates,'b.')
	hold on
	plot(t, x(1)*exp(-t./x(2)),'r')
    title('Radioactive decay rate', 'Interpreter', 'latex', 'Fontsize', 12);
	legend('data','curve fit', 'Interpreter', 'latex', 'Fontsize', 12);
    xlabel('time', 'Interpreter', 'latex', 'Fontsize', 12);
    ylabel('rate', 'Interpreter', 'latex', 'Fontsize', 12);
    
	subplot(212)
	semilogy(grad_iters,'.','MarkerSize',16)
	grid on
	title('Iterations of the gradient norm', 'Interpreter', 'latex', 'Fontsize', 12);
    xlabel('iterations', 'Interpreter', 'latex', 'Fontsize', 12);
    ylabel('$\|\nabla F\|_\infty$', 'Interpreter', 'latex', 'Fontsize', 12);
end



function F = Ffun(x,t,rates)
% use formula (1.5) with
%   c     = x(1)
%   tau   = x(2)
%   rates = ri
c   = x(1);
tau = x(2);

%%%%%%%%%%%% FILL THIS IN %%%%%%%%%%%%%
F = c * exp(-t/tau) - rates;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
