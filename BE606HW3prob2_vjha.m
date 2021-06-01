%% BE 606 HW 3 Problem 2
k2 = 0.5;
k5 = 0.5;
k3 = 0.4;
k4 = 0.1;
k7 = 0.01;

%[M] = 1 initially, all else are 0
%k1 = k6 = [0:0.1:0.5] 

%m' = -k1*[M] + 0.5*[Mp] + 0.01*(1-[M]-[Mp]-[AMp])
%mp' = k1*[M] + 0.1*[AMp] - 0.9*[Mp]
%amp' = 0.4*[Mp] + k6*(1-[M]-[Mp]-[AMp]) - 0.6*[AMp]
%x(1) = M
%x(2) = Mp
%x(3) = Amp

g = @(t,x,k)[-k*x(1) + 0.5 * x(2) + 0.01*(1-x(1)-x(2)-x(3)); k*x(1) + 0.1*x(3) - 0.9*x(2); 0.4*x(2)+ k*(1-x(1)-x(2)-x(3))-0.6*x(3)];

xa_totm = [];
xa_totmp = [];
xa_totamp = [];
i = 1;

for k = [0 0.1 0.2 0.3 0.4]
    
    [t, xa] = ode45(@(t,x) g(t,x,k), [0 50], [1,0,0]);
%     xa_totm(:,i) = xa(:,1);
%     xa_totmp(:,i) = xa(:,2);
%     xa_totamp(:,i) = xa(:,3);
    
   
end

%[AM] = 1- [the rest]
am = 0;

for i = 1:length(xa)
    am(i) = 1 - xa(i,1) - xa(i,2) - xa(i,3);
end

for i = 1:length(xa)
    forcep(i) = xa(i,2) + xa(i,3);
end

%so at time 0 to 10 there should be no change in any concentrations
%At time 10, [M] should sharply decrease
figure;
plot(xa)
hold on
plot(am)
legend('[M]', '[Mp]', '[AMp]', '[AM]')
xlabel('t(s)')
ylabel('Fractional Concentration')
title('Fractional Concentration v. Time')



figure;

plot(forcep)
xlabel('t(s)')
ylabel('Phosphorylated Fraction')
title('Phosphorylated Fraction v. Time')


% Part d


ff = @(t,x,k)[-k*x(1) + 0.5 * x(2) + 0.01*(1-x(1)-x(2)-x(3)); k*x(1) + 0.1*x(3) - 0.9*x(2); 0.4*x(2)+ k*(1-x(1)-x(2)-x(3))-0.6*x(3)];

xa_totm = [];
xa_totmp = [];
xa_totamp = [];
i = 1;

for k = [0 0.25 0.3 0.5 0.75 0.5 0.75]
    
    [t, xg] = ode45(@(t,x) ff(t,x,k), [0 50], [1,0,0]);
%     xa_totm(:,i) = xa(:,1);
%     xa_totmp(:,i) = xa(:,2);
%     xa_totamp(:,i) = xa(:,3);
    
   
end

for i = 1:length(xg)
    forcepg(i) = xg(i,2) + xg(i,3);
end

figure;

plot(forcepg)
xlabel('t(s)')
ylabel('Phosphorylated Fraction')
title('Phosphorylated Fraction v. Time (Oscillatory)')

