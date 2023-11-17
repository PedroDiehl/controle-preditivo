%{
Pedro Henrique Diehl
Controle Preditivo
Modelo expandido
%}
clc, close all, clear all

Ts = 1;

Ac = [0 1 0; 3 0 1; 0 1 0];
Bc = [1; 1; 3]; 
Cc = [0 1 0];
Dc = [0];

% Discretiza as matrizes
[Ad, Bd, Cd, Dd] = c2dm(Ac, Bc, Cc, Dc, Ts);

[Ae, Be, Ce, De] = MPCmodel(Ad, Bd, Cd)
