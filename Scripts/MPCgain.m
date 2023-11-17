function [phiTphi, phiTF, phiTR] = MPCgain(Ap, Bp, Cp, Nc, Np)
% Np -> Horizonte de predicao
% Nc -> Horizonte de controle
    
    [Arows, Acols] = size(Ap);
    F = zeros(Np, Acols);
    phi = zeros(Np, Nc);
    R = ones(1, Np)';
 
    for i = 1:Np
        F(i, :) = Cp * Ap^i;
     
        for j = 1:Nc
            if i - j >= 0
                phi(i, j) = Cp * Ap^(i - j) * Bp;
            end
        end
    end
    
    phiTphi = phi' * phi;
    phiTF = phi' * F;
    phiTR = phi' * R;
end

