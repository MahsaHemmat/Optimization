clc;clear;close all;

%% Problem Definition
dimension = 4;
p_max = [8700*1e3 8700*1e3 500*1e3 40*1e3];
p_min = [100*1e3 100*1e3 100*1e3 10*1e3];
VelMax = 0.1*(p_max-p_min);
VelMin = -VelMax;

%% PSO Parameters Definition
max_iterations = 100;
num_of_particles = 20;
w = 1; %100*(max(p_max-p_min))/max_iterations;
wdamp = 0.99;
c1 = 2;
c2 = 2;

global NFE; % NFE = num_of_particles * max_iterations;
NFE = 0;

%% PSO Particles Initializing
for i = 1:dimension
    p_position(:,i) = (p_max(i)-p_min(i))*rand(num_of_particles,1)+p_min(i);
    p_velocity(:,i) = 0.01*rand(num_of_particles,1);
end

%% PSO Main Loop
for count = 1:1:max_iterations
    t = 1:1:count;
    for i = 1:1:num_of_particles
        current_cost(i) = -etaFinder(p_position(i,1),p_position(i,2),p_position(i,3),p_position(i,4));
    end
    % Particle Best Finding
    if count == 1
        p_best = current_cost;
        p_best_pos = p_position;
    else
        for i = 1:num_of_particles
            if current_cost(i) < p_best(i)
                p_best(i) = current_cost(i);
                p_best_pos(i,:) = p_position(i,:);
            end
        end
    end
    
    % Global Best Finding
    [g_best,g_best_index] = min(p_best);
    g_best_pos(count,:) = p_position(g_best_index,:);
    
    % for Plot
    p_pos_Mat(count,:,:) = p_position;
    p_best_pos_Mat(count,:,:) = p_best_pos;
    g_best_Mat(count) = g_best;
    
    % Updating Values
    for i = 1:num_of_particles
        for j = 1:dimension
            % Update Velocity
            p_velocity(i,j) = w*p_velocity(i,j) + c1*rand*(p_best_pos(i,j) - p_position(i,j)) + c2*rand*(g_best_pos(count,j) - p_position(i,j));
            
            % Apply Velocity Limits
            if p_velocity(i,j) < VelMin(j)
                p_velocity(i,j) = VelMin(j);
            elseif p_velocity(i,j) > VelMax(j)
                p_velocity(i,j) = VelMax(j);
            end
            
            % Update Position
            p_position(i,j) = p_position(i,j) + p_velocity(i,j);
            
            % Apply Position Limits and Velocity Mirror Effect
            if p_position(i,j) < p_min(j)
                p_position(i,j) = p_min(j);
                p_velocity(i,j) = -p_velocity(i,j);
            elseif p_position(i,j) > p_max(j)
                p_position(i,j) = p_max(j);
                p_velocity(i,j) = -p_velocity(i,j);
            end
            
        end
    end
    w = w*wdamp;
    nfe(count) = NFE;
    count
end

%% Results
designParams = g_best_pos(end,:);
Pe1 = designParams(1);
Pe2 = designParams(2);
Pe3 = designParams(3);
Pe4 = designParams(4);
eta = -g_best(end);
plot(t,-g_best_Mat)
title("PSO")
xlabel(" Iteration")
ylabel(" eta in%")



