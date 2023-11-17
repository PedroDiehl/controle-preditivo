%{
Pedro Henrique Diehl
Controle Preditivo
%}
clc, close all, clear all

a = 0.8;
b = 0.1;

Am = a; 
Bm = b;
Cm = 1; 

Nc = 4;
Np = 10;

[Ap, Bp, Cp, Dp] = MPCmodel(Am, Bm, Cm);
[phiTphi, phiTF, phiTR] = MPCgain(Ap, Bp, Cp, Nc, Np)
