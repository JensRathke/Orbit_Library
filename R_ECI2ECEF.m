function [R] = R_ECI2ECEF(GMST)
%///////////////////////////////////////////////////////////
% Functionality    
%   Returns a rotation matrix from ECI to ECEF by GMST without
%   perturbations
% Parameters
%   GMST [d]: Greenwich Mean Standard Time
% Returns
%   R: rotation matrix
%///////////////////////////////////////////////////////////
    R = [cosd(GMST), sind(GMST), 0; -sind(GMST), cosd(GMST), 0; 0, 0, 1];
end