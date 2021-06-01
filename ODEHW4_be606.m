%% HW4 Problem 3 BE606
close all
clear all


q0 = .425;
s = 5/6;
h = 1/3;
R_a = 0.9;
C_a = 1.0666;
R_pa = 0.075;
C_pa = 2.2666;

%dP/dt = Q(t)/C - P/RC
%Q(t) = q0sin(pi*mod(t,s)/h) for mod(t,s) < h
% 0 otherwise


g = @(t,x)[ Qv(t)/C_a - x(1)/(R_a * C_a); Qv(t)/C_pa - x(2)/(R_pa * C_pa)];

[t, xa] = ode45(@(t,x) g(t,x), [0 4], [72,2]);
bf = [];

for i = 1:length(t)
    bloodflow = Qv(t(i));
    bf(i) = bloodflow;
end

% Qv(1)

figure;
plot(t,xa(:,1))
title('Aortic Pressure over 5 Cardiac Cycles')
ylabel('Aortic Pressure')
xlabel('time')

figure;
plot(t,xa(:,2))
title('Pulmonary Pressure over 5 Cardiac Cycles')
ylabel('Pulmonary Pressure')
xlabel('time')

figure;
plot(t, bf')
title('Blood Flow over 5 Cardiac Cycles')
ylabel('Blood Flow')
xlabel('time')


Psyst = max(xa(:,1));
Pdiast = min(xa(:,1));

MAP_Standard = Pdiast - (Psyst-Pdiast)/3

MAP_AUC = trapz(xa(:,1))/5 / trapz(xa(:,2))/5 * 100


MAP_fractionalDifference = (MAP_AUC - MAP_Standard)/2

function [qt] = Qv(t)
q0 = 425;
s = 5/6;
h = 1/3;
    if mod(t,s) <= h
        qt = q0*sin(pi * mod(t,s)/h);
    else 
        qt = 0;
    end
end








