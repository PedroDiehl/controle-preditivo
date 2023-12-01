%{
Pedro Henrique Diehl
Controle Preditivo
Controlador RHC - Recending Horizon Control
%}
clc, close all, clear all


fs = 1e3;
Ts = 1 / fs;

simulation_time = 2;
simulation_time_array = 0:Ts:simulation_time;

B = 1.5e-4; % Nms/rad > Atrito mecânico
J = 2e-5; % kgm^3 > Constante de inércia
Ra = 0.125; % Ohm > Resistência da armadura
La = 10e-3; % H > Indutância de armadura
Kt = 0.05; % Constante de torque do motor
Kv = 0.05; % Constante de tensão do motor

num = [(Kt * Kv / (La * B))];
den = [1 (B / J + Ra / La) ((Ra * B + Kt * Kv) / (La * J))];

G = tf(num, den);

GpssObs = canon(G,'companion');
GpssObsA = GpssObs.A;
GpssObsB = GpssObs.B;
GpssObsC = GpssObs.C;
GpssObsD = GpssObs.D;
GpssConA = GpssObsA.';
GpssConB = GpssObsC.';
GpssConC = GpssObsB.';
GpssConD = GpssObsD;

[Ad, Bd, Cd, Dd] = c2dm(GpssConA, GpssConB, GpssConC, GpssConD, Ts, 'zoh');

Nc = 4;
Np = 20;

r = [1];
u = [0];
y = [0];

xm = [0; 0];
% Xf = Deltaxm; y]
Xf = [xm; y];

A = 2;
fsin = 1;
wn = 2 * pi * fsin;
for k = 2:length(simulation_time_array) - 1
    t(k) = k * Ts;
    r(k) = A * sin(wn * t(k));

    Rbarra = rw * eye(Nc, Nc);
    Rs = RsBarra * r(k);
    
    DeltaU = inv(phiTphi + Rbarra) * (phiTRsBarra * r(k) - phiTF * Xf);
    
    Deltau(k) = DeltaU(1, 1);
    u(k) = u(k - 1) + Deltau(k);
    
    xm(1:2, k) = Ap * xm(1:2, k - 1) + Bp * u(k); 
    y(k) = Cp * xm(1:2, k); 
    
    Xf = [xm(1:2, k) - xm(1:2, k - 1); y(k)];
end

plot(t, ym)
hold
plot(t, y)
