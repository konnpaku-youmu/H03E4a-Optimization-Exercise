function ret = objective_rosenbrock( x, y )
%objective_rosenbrock: (1-x)^2 + 100*(y - x^2)^2

ret = (1 - x).^2 + 100.*(y - x.^2).^2;

end

