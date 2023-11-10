%{
Pedro Henrique Diehl
Controle Preditivo
Controlador TSAP - Two Sample Ahead Predictive
%}
clc, close all, clear all

fs = 10^3;
Ts = 1 / fs;

simulation_time = 1;
simulation_time_array = 0:Ts:simulation_time;

r = [0 0 0];
e = [0 0 0];
y = [0 0 0];
ym = [0 0];
u = [0 0 0];
t = [0 0 0];

am = 0.2;
bm = 0.2;
cm = 1;
a = -0.1; 
b = -0.1; 
c = 0.1; 

fsin = fs / fs;
wn = 2 * pi * fsin;
A = 1;

for k = 3:length(simulation_time_array) - 1
    t(k) = k * Ts;
    r(k) = A * sin(wn * t(k));
    
    ym(k) = cm * r(k - 2) - am * ym(k - 2) - bm * ym(k - 1);
    ym(k + 1) = cm * r(k - 1) - am * ym(k - 1) - bm * ym(k);
    ym(k + 2) =  cm * r(k) - bm * ym(k + 1) - am * ym(k) ;
 
    y(k) = c * u(k - 2)- a * y(k - 2) - b * y(k - 1);
    u(k) = (a * y(k) + b * ym(k + 1) +  ym(k + 2)) / c;
end

y(k + 1) = y(k);
y(k + 2) = y(k);
t(k + 1) = (k + 1) * Ts;
t(k + 2) = (k + 2) * Ts;
plot(t, ym)
hold
plot(t, y)

am = 0;
bm = 0;
cm = 1;
for k = 3:length(simulation_time_array) - 1
    t(k) = k * Ts;
    r(k) = A * sin(wn * t(k));
    
    ym(k) = cm * r(k - 2) - am * ym(k - 2) - bm * ym(k - 1);
    ym(k + 1) = cm * r(k - 1) - am * ym(k - 1) - bm * ym(k);
    ym(k + 2) =  cm * r(k) - bm * ym(k + 1) - am * ym(k) ;
 
    y(k) = c * u(k - 2)- a * y(k - 2) - b * y(k - 1);
    u(k) = (a * y(k) + b * ym(k + 1) +  ym(k + 2)) / c;
end

figure(2)
y(k + 1) = y(k);
y(k + 2) = y(k);
t(k + 1) = (k + 1) * Ts;
t(k + 2) = (k + 2) * Ts;
plot(t, ym)
hold
plot(t, y)
