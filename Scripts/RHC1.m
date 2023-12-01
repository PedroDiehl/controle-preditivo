%{
Pedro Henrique Diehl
Controle Preditivo
Controlador RHC - Recending Horizon Control
%}
clc, close all, clear all


a = 0.8;
b = 0.1;
c = 1;
d = 0;

Ap = [a];
Bp = [b];
Cp = [c];
Dp = [d];

Nc = 4;
Np = 20;

r = [1];
u = [0];
y = [0];

xm = [0; 1];
% Xf = Deltaxm; y]
Xf = [xm; y];

deltau = [0];

[Ae, Be, Ce, De] = MPCmodel(Ap, Bp, Cp, Dp);
[phiTphi, phiTF, phiTRsBarra, RsBarra] = MPCgain(Ae, Be, Ce, Nc, Np);

numero_amostras = 100;

rw = 0.1;
for k = 2:numero_amostras
    r(k) = 1;

    Rbarra = rw * eye(Nc, Nc);
    Rs = RsBarra * r(k);
    
    DeltaU = inv(phiTphi + Rbarra) * (phiTRsBarra * r(k) - phiTF * Xf);
    
    Deltau(k) = DeltaU(1, 1);
    u(k) = u(k - 1) + Deltau(k);
    
    xm(1:2, k) = Ap * xm(1:2, k - 1) + Bp * u(k); 
    y(k) = Cp * xm(1:2, k); 
    
    Xf = [xm(1:2, k) - xm(1:2, k - 1); y(k)];
end

plot(r)
hold on
plot(y)
