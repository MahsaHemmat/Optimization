clc; clear; close all;
% Fletcher Reeves Method For Non Liner Optimization 
%% Assumptions
P10(1) = 2400*1e3;
P20(1) = 1000*1e3;
P30(1) = 500*1e3;
P40(1) = 40*1e3;
%% Other Parameters
tol = 2*1e-7; % Tolerance
g = Gradient(P10,P20,P30,P40); % first gradient of 
[gp1(1),gp2(1),gp3(1),gp4(1)] = Gradient(P10,P20,P30,P40);
i = 1; % loop counter
eta(i)= etaFinder(P10,P20,P30,P40);
%% main Loop
while true  

  if i == 1
      gama(i) = 0; % gama at first section is 0
      % finding the first direction
      s1(i) = gp1(1);
      s2(i) = gp2(1);
      s3(i) = gp3(1);
      s4(i) = gp4(1);
  else
      g0 = [gp1(i-1),gp2(i-1),gp3(i-1),gp4(i-1)]; % defining gradient of last section
      gama(i) = (norm(g)^2)/(norm(g0)^2) ; % Calculating gama
      % finding the new direction
      s1(i) = gp1(i)+gama(i)*s1(i-1);
      s2(i) = gp2(i)+gama(i)*s2(i-1);
      s3(i) = gp3(i)+gama(i)*s3(i-1);
      s4(i) = gp4(i)+gama(i)*s4(i-1);
  end
  
  % Finding the best step size by gold Section Method
  [Pe1,Pe2,Pe3,Pe4]= Gold(P10,P20,P30,P40,s1(i),s2(i),s3(i),s4(i));
  P10 = Pe1;
  P20 = Pe2;
  P30 = Pe3;
  P40 = Pe4;
  i = i+1; % updating the i
  [gp1(i),gp2(i),gp3(i),gp4(i)] = Gradient(P10,P20,P30,P40); % updating the gradients
  g = [gp1(i),gp2(i),gp3(i),gp4(i)];
  % checking the statement
  normV(i) = norm(g);
  if norm(g) < tol
      break
  end
  %% Defining the optimized Value
   eta(i+1)= etaFinder(P10,P20,P30,P40);
end
t = 1:1:i;
plot(t,eta,'bo')
title("Eta Vs Iterations")
xlabel("Iterations")
ylabel("Eta in %")
figure;
plot(t,normV,'r*')
title("Gradient Vs Iterations")
xlabel("Iterations")
ylabel("Norm of Gradient")