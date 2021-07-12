function f = Cyclefunc(Ps)
mdot = 320000/3600;
%% Points Info
%point1
P1 =9.3*1e6;
T1=py.CoolProp.CoolProp.PropsSI('T','P',Ps(1),'Q',0,'Water');
h1=py.CoolProp.CoolProp.PropsSI('H','P',P1,'T',T1,'Water');
s1=py.CoolProp.CoolProp.PropsSI('S','P',P1,'T',T1,'Water');
%point2
P2 = 8.7*1e6;
T2 = 500 + 273.15;
h2=py.CoolProp.CoolProp.PropsSI('H','P',P2,'T',T2,'Water');
s2=py.CoolProp.CoolProp.PropsSI('S','P',P2,'T',T2,'Water');
%point3
P3 = 100*1e3;
s3 = s2;
h3=py.CoolProp.CoolProp.PropsSI('H','P',P3,'S',s3,'Water');
%point4
P4 = 5*1e3;
s4 = s2;
h4=py.CoolProp.CoolProp.PropsSI('H','P',P4,'S',s4,'Water');
%point 5
P5 = 5*1e3;
T5=py.CoolProp.CoolProp.PropsSI('T','P',P5,'Q',0,'Water');
h5=py.CoolProp.CoolProp.PropsSI('H','P',P5,'Q',0,'Water');
s5=py.CoolProp.CoolProp.PropsSI('S','P',P5,'Q',0,'Water');
%point6
P6 = Ps(3);
s6 = s5;
h6=py.CoolProp.CoolProp.PropsSI('H','P',P6,'S',s6,'Water');
%point 7 
P7 = Ps(3);
T7=py.CoolProp.CoolProp.PropsSI('T','P',Ps(4),'Q',0,'Water');
h7=py.CoolProp.CoolProp.PropsSI('H','P',P7,'T',T7,'Water');
s7=py.CoolProp.CoolProp.PropsSI('S','P',P7,'T',T7,'Water');
%point8
P8 = Ps(3);
T8=py.CoolProp.CoolProp.PropsSI('T','P',P8,'Q',0,'Water');
h8=py.CoolProp.CoolProp.PropsSI('H','P',P8,'Q',0,'Water');
s8=py.CoolProp.CoolProp.PropsSI('S','P',P8,'Q',0,'Water');
%point 9 
P9 = P1;
s9 = s8;
h9=py.CoolProp.CoolProp.PropsSI('H','P',P9,'S',s9,'Water');
%point10
P10 = P1;
T10=py.CoolProp.CoolProp.PropsSI('T','P',Ps(2),'Q',0,'Water');
h10=py.CoolProp.CoolProp.PropsSI('H','P',P10,'T',T10,'Water');
s10=py.CoolProp.CoolProp.PropsSI('S','P',P10,'T',T10,'Water');
%point11
P11 = Ps(1);
T11=py.CoolProp.CoolProp.PropsSI('T','P',P11,'Q',0,'Water');
h11=py.CoolProp.CoolProp.PropsSI('H','P',P11,'Q',0,'Water');
s11=py.CoolProp.CoolProp.PropsSI('S','P',P11,'Q',0,'Water');
%point12
P12 = Ps(2);
T12=py.CoolProp.CoolProp.PropsSI('T','P',P12,'Q',0,'Water');
h12=py.CoolProp.CoolProp.PropsSI('H','P',P12,'Q',0,'Water');
s12=py.CoolProp.CoolProp.PropsSI('S','P',P12,'Q',0,'Water');
%point13
P13 = P12;
T13 = T12; h13 = h12; s13 = s12;
%point14
P14 = P8;
T14 = T8; h14 = h8; s14 = s8;
%point 15
P15 = Ps(4);
T15=py.CoolProp.CoolProp.PropsSI('T','P',P15,'Q',0,'Water');
h15=py.CoolProp.CoolProp.PropsSI('H','P',P15,'Q',0,'Water');
s15=py.CoolProp.CoolProp.PropsSI('S','P',P15,'Q',0,'Water');
%point 16
P16 = P5;
T16 = T5; h16 = h5; s16 = s5;
%extraction steam
hs1 = py.CoolProp.CoolProp.PropsSI('H','P',Ps(1),'S',s2,'Water');
hs2 = py.CoolProp.CoolProp.PropsSI('H','P',Ps(2),'S',s2,'Water');
hs3 = py.CoolProp.CoolProp.PropsSI('H','P',Ps(3),'S',s2,'Water');
hs4 = py.CoolProp.CoolProp.PropsSI('H','P',Ps(4),'S',s2,'Water');
%% Calculation
% Boiler
Qh = mdot*(h2-h1);
%HP heater
y1 = (h1-h10)/(hs1-h11);
%IP heater
y2 = (y1*(h12-h13)+h9-h10)/(h13-hs2);
%Deaerating OFWH
y3 = (h8-(1-y1-y2)*h7-(y1+y2)*h14)/(hs3-h7);
%LP heater
y4 = ((1-y1-y2-y3)*(h6-h7))/(h15-hs4);
%HP Turbine
WdotHP = mdot*(h2-(1-y1-y2-y3)*h3-y1*hs1-y2*hs2-y3*hs3);
%LP Turbine
WdotLP = mdot*((1-y1-y2-y3)*h3-(1-y1-y2-y3-y4)*h4-y4*hs4);
%condensate Pump
Wdotcp = mdot*(1-y1-y2-y3)*(h6-h5);
%BoilerFeedPump
WdotBFP = mdot*(h9-h8);
%% Results 
Qdotin = Qh;
Wnet = WdotHP + WdotLP - Wdotcp - WdotBFP;
f(1)=Qh;
f(2) = f(1)/ Wnet;
end