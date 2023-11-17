function [Ae, Be, Ce, De] = MPCmodel(Am, Bm, Cm)
% MPC - Model Predictive Control
    % Espaço de estados aumentado

    om = zeros(1, length(Cm));
   
    Ae = [Am om'; (Cm * Am) 1];
    Be = [Bm; (Cm * Bm)];
    Ce = [om 1];
    De = [0];
end
