function Qh = Qb(Ps1)
mdot = 320000/3600;
%point1
P1 =9.3*1e6;
T1=py.CoolProp.CoolProp.PropsSI('T','P',Ps1,'Q',0,'Water');
h1=py.CoolProp.CoolProp.PropsSI('H','P',P1,'T',T1,'Water');
s1=py.CoolProp.CoolProp.PropsSI('S','P',P1,'T',T1,'Water');
%point2
P2 = 8.7*1e6;
T2 = 500 + 273.15;
h2=py.CoolProp.CoolProp.PropsSI('H','P',P2,'T',T2,'Water');
s2=py.CoolProp.CoolProp.PropsSI('S','P',P2,'T',T2,'Water');
Qh = mdot*(h2-h1);
end