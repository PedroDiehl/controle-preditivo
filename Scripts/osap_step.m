%{
Pedro Henrique Diehl
Controle Preditivo
Controlador OSAP -  One Sample Ahead Predictive
%}
clc, close all, clear all

fs = 10^3;
Ts = 1 / fs;

simulation_time = 0.05;
simulation_time_array = 0:Ts:simulation_time;

r = [1 1];
e = [0 0];
y = [0 0];
ym = [0];
u = [0 0];
t = [0 0];

am = 0.5;
km = 0.5;
a = 0.1;
b = 0.1;

for k = 2:length(simulation_time_array) - 1
    t(k) = k * Ts;
    r(k) = 1;
    
    ym(k) = am * ym(k - 1) + km * r(k - 1);
    ym(k + 1) = am * ym(k) + km * r(k);
    
    y(k) = a * u(k - 1) + b * y(k - 1);
    u(k) = (ym(k + 1) - b * y(k)) / a;
end

y(k + 1) = y(k);
t(k + 1) = (k + 1) * Ts;
plot(t, ym)
hold
plot(t, y)
