clc;clear; close all;
Ti = 30+273.15;
rp = 6;
Patm = 100 ; 
vdot = 40 ;
u_boiler = 0.25 ;
u_reg = 0.082 ; 
cp = 1 ;
k = 1.35;
R = 0.287;
e_c = 0.85;
e_t = 0.9 ;
T4 = (820+273.15)*(1+e_t*(rp^((1-k)/k))-e_t);
objective = @(x) -(225*(x(8)*cp*(x(1)-x(2)+1093.15-T4))-45*(x(8)*cp*(1093.15-x(3)))-80*(x(8)*cp*(Ti-x(1)))-1000*x(6)-90*x(7));
% initial guess
x0 = [270,475,650,570,450,150,100,40];


% variable bounds
lb = zeros(8);
ub = [];

% % show initial objective
% disp(['Initial Objective: ' num2str(objective(x0))])

% linear constraints
A = [];
b = [];
Aeq = [(1+((rp^((k-1)/k))-1)/e_c) -1 0 0 0 0 0 0;
    0 -1 1 1 0 0 0 0;
    1 0 0 +0.6 -0.6 0 0 0];
beq = [0;T4;Ti];

% nonlinear constraints
nonlincon = @nlcon;

% optimize with fmincon
x = fmincon(objective,x0,A,b,Aeq,beq,lb,ub,nonlincon);

% show final objective
disp(['Final Objective: ' num2str(-objective(x))])

% print solution
disp('Solution')
disp(['T1 = ' num2str(x(1))])
disp(['T2 = ' num2str(x(2))])
disp(['T3 = ' num2str(x(3))])
disp(['T5 = ' num2str(x(4))])
disp(['Tout = ' num2str(x(5))])
disp(['B = ' num2str(x(6))])
disp(['C = ' num2str(x(7))])
disp(['mdot = ' num2str(x(8))])
Popt = x(8)*cp*(x(1)-x(2)+1093.15-T4)
Qopt = x(8)*cp*(1093.15-x(3))
Aopt = x(8)*cp*(Ti-x(1))
