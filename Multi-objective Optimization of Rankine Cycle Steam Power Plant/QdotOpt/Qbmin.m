clc; clear; close all;
[Pe1,err,i]= GoldQdot;
Qbopt = Qb(Pe1)
t = 1:1:i;
plot(t,err,'r*')
title(" Iterations Vs Error")
xlabel("Iteration")
ylabel("Error")