%% Initialization
clear; close all; clc

%% Global
r_E = 6378.1; % km // equatorial earth radius
e_E = 0.0818; % earth eccentricity
Gm_Earth = 398600.435507; % km³/s²
J2_Earth = 1.08262668e-3;
AU = 1.495978707e+8; % km // astronomical unit

%% Orbit Elements
select = 1;

if select == 1
    % eccentricity
    e = 0.0001971;
    % semi-major axis
    a = 7155.81; % km
    % Right ascension of the ascending node
    Omega = 230.875; % deg
    % argument of periapsis
    omega = 93.069; % deg
    % inclination
    incl = 86.403; % deg
    % Mean anomaly at epoch
    M_0 = 267.074;
elseif select == 2
    R_ECI = [3727.9; -826.3; -7693.2]; % km
    V_ECI = [4.0256; 7.8002; -0.8610]; % km/s
    [a, e, incl, Omega, omega, nu] = ECI2OE(R_ECI, V_ECI);
    [oes, aux, stats] = completeOEs(a=a, e=e, incl=incl, nu=nu);
    M_0 = aux.M_0;
end

fprintf('Eccentricity: %f.\n', e)
fprintf('Semi-major axis: %f km.\n', a)
fprintf('RAAN: %f deg.\n', Omega)
fprintf('Argument of periapsis: %f deg.\n', omega)
fprintf('Inclination: %f deg.\n', incl)
fprintf('Mean anomaly at epoch: %f deg.\n', M_0)


% mean motion
n = sqrt(Gm_Earth / a^3);
fprintf('Mean motion: %f rad/s.\n', n)



%% Simulation
t_start = 0; % s
t_stop = 12 * 60 * 60; % s
t_step = 1; % s
M_init = M_0;
MJD_init_UT1 = 60372;
out = sim("Orbit_Simulation.slx");

% orbit speed
v = sqrt(Gm_Earth * (2 ./ out.r_PCS.data - 1 / a));

%% Plotting
% Parameters
plot_ticks = true;

% Plot
if plot_ticks
    fig = plotGroundTrack(out.geod_lat.data, out.geod_lon.data, "Satellite Groundtrack from " + t_start + " to " + t_stop + " sec", "Longitude [deg]", "Latitude [deg]", plot_arrows=true, plot_ticks=true, lat_tick=out.geod_lat.data(1:3600:end), lon_tick=out.geod_lon.data(1:3600:end));
    
    plotTrajectory3D(r_E, out.I.data, out.J.data, out.K.data, "Orbit Trajectory in ECI", 'I [km]', 'J [km]', 'K [km]', plot_ticks=true, X_tick=out.I.data(1:3600:end), Y_tick=out.J.data(1:3600:end), Z_tick=out.K.data(1:3600:end));
    
    plotTrajectory3D(r_E, out.X.data, out.Y.data, out.Z.data, "Orbit Trajectory in ECEF", 'X [km]', 'Y [km]', 'Z [km]', plot_ticks=true, X_tick=out.X.data(1:3600:end), Y_tick=out.Y.data(1:3600:end), Z_tick=out.Z.data(1:3600:end));

    plotTrajectory2D(out.P.data, out.Q.data, "Orbit in PCS", "P [km]", "Q [km]", plot_ticks=true, X_tick=out.P.data(1:3600:end), Y_tick=out.Q.data(1:3600:end), plot_loa=true, plot_earth=true, plot_focus_center=true, a=a, e=e, plot_legend=true);
else
    fig = plotGroundTrack(out.geod_lat.data, out.geod_lon.data, "Satellite Groundtrack from " + t_start + " to " + t_stop + " sec", "Longitude [deg]", "Latitude [deg]", plot_arrows=true);
    
    plotTrajectory3D(r_E, out.I.data, out.J.data, out.K.data, "Orbit Trajectory in ECI", 'I [km]', 'J [km]', 'K [km]');
    
    plotTrajectory3D(r_E, out.X.data, out.Y.data, out.Z.data, "Orbit Trajectory in ECEF", 'X [km]', 'Y [km]', 'Z [km]');

    plotTrajectory2D(out.P.data, out.Q.data, "Orbit in PCS", "P [km]", "Q [km]");
end

plotGraph(out.time.data, v, "orbit velocity over time", "time [s]", "orbit velocity [km/s]");

% saveas(fig, 'fig.png');