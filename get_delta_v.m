function [delta_v] = get_delta_v(delta_i_A)
%///////////////////////////////////////////////////////////
% Functionality
%   Returns the total delta v of two manoeuvres given a delta in inclination 
% Parameters
%   delta_i_a [deg]: change of inclination a first manoeuvre
% Returns
%   delta_v [km/s]: total change in velocity
%///////////////////////////////////////////////////////////
    GM_Earth = 398600.4418; % km³/s²
    R_Earth = 6378.137; % km
    alt_park = 200; % km
    r_GEO = 42164; % km
    r_park = R_Earth + alt_park; % km

    delta_i_B = 51.6 - delta_i_A;
    
    v_negA = sqrt(GM_Earth / r_park);
    v_posA = sqrt(2 * GM_Earth * (1 / r_park - 1 / (r_park + r_GEO)));
    
    v_negB = sqrt(2 * GM_Earth * (1 / r_GEO - 1 / (r_park + r_GEO)));
    v_posB = sqrt(GM_Earth / r_GEO);

    delta_v_A = sqrt(v_negA^2 + v_posA^2 - 2 * v_negA * v_posA * cosd(delta_i_A));
    delta_v_B = sqrt(v_negB^2 + v_posB^2 - 2 * v_negB * v_posB * cosd(delta_i_B));

    delta_v = delta_v_A + delta_v_B;
end