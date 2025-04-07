function [R_ECEF] = GdCS2ECEF(r_E, e_E, h_prime, lat_prime, lon)
%///////////////////////////////////////////////////////////
% Functionality    
%   transforms geodetic coordinates to ECEF
% Parameters
%   r_E: Earth radius
%   e_E: Earth eccentricity
%   h_prime: geodetic altitude
%   lat_prime [deg]: geodetic latitude
%   lon [deg]: geodetic longitude
% Returns
%   R_ECEF: position vector in ECEF
%///////////////////////////////////////////////////////////
    N = r_E / sqrt(1 - e_E^2 * sin(lat_prime)^2);
    
    R_ECEF = [(N + h_prime) * cosd(lat_prime) * cosd(lon); (N + h_prime) * cosd(lat_prime) * sind(lon); (N * (1 - e_E^2) + h_prime) * sind(lat)];
end