function [R_TCS] = TCSpolar2cart(r_TCS, A, E)
%///////////////////////////////////////////////////////////
% Functionality    
%   Converts topocentric TCS polar coordinates (rAE) to cartesian coordinates (ENU)
% Parameters
%   r_TCS: distance from ground to spacecraft
%   A [deg]: azimuth
%   E [deg]: elevation
% Returns
%   R_TCS: position vector from ground with values for ENU
%///////////////////////////////////////////////////////////
    R_TCS = r_TCS * [sind(A) * cosd(E); cosd(A) * cosd(E); sind(E)];
end