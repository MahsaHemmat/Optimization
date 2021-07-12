clc ; clear ; close all ;
%% Finding Pareto points by gamultiobj Function
options = optimoptions('gamultiobj','PopulationSize',60,...
          'ParetoFraction',0.7,'PlotFcn',@gaplotpareto);
     
lb = [100*1e3,100*1e3,100*1e3,5*1e3];
ub = [8700*1e3,8700*1e3,8700*1e3,100*1e3];
[solution,ObjectiveValue] = gamultiobj(@Cyclefunc,4,[],[],[],[],lb,ub,options);
%% Saving Pareto points
pareto = [];
pareto(:,1) = ObjectiveValue(:,1);
pareto(:,2) = (1./ObjectiveValue(:,2)).*100;
%% plotting section
plot(pareto(:,1),pareto(:,2),'bo')
xlabel('Qdotin [W]')
ylabel('eta')
title('Pareto Points in Parameter Space')
figure;
Qdotin_opt = 1.8148e+08;
eta_opt = 45.9;
plot(pareto(:,1)./Qdotin_opt,pareto(:,2)./eta_opt,'r*')
xlabel('Qdotin/Qdotin(opt)')
ylabel('eta/eta(opt)')
title('Pareto Front')