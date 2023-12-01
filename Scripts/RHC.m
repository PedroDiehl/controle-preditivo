%{
Pedro Henrique Diehl
Controle Preditivo
Controlador RHC - Recending Horizon Control
%}
clc, close all, clear all

Ap = [1 1; 0 1];
Bp = [0.5; 1];
Cp = [1 0];
Dp = [0];

Nc = 4;
Np = 20;

r = [1];
u = [0];
y = [0];

xm = [0; 0];
% Xf = Deltaxm; y]
Xf = [xm; y];

%{
DeltaU contenha as ações de controle Deltau(k), Deltau(k+1),
Deltau(k+2), ..., Deltau(k+Nc?1),
%}
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

rw = 20;
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

figure(2);
plot(r)
hold on
plot(y)

rw = 200;
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

figure(3);
plot(r)
hold on
plot(y)
