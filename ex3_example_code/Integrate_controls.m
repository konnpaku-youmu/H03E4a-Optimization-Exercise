function X = Integrate_controls(U)

dt = 0.1;
A = [0 1 0 0; 0 0 0 0; 0 0 0 1; 0 0 0 0];

A_prime = zeros(244);
B_prime = zeros(244, 120);

for i=5:4:244
    A_prime(i:i+3, i-4:i-1) = eye(4)+A.*dt;
end

for i=1:60
    B_prime(2+i*4, i) = dt;
    B_prime(4+i*4, i+60) = dt;
end

X = (eye(244) - A_prime) \ (B_prime * U);

end
