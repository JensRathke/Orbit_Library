function [a, e, i, Omega, omega, nu] = ECI2OE(R_ECI, V_ECI)
    Gm_Earth = 398600.435507; % km³/s²
    r_ECI = norm(R_ECI);
    v_ECI = norm(V_ECI);
    
    % get specific angular momentum
    H_ECI = cross(R_ECI, V_ECI);
    h_ECI = norm(H_ECI);

    % get axis W
    W = H_ECI / h_ECI;

    % calculate i
    i = atan2d(sqrt(W(1)^2 + W(2)^2), W(3));

    if sqrt(W(1)^2 + W(2)^2) < 0 && W(3) < 0
        i = i + 360;
    end

    if i == 0 || i == 180
        ME = MException('Orbit elements for i = 0 deg and i = 180 deg are ambiguous.');
        throw(ME)
    end

    % calculate right ascention of the ascending node
    Omega = atan2d(W(1), -W(2));

    if W(1) < 0 && -W(2) < 0
        Omega = Omega + 360;
    end

    % calculate semi-parameter
    p = h_ECI^2 / Gm_Earth;

    % calculate semi-major axis
    a = 1 / (2 / r_ECI - v_ECI^2 / Gm_Earth);

    % calculate mean motion
    n = sqrt(Gm_Earth / a^3);

    % calculate eccentricity
    e = sqrt(1 - p / a);

    % calculate eccentric anomaly
    E = atan2d(dot(R_ECI, V_ECI) / (a^2 * n), 1 - r_ECI / a);

    if E < 0
        E = E + 360;
    end

    % calculate mean anomaly
    % M_rad = deg2rad(E) - e * sind(E);

    % calculate true anomaly
    if dot(R_ECI, V_ECI) > 0
        nu = acosd((p / r_ECI - 1) * 1 / e);
    else
        nu = 360 - acosd((p / r_ECI - 1) * 1 / e);
    end

    % calculate argument of latitude
    u = atan2d((R_ECI(3) / sind(i)), (R_ECI(1) * cosd(Omega) + R_ECI(2) * sind(Omega)));

    % calculate argument of periapsis
    omega = wrapTo360(u - nu);
end