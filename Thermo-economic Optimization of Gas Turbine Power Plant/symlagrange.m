clc; clear;

%% Defining Parameters
Ti = 30 + 273.15; 
T_b = 105 + 273.15;
v_dot = 40;
T_c = 820 + 273.15;
P_a = 100;
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

%% Deriving Symbolic Equations and Objective Function
syms  T1 T2 T3 T5 T_out B C  m_dot l1 l2 l3 l4 l5 l6 m_dot
P = m_dot*cp*(T1-T2+T_c-T4);
Q = m_dot*cp*(T_c-T3);
A = m_dot*cp*(Ti-T1);
Y = 1/(225*P-45*Q-80*A-1000*B-90*C);

%% Deriving Constrains
C1 = T1*(1+(rp^(1-1/k)-1)/eta_c)-T2;
C2 = 0.6*(T5-T_out)-Ti+T1;
C3 = T3+T5-T2-T4;
C4 = (T_b-T_out)/(T_b-T5)-exp(-U_b*B/(m_dot*cp));
C5 = U_reg*C*(T5-T2)-m_dot*cp*(T3-T2);
C6 = m_dot*T1-v_dot*P_a/R;

%% Defining Lagrangian Function
L = Y - l1*C1 - l2*C2- l3*C3- l4*C4- l5*C5- l6*C6;

%% Extracting Differentials
dL_dT1 = diff(L,T1);
dL_dT2 = diff(L,T2);
dL_dT3 = diff(L,T3);
dL_dT5 = diff(L,T5);
dL_dT_out = diff(L,T_out); 
dL_dC = diff(L,C);
dL_dB = diff(L,B);
dL_dm_dot = diff(L,m_dot);
dL_dl1 = diff(L,l1); 
dL_dl2 = diff(L,l2);
dL_dl3 = diff(L,l3);
dL_dl4 = diff(L,l4);
dL_dl5 = diff(L,l5);
dL_dl6 = diff(L,l6);

%% Symbolic Form of Lagrangian Equations 
system = [dL_dT1;dL_dT2;dL_dT3;dL_dT5; dL_dT_out; dL_dB; dL_dC;dL_dm_dot;
    dL_dl1; dL_dl2; dL_dl3; dL_dl4; dL_dl5;dL_dl6]; 