function [GMST] = MJD2GMST(MJD)
    % % calculate time argument T (Montenbruck 5.18 & 5.20)
    % JD_0 = floor(MJD) + 2400000.5;
    % T_0 = (JD_0 - 2451545) / 36525;
    % JD = MJD + 2400000.5;
    % T = (JD - 2451545) / 36525;
    % 
    % UT1 = JD;
    % 
    % % calculate GMST (Montenbruck 5.19)
    % GMST = 24110.54841 + 8640184.812866 * T_0 + 1.002737909350795 * UT1 + 0.093104 * T^2 - 0.0000062 * T^3;
    % GMST = mod(GMST, 86400.002);
    % GMST = GMST / 86400.002 * 2 * pi;

    % Calculation according to Lecture 7 Slide 7
    d = MJD - 51544.5;
    GMST = 280.4606 + 360.9856473 * d;
    GMST = mod(GMST, 360);
end