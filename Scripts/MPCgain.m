function [phiTphi, phiTF, phiTRsBarra, RsBarra] = MPCgain(Ae, Be, Ce, Nc, Np)
% Np -> Horizonte de predicao
% Nc -> Horizonte de controle
    
    [Arows, Acols] = size(Ae);
    F = zeros(Np, Acols);
    phi = zeros(Np, Nc);
    RsBarra = ones(1, Np)';
 
    for i = 1:Np
        F(i, :) = Ce * Ae^i;
     
        for j = 1:Nc
            if i - j >= 0
                phi(i, j) = Ce * Ae^(i - j) * Be;
            end
        end
    end
    
    phiTphi = phi' * phi;
    phiTF = phi' * F;
    phiTRsBarra = phi' * RsBarra;
end

