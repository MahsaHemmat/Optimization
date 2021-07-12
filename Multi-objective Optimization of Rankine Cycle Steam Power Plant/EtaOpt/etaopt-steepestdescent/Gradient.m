function [gp1,gp2,gp3,gp4]= Gradient(P10,P20,P30,P40)
%%  Defining dx
dP_1 = 1e-5;
dP_2 = dP_1;
dP_3 = dP_1;
dP_4 = dP_1;

%% differentiate P1
f1p1 = etaFinder(P10-dP_1/2,P20,P30,P40);
f2p1 = etaFinder(P10+dP_1/2,P20,P30,P40);
gp1 = (f2p1-f1p1)/dP_1;

%% differentiate P2
f1p2 = etaFinder(P10,P20-dP_2/2,P30,P40);
f2p2 = etaFinder(P10,P20+dP_2/2,P30,P40);
gp2 = (f2p2-f1p2)/dP_2;

%% differentiate P3
f1p3 = etaFinder(P10,P20,P30-dP_3/2,P40);
f2p3 = etaFinder(P10,P20,P30+dP_3/2,P40);
gp3 = (f2p3-f1p3)/dP_3;

%% differentiate P4
f1p4 = etaFinder(P10,P20,P30,P40-dP_4/2);
f2p4 = etaFinder(P10,P20,P30,P40+dP_4/2);
gp4 = (f2p4-f1p4)/dP_4;

end
  