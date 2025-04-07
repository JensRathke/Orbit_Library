function [lat_prime, lon, h_prime] = ECEF2GdCS(R_ECEF, options)
%///////////////////////////////////////////////////////////
% Functionality    
%   Converts a position vector in ECEF into geodetic coordinate system
% Parameters
%   R_ECEF: position vector in ECEF
%   (option) r_E [km]: Earth radius
%   (option) e_E: Earth eccentricity
%   (option) tol: approximation tolerance threshold
%   (option) print: print approximation step results
% Returns
%   lat_prime [deg]: geodetic latitude
%   lon [deg]: geodetic longitude
%   h_prime [km]: geodetic altitude
%///////////////////////////////////////////////////////////
    arguments
        R_ECEF 
        options.r_E = 6378.1; % km
        options.e_E = 0.0818;
        options.tol = 1e-10;
        options.print = false;
    end

    r_XY = sqrt(R_ECEF(1)^2 + R_ECEF(2)^2);

    % 1) longitude from geocentric longitude
    if R_ECEF(1) == 0 && R_ECEF(2) == 0
        lon = 0;
    else
        lon = atan2d(R_ECEF(2), R_ECEF(1));
    end
    
    % 2) geocentric latitude as first guess for geodetic latitude
    lat_prime = asind(R_ECEF(3) / sqrt(R_ECEF(1)^2 + R_ECEF(2)^2 + R_ECEF(3)^2));

    i = 1;
    while 1
        % 3) modified radius of curvature
        N = options.r_E / sqrt(1 - options.e_E^2 * sind(lat_prime)^2);

        % 4) update geodetic latitude
        lat_new = atan2d((R_ECEF(3) + N * options.e_E^2 * sind(lat_prime)), r_XY);
        delta = lat_prime - lat_new;
        lat_prime = lat_new;
        if options.print, fprintf('>> Iteration %i: lat: %f deg\n', i, lat_prime), end
        
        i = i + 1;
        
        % 5) check tolerance
        if abs(delta) <= options.tol || i > 20
            break
        end
    end

    % 6) compute altitude
    h_prime = r_XY / cosd(lat_prime) - N;
end