function [Ae, Be, Ce, De] = MPCmodel(Ap, Bp, Cp, Dp)
% MPC - Model Predictive Control
    % Espaço de estados aumentado

    om = zeros(1, length(Cp));
   
    Ae = [Ap om'; (Cp * Ap) 1];
    Be = [Bp; (Cp * Bp)];
    Ce = [om 1];
    De = [0];
end
