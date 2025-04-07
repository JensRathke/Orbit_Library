function [R_ECI, V_ECI] = OE2ECI(a, e, i, Omega, omega, nu)
    Gm_Earth = 398600.435507; % km³/s²
    
    % get ellipsis parameters
    r_p = a * (1 - e);
    %r_a = a * (1 + e);

    p = r_p * (1 + e);

    % get position and velocity relative to PQW
    r = p / (1 + e * cosd(nu));
    %epsilon = - Gm_Earth / (2 * a);
    v = sqrt((2 * Gm_Earth / r) - (Gm_Earth / a));
    %h = sqrt(Gm_Earth * p);

    phi_flightpath = atand((e * sind(nu)) / (1 + e * cosd(nu)));

    R_PCS = [r * cosd(nu); r * sind(nu); 0];
    %H_PCS = [0; 0; h];
    V_PCS = [v * cosd(nu + 90 - phi_flightpath); v * sind(nu + 90 - phi_flightpath); 0];

    %H_PCS_check = cross (R_PCS, V_PCS);

    % transform perifocal PCS (PQW) to earth centric inertial ECI (IJK)
    R_ECI = R_zd(-Omega) * R_xd(-i) * R_zd(-omega) * R_PCS;
    V_ECI = R_zd(-Omega) * R_xd(-i) * R_zd(-omega) * V_PCS;
end

function R_x = R_xd(a)
    R_x = [1, 0, 0; 0, cosd(a), sind(a); 0, -sind(a), cosd(a)];
end

function R_z = R_zd(a)
    R_z = [cosd(a), sind(a), 0; -sind(a), cosd(a), 0; 0, 0, 1];
end