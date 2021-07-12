function [Pf1,Pf2,Pf3,Pf4]= Gold(P10,P20,P30,P40,s1,s2,s3,s4)

% step 1 : define interval and function
xL = 1e-6;
xU = 1e10;


%step 2 : evaluate the function at end points
fL = etaFinder(P10+s1*xL,P20+s2*xL,P30+s3*xL,P40+s4*xL);
fU = etaFinder(P10+s1*xU,P20+s2*xU,P30+s3*xU,P40+s4*xU);

% step 3 : calculate intermediate points
R = 0.5*(sqrt(5)-1);
d =R*(xU-xL);
x1 = xU-d;
x2 = xL+d;

% step 4 : evaluate at x1 and x2
f1 = etaFinder(P10+s1*x1,P20+s2*x1,P30+s3*x1,P40+s4*x1);
f2 = etaFinder(P10+s1*x2,P20+s2*x2,P30+s3*x2,P40+s4*x2);

% step 5: main loop
err = inf;
tol = 1e-5;
while err > tol 
    % step 5a: update interval
    if f1 > f2
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
        f1 = etaFinder(P10+s1*x1,P20+s2*x1,P30+s3*x1,P40+s4*x1);
    elseif f1 < f2
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
        f2 = etaFinder(P10+s1*x2,P20+s2*x2,P30+s3*x2,P40+s4*x2);
    else
        xL = (x1+x2)/2;
        xU = xL;
    end
    %step 5b : determine if converged
    err = 2*abs(xU-xL)/(xU+xL); 

end

% step 6 calculate final answer
xe = (x1+x2)/2;
Pf1 = P10+s1*xe;
Pf2 = P20+s2*xe;
Pf3 = P30+s3*xe;
Pf4 = P40+s4*xe;
end