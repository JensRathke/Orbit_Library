function [lat, lon, h] = ECEF2GcCS(R_ECEF, options)
%///////////////////////////////////////////////////////////
% Functionality    
%   Converts a position vector in ECEF into geocentric coordinate system
% Parameters
%   R_ECEF: position vector in ECEF
%   (option) r_E [km]: Earth radius
% Returns
%   lat [deg]: geocentric latitude
%   lon [deg]: geocentric longitude
%   h [km]: geocentric altitude
%///////////////////////////////////////////////////////////
    arguments
        R_ECEF 
        options.r_E = 6378.1; % km
    end
    
    h = norm(R_ECEF) - options.r_E;

    lat = asind(R_ECEF(3) / sqrt(R_ECEF(1)^2 + R_ECEF(2)^2 + R_ECEF(3)^2));

    if R_ECEF(1) == 0 && R_ECEF(2) == 0
        lon = 0;
    else
        lon = atan2d(R_ECEF(2), R_ECEF(1));
    end
end