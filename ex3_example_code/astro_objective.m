function f = astro_objective(U)

state = Integrate_controls(U);

pos_1 = zeros(244, 1);
pos_1(4*20-3) = 1;
pos_1(4*20-1) = 1;
pos_1 = pos_1.*state;

pos_1_obj = zeros(244, 1);
pos_1_obj(4*20-3) = 20;
pos_1_obj(4*20-1) = 10;
cost_1 = norm(pos_1 - pos_1_obj)^2;

pos_2 = zeros(244, 1);
pos_2(4*40-3) = 1;
pos_2(4*40-1) = 1;
pos_2 = pos_2.*state;

pos_2_obj = zeros(244, 1);
pos_2_obj(4*40-3) = 80;
pos_2_obj(4*40-1) = -30;
cost_2 = norm(pos_2 - pos_2_obj)^2;

pos_3 = zeros(244, 1);
pos_3(4*61-3) = 1;
pos_3(4*61-1) = 1;
pos_3 = pos_3.*state;

pos_3_obj = zeros(244, 1);
pos_3_obj(4*61-3) = 140;
pos_3_obj(4*61-1) = 0;
cost_3 = norm(pos_3 - pos_3_obj)^2;

velocity_3 = zeros(244, 1);
velocity_3(4*61-2) = 1;
velocity_3(4*61) = 1;
velocity_3 = velocity_3.*state;

velocity_3_obj = zeros(244, 1);
velocity_3_obj(4*61-2) = 0;
velocity_3_obj(4*61) = 0;
cost_velo = norm(velocity_3 - velocity_3_obj)^2;

cost_fuel = 0;
for i=1:60
    cost_fuel = cost_fuel + (sqrt(U(i)^2 + U(60+i)^2 + 1) - 1);
end

f = cost_1 + cost_2 + cost_3 + cost_velo + 1e-6*cost_fuel;

end