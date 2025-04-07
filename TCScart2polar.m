function [r_TCS, A, E] = TCScart2polar(R_TCS)
%///////////////////////////////////////////////////////////
% Functionality    
%   Converts topocentric TCS cartesian coordinates (ENU) to polar coordinates (rAE)
% Parameters
%   R_TCS: position vector from ground with values for ENU
% Returns
%   r_TCS: distance from ground to spacecraft
%   A [deg]: azimuth
%   E [deg]: elevation
%///////////////////////////////////////////////////////////
    % distance
    r_TCS = norm(R_TCS);

    % azimuth
    A = atan2d(R_TCS(1), r_TCS(2));

    % elevation
    E = atan2d(R_TCS(3), sqrt(R_TCS(1)^2 + R_TCS(2)^2));
end