function [R] = R_ECEF2TCS(lat_gs, lon_gs)
%///////////////////////////////////////////////////////////
% Functionality    
%   Returns a rotation matrix to rotate from ECEF (XYZ) to topocentric TCS cartesian coordinates (ENU)
%   r_TCS = R * (R_sat_ECEF - R_gs_ECEF)
% Parameters
%   lat_gs: geocentric latitude of ground station
%   lon_gs: geocentric longitude of ground station
% Returns
%   R: rotation matrix
%///////////////////////////////////////////////////////////
    R = [-sind(lon_gs), -sind(lat_gs) * cosd(lon_gs), cosd(lat_gs) * cosd(lon_gs);
          cosd(lon_gs), -sind(lat_gs) * sind(lon_gs), cosd(lat_gs) * sind(lon_gs);
          0,             cosd(lat_gs),                sind(lat_gs)];
end