function [fig] = plotTrajectory2D(X_traj, Y_traj, title_text, x_label_text, y_label_text, options)
%///////////////////////////////////////////////////////////
% Functionality    
%   Plots a 2D trajectory
% Parameters
%   X_traj: x coordinates
%   Y_traj: y coordinates
%   title_text:
%   x_label_text:
%   y_label_text:
%   (option)
% Returns
%   fig: figure handle
%///////////////////////////////////////////////////////////
    arguments 
        X_traj 
        Y_traj
        title_text
        x_label_text
        y_label_text
        options.plot_earth = false
        options.plot_focus_center = false
        options.plot_loa = false
        options.plot_legend = false
        options.plot_ticks = false
        options.X_tick = 0
        options.Y_tick = 0
        options.e = 0
        options.a = 1
        options.LineWidth = 1.0
        options.maximize = false
    end

    % figure
    if options.maximize
        fig = figure(WindowState='maximized');% units='normalized', outerposition=[0 0.05 1 0.95]);
    else
        fig = figure;
    end
    hold on
    axis equal

    % labels
    xlabel(x_label_text)
    ylabel(y_label_text)
    title(title_text)
    
    % plot trajectory
    traj = plot(X_traj, Y_traj);
    traj.LineWidth = options.LineWidth;
    traj.Color = '#A2142F';

    % plot ticks
    if options.plot_ticks
        ticks = scatter(options.X_tick(1), options.Y_tick(1), 'filled');
        ticks.MarkerFaceColor = '#08A045';
        ticks = scatter(options.X_tick(2:end-1), options.Y_tick(2:end-1), 'filled');
        ticks.MarkerFaceColor = 'black';
        ticks = scatter(options.X_tick(end), options.Y_tick(end), 'filled');
        ticks.MarkerFaceColor = '#FF7400';
    end

    % plot earth
    if options.plot_earth
        alpha = 0:pi/60:2*pi;
        x_earth = 6371 * cos(alpha);
        y_earth = 6371 * sin(alpha);
        earth = plot(x_earth, y_earth);
        earth.LineWidth = 1;
        earth.Color = '#0072BD';
    end

    % plot line of apsis
    if options.plot_loa
        x_loa = [min(X_traj) - 100, max(X_traj) + 100];
        y_loa = [0, 0];
        loa = plot(x_loa, y_loa);
        loa.LineWidth = 1;
        loa.Color = "black";
        loa.LineStyle = "--";
    end

    % plot focus and center
    if options.plot_focus_center
        focus = plot(0, 0, "x");
        focus.MarkerSize = 10;
        focus.Color = "black";
    
        center = plot(-options.e * options.a, 0, "o");
        center.MarkerSize = 8;
        center.Color = "black";
    end

    % legend
    if options.plot_legend == true && options.plot_ticks == true
        legend('orbit trajectory', 'start', 'orbit positions', 'end', 'earth', 'line of apsis', 'focus', 'center')
    elseif options.plot_legend == true && options.plot_ticks == false
        legend('orbit trajectory', 'earth', 'line of apsis', 'focus', 'center')
    end

    grid on
end