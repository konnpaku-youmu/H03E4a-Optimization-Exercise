function V = objective_hanging_chain_x_constant(y)
	% first we add the first and last y_1 = y_N = 1
	y = [1;y;1];
	% some constants
	N = length(y)       ;
	m = 40/N            ;
	D = 70*N            ;
	g = 9.81            ;
	L = 1               ;
	x = linspace(-2,2,N);
	
	%%%%%%%%%%%%%%%%%%%%% COMPUTE THE OBJECTIVE HERE %%%%%%%%%%%%%%%%%%%%%%%%%%

	V = []; error('compute hanging chain objective here');

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end