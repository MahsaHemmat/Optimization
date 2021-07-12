clc; clear; close all;

%% Defining Parameters
Ti = 30 + 273.15;
T_b = 105 + 273.15;
v_dot = 40;
T_c = 820 + 273.15; % T of combustion
P_a = 100*1e3;% Atmospheric Pressure
rp = 6;       % Pressure Ratio od Compressor and Turbine
c_r = 0.6;    % Cooling Ratio
U_b = 0.25;   % U of Boiler
U_reg = 0.082;% U of Regenerator
cp = 1;
k = 1.35;
eta_c = 0.85; % compressor's efficiency
eta_t = 0.9;  % turbine's efficiency
R = 0.287;    % Air 
T4 = T_c*(1+eta_t*rp^((1-k)/k)-eta_t);

%% Making Lagrangian Function
system = @(x)[- (1.6956*x(9) - x(10) - x(14)*x(8) - (305*x(8))/(225*x(8)*(x(1) - x(2) + 365.5633) - 90*x(7) - 1000*x(6) + 80*x(8)*(x(1) - 6063/20) + 45*x(8)*(x(3) - 21863/20))^2);
                                                                           x(9) + x(11) + (225*x(8))/(225*x(8)*(x(1) - x(2) + 365.5633) - 90*x(7) - 1000*x(6) + 80*x(8)*(x(1) - 6063/20) + 45*x(8)*(x(3) - 21863/20))^2 + x(13)*((41*x(7))/500 - x(8));
                                                                                                x(13)*x(8) - x(11) - (45*x(8))/(225*x(8)*(x(1) - x(2) + 365.5633) - 90*x(7) - 1000*x(6) + 80*x(8)*(x(1) - 6063/20) + 45*x(8)*(x(3) - 1.0932e+03))^2;
                                                                                                                                                                                  (x(12)*(x(5) - 7563/20))/(x(4) - 7563/20)^2 - x(11) - (41*x(7)*x(13))/500 - (3*x(10))/5;
                                                                                                                                                                                                                             (3*x(10))/5 - x(12)/(x(4) - 7563/20);
                                                                                   1000/(225*x(8)*(x(1) - x(2) + 8038822491335423/21990232555520) - 90*x(7) - 1000*x(6) + 80*x(8)*(x(1) - 6063/20) + 45*x(8)*(x(3) - 21863/20))^2 - (x(12)*exp(-x(6)/(4*x(8))))/(4*x(8));
                                                                                       90/(225*x(8)*(x(1) - x(2) + 8038822491335423/21990232555520) - 90*x(7) - 1000*x(6) + 80*x(8)*(x(1) - 6063/20) + 45*x(8)*(x(3) - 21863/20))^2 + x(13)*((41*x(2))/500 - (41*x(4))/500);
 (x(6)*x(12)*exp(-x(6)/(4*x(8))))/(4*x(8)^2) - x(13)*(x(2) - x(3)) - (305*x(1) - 225*x(2) + 45*x(3) + 38737983660199635/4398046511104)/(225*x(8)*(x(1) - x(2) + 8038822491335423/21990232555520) - 90*x(7) - 1000*x(6) + 80*x(8)*(x(1) - 6063/20) + 45*x(8)*(x(3) - 21863/20))^2 - x(1)*x(14);
                                                                                                                                                                                                              x(2) - (1.6956*x(1));
                                                                                                                                                                                                                    (3*x(5))/5 - (3*x(4))/5 - x(1) + 6063/20;
                                                                                                                                                                                                            x(2) - x(3) - x(4) + 727.5867;
                                                                                                                                                                                                     exp(-x(6)/(4*x(8))) - (x(5) - 7563/20)/(x(4) - 7563/20);
                                                                                                                                                                                                                   (41*x(7)*(x(2) - x(4)))/500 - x(8)*(x(2) - x(3));
                                                                                                                                                                                                                1.3937e+04 - x(1)*x(8)];
 %% Solving Lagrangian Equations                                                                                                                                                                                                                                                                                                                                                                                                                       
z = fsolve(system,[255,430,610,550,470,140,1030,55,1e2,1e2,1e2,10,10,1]);
T1 = z(1);
T2 = z(2);
T3 = z(3);
T5 = z(4);
T_out = z(5);
B = z(6);
C = z(7);
m_dot = z(8);
l1 = z(9);
l2 = z(10);
l3 = z(11);
l4 = z(12);
l5 = z(13);
l6 = z(14);

%% Calculating Objective Function
P = m_dot*cp*(T1-T2+T_c-T4);
Q = m_dot*cp*(T_c-T3);
A = m_dot*cp*(Ti-T1);
Y = (225*P-45*Q-80*A-1000*B-90*C);

%% Displaying the results
% show final objective
disp(['Final Objective: ' num2str(Y)])

% print solution
disp('Solution')
disp(['T1 = ' num2str(T1)])
disp(['T2 = ' num2str(T2)])
disp(['T3 = ' num2str(T3)])
disp(['T4 = ' num2str(T4)])
disp(['T5 = ' num2str(T5)])
disp(['T_out = ' num2str(T_out)])
disp(['Boiler Area = '  num2str(B)])
disp(['Regenerator Area = ' num2str(C)])
disp(['mass flow = ' num2str(m_dot)])
