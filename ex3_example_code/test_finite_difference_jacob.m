function test_finite_difference_jacob

% try 100 random points, make sure finite_step_jacob gives something
% close to the analytical solution
for k = 1 : 100
    x0 = randn(3,1);
    [~,J] = finite_difference_jacob(@(x)test_function(x), x0);
    J_analytical = test_function_jacob(x0);
    max_err = max( max( abs(J - J_analytical) ) );
    
    assert(max_err <= 1e-4, 'finite difference jacobian gives the wrong answer :(')
end

disp('finite difference jacobian seems to be working, yay!')

end

function ret = test_function(xyz)
x = xyz(1);
y = xyz(2);
z = xyz(3);

f1 = x*y + exp(z);
f2 = x*exp(-2*y) + x*z;
ret = [f1; f2];

end

function J = test_function_jacob(xyz)
x = xyz(1);
y = xyz(2);
z = xyz(3);

J = [          y,              x, exp(z);
     exp(-2*y)+z, -2*x*exp(-2*y),      x;];

end