function [Pf1,err,i]= GoldQdot

i = 1;
% step 1 : define interval and function
xL = 100*1e3;
xU = 8700*1e3;


%step 2 : evaluate the function at end points
fL = Qb(xL);
fU = Qb(xU);

% step 3 : calculate intermediate points
R = 0.5*(sqrt(5)-1);
d =R*(xU-xL);
x1 = xU-d;
x2 = xL+d;

% step 4 : evaluate at x1 and x2
f1 = Qb(x1);
f2 = Qb(x2);

% step 5: main loop
err(i) = inf;
tol = 1e-5;
while err(i) > tol 
    % step 5a: update interval
    if f1 < f2
        %move upper bound to x2
        xU = x2;
        fU = f2;
        % new x2
        x2 = x1;
        f2 = f1;
        % new x1
        d = R*(xU-xL);
        x1 = xU-d;
        % evaluate f1
        f1 = Qb(x1);
    elseif f1 > f2
        %move lower bound to x1
        xL = x1;
        fL = f1;
        % new x1
        x1 = x2;
        f1 = f2;
        % new x1
        d = R*(xU-xL);
        x2 = xL+d;
        % evaluate f1
        f2 = Qb(x2);
    else
        xL = (x1+x2)/2;
        xU = xL;
    end
    %step 5b : determine if converged
    err(i+1) = 2*abs(xU-xL)/(xU+xL); 
    i = i+1;
end

% step 6 calculate final answer
xe = (x1+x2)/2;
Pf1 = xe;
end