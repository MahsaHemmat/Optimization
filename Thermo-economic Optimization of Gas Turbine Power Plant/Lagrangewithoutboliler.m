clc; clear; close all;

Ti = 30 + 273.15;
T_b = 105 + 273.15;
v_dot = 40;
T_c = 820 + 273.15;
P_a = 100*1e3;
rp = 6;
c_r = 0.6; % Cooling Ratio
U_b = 0.25;
U_reg = 0.082;
cp = 1;
k = 1.35;
eta_c = 0.85;
eta_t = 0.9;
R = 0.287;
T4 = T_c*(1+eta_t*rp^((1-k)/k)-eta_t);
m_dot = v_dot*P_a/(R*Ti*1000);
T2 = Ti*(1+(rp^(1-1/k)-1)/eta_c);
  system = @(x)[   x(4) + (41*x(3)*x(5))/500 - 18197966002702635/(8796093022208*(90*x(3) - (18197966002702635*x(1))/8796093022208 + 23271606550695994537/35184372088832)^2);
                                                                                                            x(4) - (404399244504503*x(5))/8796093022208;
  90/(90*x(3) - (18197966002702635*x(1))/8796093022208 + 23271606550695994537/35184372088832)^2 + x(5)*((41*x(1))/500 - 131198361859196373/2199023255552000);
                                                                                                             x(1) + x(2) - 682582388020597/549755813888;
 (41*x(3)*(x(1) - 3199960045346253/4398046511104))/500 - (404399244504503*x(2))/8796093022208 + 1294061424782619874190052677259/38685626227668133590597632];
z = fsolve(system,[650,600,1000,10,10])
T3 = z(1);
T5 = z(2);
C = z(3);
l1 = z(4);
l2 = z(5);

%% Calculating Objective Function
P = m_dot*cp*(Ti-T2+T_c-T4);
Q = m_dot*cp*(T_c-T3);
Y = (225*P-45*Q-90*C);

%% Displaying the results
% show final objective
disp(['Final Objective: ' num2str(Y)])

% print solution
disp('Solution')
disp(['T2 = ' num2str(T2)])
disp(['T3 = ' num2str(T3)])
disp(['T4 = ' num2str(T4)])
disp(['T5 = ' num2str(T5)])
disp(['Regenerator Area = ' num2str(C)])