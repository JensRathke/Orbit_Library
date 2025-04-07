function [R_ECEF] = GcCS2ECEF(r_E, h, lat, lon)
%///////////////////////////////////////////////////////////
% Functionality    
%   transforms geocentric coordinates to ECEF
% Parameters
%   r_E: Earth radius
%   h: geocentric altitude
%       (r = r_Earth + h)
%   lat [deg]: geocentric latitude
%   lon [deg]: geocentric longitude
% Returns
%   R_ECEF: position vector in ECEF
%///////////////////////////////////////////////////////////
    R_ECEF = (r_E + h) * [cosd(lat) * cosd(lon); cosd(lat) * sind(lon); sind(lat)];
end