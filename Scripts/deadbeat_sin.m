%{
Pedro Henrique Diehl
Controle Preditivo
Controlador Deadbeat
%}
clc, close all, clear all

fs = 10^3;
Ts = 1 / fs;

simulation_time = 1;
simulation_time_array = 0:Ts:simulation_time;

r = [0 0];
e = [0 0];
y = [0 0];
u = [0 0];
t = [0 0];

fsin = fs / 10^3;
wn = 2 * pi * fsin;
A = 1;

for k = 3:length(simulation_time_array) - 1
    t(k) = k * Ts;
    r(k) = A * sin(wn * t(k));
    y(k) = (2 * u(k - 1) + u(k - 2) - y(k - 1)) / 3;
    e(k) = r(k) - y(k);
    u(k) = 1 / 2 * (3 * e(k) + e(k - 1) + u(k - 1) + u(k - 2));
end

plot(t, r)
hold
plot(t, y)
