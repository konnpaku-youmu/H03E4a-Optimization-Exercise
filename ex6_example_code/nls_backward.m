function [v, grad] = nls_backward(x, ys, ts)

m = length(ys);
v = 0;
grad = zeros(6, 1);

for i = 1:m
    y = ys(i,:);
    t = ts(i);
    
    % COMPLETE HERE %%%%%%%%%%%%%
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    grad = grad + bx(1:6);
    v = v+x15;
end