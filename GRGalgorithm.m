clc ; clear ; close all;

%% Defining Parameters
% (P0*Vdot)/(R*T1(i,iteration))=40;         % ??
P0=100;
R=0.287;
Vdot=40;        %m3/s
cp=1;           %kJ/kg K
rp=6;           %Pressure Ratio
kappa=1.35;     %Air kappa
eta_turb=0.9;   %Turbine Efficiency
eta_comp=0.85;  %Compressor Efficiency
Tinf=378.15;   %Vapor Cycle Temperature
Uboiler=0.25;   % kW/ m2 K
Ureg=0.082;     % kW/ m2 K

%% Known Temperatures
Ti=30+273.15;
% Ti=293.15:5:313.15;
for i=1:length(Ti)

    T4= 1093.15 * (1+ eta_turb*( rp^( (1-kappa)/(kappa) ) -1 ) );

    %% 2.Deifining Initial Parameters for GRG ALGORITHM
    t5=0.1;           %T5 Stepsize
    t6=0.1;           %Tout Stepsize
    iteration=1;    %Iteration Counter
    tolY=1e-18;     % Objective Function tolerance

    %% GRG ALGORITHM
    % First Guess
    if i==1
        T5(i,iteration)=570;
        Tout(i,iteration)=450;
    else
        T5(i,iteration)=Unknown(i-1,5);
        Tout(i,iteration)=Unknown(i-1,6);
    end

    while true

    %% SOLVING Constraints Explicitly
        T1(i,iteration)=0.6*(Tout(i,iteration)-T5(i,iteration))+Ti(i);
        T3(i,iteration)=1.6956*T1(i,iteration)-T5(i,iteration)+T4;
        B(i,iteration)=log((Tinf-Tout(i,iteration))/(Tinf-T5(i,iteration)))*( (-(P0*Vdot)/(R*T1(i,iteration))*cp)/(Uboiler));
        C(i,iteration)=((P0*Vdot)/(R*T1(i,iteration))*cp*(T4-T5(i,iteration)))/(Ureg*(T5(i,iteration)-1.6956*T1(i,iteration))); %%

        %% Calculating O.F.
        P(i,iteration)= (P0*Vdot)/(R*T1(i,iteration))*cp*(-0.6956*T1(i,iteration)+1093.15-T4);
        Q(i,iteration)= (P0*Vdot)/(R*T1(i,iteration))*cp*(1093.15-T3(i,iteration));
        A(i,iteration)= (P0*Vdot)/(R*T1(i,iteration))*cp*(Ti(i)-T1(i,iteration));
        y(i,iteration)= 225*P(i,iteration)-45*Q(i,iteration)-80*A(i,iteration)-1000*B(i,iteration)-90*C(i,iteration);

        %% GRG Formation
        K5=[0.6  1  (378.15-Tout(i,iteration))/(T5(i,iteration)-378.15)^2  0.082*C(i,iteration)]';
        K6=[-0.6  0  1/(T5(i,iteration)-378.15)  0]';
        J=[1 0 0 0; -1.6956 1 0 0 ;0 0 exp(-B(i,iteration)*0.00463)*0.00463 0; 91.56-0.1390*C(i,iteration) -54 0 0.082*T5(i,iteration)-0.1390*T1(i,iteration)];
        S=[-4132, 2430, -1000, -90];

        %% Normalizing GRG vector
        GRG5(i,iteration)=S*inv(-J)*K5;
        GRG6(i,iteration)=S*inv(-J)*K6;
        GRG(i,iteration)=sqrt(GRG5(i,iteration)^2+GRG6(i,iteration)^2);
        GRG5e(i,iteration)=GRG5(i,iteration)/GRG(i,iteration);
        GRG6e(i,iteration)=GRG6(i,iteration)/GRG(i,iteration);

        %% Updating Independent Variabales
        T5(i,iteration+1)=T5(i,iteration)+GRG5e(i,iteration)*t5;
        Tout(i,iteration+1)=Tout(i,iteration)+GRG6e(i,iteration)*t6;

        dy(i,iteration)= GRG5(i,iteration)*t5+GRG6(i,iteration)*t6;

        %% Changing Stepsize
        if iteration>1 & GRG5(i,end)*GRG5(i,end-1)<0  
            t5=t5/10;
        end
        if iteration>1 && GRG6(i,end)*GRG6(i,end-1)<0  
            t6=t6/10;
        end

        %% Max Iteration
        if iteration>10000 
            break
        end

        %% Convergence Conditoins
        if iteration>10 & y(i,end)-y(i,end-1)<tolY
            break
        end
        T2(i,iteration)=T1(i,iteration)*(1+( rp^((kappa-1)/(kappa)) -1)/(eta_comp) );
        iteration=iteration+1;
    end

%% RESULTS

    Unknown(i,:)=[T1(i,iteration-1) T2(i,iteration-1) T3(i,iteration-1) T4 T5(i,iteration-1) Tout(i,iteration-1) A(i,iteration-1) B(i,iteration-1) C(i,iteration-1)];
    OF(i)=y(i,end);
end

% print solution
disp(['Final Objective: ' num2str(OF(1))])
disp('Solution')
disp(['T1 = ' num2str(Unknown(1,1))])
disp(['T2 = ' num2str(Unknown(1,2))])
disp(['T3 = ' num2str(Unknown(1,3))])
disp(['T5 = ' num2str(Unknown(1,5))])
disp(['Tout = ' num2str(Unknown(1,6))])
disp(['B = ' num2str(Unknown(1,8))])
disp(['C = ' num2str(Unknown(1,9))])
disp(['mdotopt = ' num2str(Vdot*P0/(R*Unknown(1,1)))])
Popt = (Vdot*P0/(R*Unknown(1,1)))*cp*(Unknown(1,1)-Unknown(1,2)+1093.15-Unknown(1,4))
Qopt = (Vdot*P0/(R*Unknown(1,1)))*cp*(1093.15-Unknown(1,3))
Aopt = (Vdot*P0/(R*Unknown(1,1)))*cp*(Ti-Unknown(1,1))
%% Convergence History
figure;
plot(y);
title('convergence history ')
xlabel('Iteration')
ylabel('y')
figure;
subplot(2,2,1);
plot(y)
title('y ')
xlabel('Iteration')
ylabel('y')
subplot(2,2,2);
plot(dy)
title('dy')
xlabel('Iteration')
ylabel('dy')
subplot(2,2,3);
plot(GRG)
title('GRG ')
xlabel('Iteration')
ylabel('GRG')
% subplot(2,2,4);
% plot(GRG6)
% title('GRG6 ')
% xlabel('Iteration')
% ylabel('GRG6')
%% Convergecne History of variables
figure;
subplot(2,3,1);
plot(T1)
title('Convergence History of T1 ')
xlabel('Iteration')
ylabel('T1')
subplot(2,3,2);
plot(T2)
title('Convergence History of T2 ')
xlabel('Iteration')
ylabel('T2')
subplot(2,3,3);
plot(T3)
title('Convergence History of T3 ')
xlabel('Iteration')
ylabel('T3')
subplot(2,3,4);
plot(1:iteration,repmat(T4,iteration))
title('Convergence History of T4 ')
xlabel('Iteration')
ylabel('T4')
subplot(2,3,5);
plot(T5)
title('Convergence History of T5 ')
xlabel('Iteration')
ylabel('T5')
subplot(2,3,6);
plot(Tout)
title('Convergence History of Tout ')
xlabel('Iteration')
ylabel('Tout')
