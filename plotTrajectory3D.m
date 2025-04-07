function [fig] = plotTrajectory3D(r_C, X_traj, Y_traj, Z_traj, title_text, x_label_text, y_label_text, z_label_text, options)
    arguments
        r_C 
        X_traj 
        Y_traj
        Z_traj        
        title_text
        x_label_text
        y_label_text
        z_label_text
        options.plot_ticks = false
        options.X_tick = 0
        options.Y_tick = 0
        options.Z_tick = 0
    end

    % figure
    fig = figure;
    view(3)
    hold on
    axis equal
    grid on

    % labels
    title(title_text)
    xlabel(x_label_text)
    ylabel(y_label_text)
    zlabel(z_label_text)
    
    % plot trajectory
    traj = plot3(X_traj, Y_traj, Z_traj);
    traj.LineWidth = 2;
    traj.Color = '#00B0F0';

    % plot ticks
    if options.plot_ticks
        ticks = scatter3(options.X_tick(1), options.Y_tick(1), options.Z_tick(1), 'filled');
        ticks.MarkerFaceColor = '#08A045';
        ticks = scatter3(options.X_tick(2:end-1), options.Y_tick(2:end-1), options.Z_tick(2:end-1), 'filled');
        ticks.MarkerFaceColor = 'black';
        ticks = scatter3(options.X_tick(end), options.Y_tick(end), options.Z_tick(end), 'filled');
        ticks.MarkerFaceColor = '#FF7400';
    end

    % plot central body
    [xC, yC, zC] = ellipsoid(0, 0, 0, r_C, r_C, r_C, 20);
    surface(xC, yC, zC, 'FaceColor', 'blue', 'EdgeColor', 'black');
end