%{
Pedro Henrique Diehl
Controle Preditivo
Controlador Deadbeat
%}
clc, close all, clear all

fs = 10;
Ts = 1 / fs;

simulation_time = 1;
simulation_time_array = 0:Ts:simulation_time;

r = [1 1 1];
e = [0 0 0];
y = [0 0 0];
u = [0 0 0];
t = [0 0 0];

for k = 3:length(simulation_time_array) - 1
    t(k) = k * Ts;
    r(k) = 1;
    u(k) = ((1 + Ts) * e(k - 1) - e(k - 2)) / Ts + u(k - 1);
    y(k) = (y(k - 1) + u(k) * Ts) / (1 + Ts);
    e(k) = r(k) - y(k);
end

plot(t, r)
hold
plot(t, y)
