function p_e = sum_pot_nonlin(z)
    x = z(1:length(z)/2);
    y = z(length(z)/2:length(z));

    N_p = length(x);
    L = 1;
    m = 40/N_p;
    g = 9.81;

    x = [-2 x 2];
    y = [1 y 1];

    % elastic potential energy
    sum_elas_pot = 0;
    for i = 1 : N_p+1
        sum_elas_pot = sum_elas_pot + (sqrt((x(i) - x(i+1))^2 + (y(i) - y(i+1))^2) - (L / N_p))^2;
    end
    
    % gravitational potential energy
    grav_pot = m * g * sum(y);

    p_e = (1/2) * 70 * N_p * sum_elas_pot + grav_pot;
end
