function [fig] = plotGroundTrack(lat, lon, title_text, x_label_text, y_label_text, options)
    arguments
        lat, lon, title_text, x_label_text, y_label_text
        options.LineColor = '#00B0F0'
        options.LineStyle = '-'
        options.LineWidth = 1.5
        options.plot_ticks = false
        options.lat_tick = 0
        options.lon_tick = 0
        options.plot_arrows = false
    end

    %% options
    LineColor = options.LineColor;
    LineStyle = options.LineStyle;
    LineWidth = options.LineWidth;
    plot_ticks = options.plot_ticks;
    lat_tick = options.lat_tick;
    lon_tick = options.lon_tick;
    plot_arrows = options.plot_arrows;
    
    %% figure
    fig = figure;
    hold on
    axis equal
    grid on

    % axis formatting
    xlim([-180,180]);
    xticks(-180:30:180);
    ylim([-90,90]);
    yticks(-90:30:90);

    title(title_text);
    xlabel(x_label_text);
    ylabel(y_label_text);
    
    %% background of ground track plot
    % loads Earth topographic data
    load('topo.mat','topo');
    
    % rearranges topopgrahic data so it goes from -180 to 180
    topoplot = [topo(:,181:360),topo(:,1:180)];
    
    % plots Earth map by making a contour plot of topographic data with elevation of 0
    contour(-180:179,-90:89,topoplot,[0,0], color='#808080');
    
    %% plot ground track
    % determine indices where ground track crosses figure border
    jumps = [1];
    for index = 2:length(lon)
        if ((lon(index) > 170) && (lon(index-1) < -170)) || ((lon(index) < -170) && (lon(index-1) > 170))
            jumps = [jumps, index];
        end
    end
    
    % add last index to "j" in order to plot ground track between last
    % figure border crossing and the last input longitude
    jumps = [jumps, length(lon)];
    
    % plot groundtrack
    for index = 1:(length(jumps)-1)
        section_lon = lon(jumps(index):(jumps(index+1)-1));
        section_lat = lat(jumps(index):(jumps(index+1)-1));
        
        plot(section_lon, section_lat, Color=LineColor, LineStyle=LineStyle, LineWidth=LineWidth);
        
        if plot_arrows
            arrowh(section_lon, section_lat, 'black', [80, 30], 50);
        end
    end

    % plot ticks
    if plot_ticks
        ticks = scatter(lon_tick(1), lat_tick(1), 'filled');
        ticks.MarkerFaceColor = '#08A045';
        ticks = scatter(lon_tick(2:end-1), lat_tick(2:end-1), 'filled');
        ticks.MarkerFaceColor = 'black';
        ticks = scatter(lon_tick(end), lat_tick(end), 'filled');
        ticks.MarkerFaceColor = '#FF7400';
    end
end