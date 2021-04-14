function [] = rng_pol_scatter_plots(d)
% Generate some polar (scatter) plots from a given dataset
%   Syntax:    [] = rng_pol_scatter_plots(d)
%   Input:      d - vector or matrix to process
%   Output:     none
% ------------------------------------------------------------------------
% (c) 2021 Andreas Huemmer <andreas.huemmer@sysopsec.de>
%   v 1.0     initial version 
% ------------------------------------------------------------------------
    % use global variables
    global PICDIR;
    global FILE;
    global dumpfigure;
    
    % precomputings
    mat2rd =  vec2mat(d, 2);
    mat3rd =  vec2mat(d, 3);
    [p3dx, p3dy, p3dz]    =  sph2cart(double(mat3rd(:,1)), double(mat3rd(:,2)),double(mat3rd(:,3)));
    
    spz   = 1;          % size of points for the scaterplots  
    axmaxrx = max(d(:,2));     % no gca beyond data
    axmaxxr = max(d(:,1));     % no gca beyond data
    axmax   = max(p3dx(:,1));
    
    % create new figure
    fh = figure;

    % set some parameters for the current figure
    if dumpfigure 
        set(gcf,'WindowStyle','normal')
        set(gcf, 'Position', get(0, 'Screensize'));
        set(gcf,'color','w');
    end
    
    figname     = 'Polar Scatter Plots';
    ftname      = [figname '-' FILE];
    fpfilename    = [PICDIR ftname '.png']; % save as bitmapformat
    fvfilename    = [PICDIR ftname '.pdf']; % save as vectorformat
    
    % polarscatter 2d x-r
    subplot(2,2,1);
    polarscatter(mat2rd(:,1), mat2rd(:,2), spz, '.');
    sa = gca;
    %axis square;
    %sa.XAxis.Visible = 'off';
    %sa.YAxis.Visible = 'off';
    %sa.XLim = [0 axmax];
    %sa.YLim = [0 axmax];
    title('x-r scatter');
    
    % polarscatter 2d r-x
     subplot(2,2,2);
     polarscatter(mat2rd(:,2), mat2rd(:,1), spz, '.');    
     sa = gca;
%     axis square;
    %sa.XAxis.Visible = 'off';
    %sa.YAxis.Visible = 'off';
    %sa.XLim = [0 axmax];
    %sa.YLim = [0 axmax];
    title('r-x scatter');

    % scatter 2d y-z
%     subplot(2,2,3);
%     scatter(mat3d(:,2), mat3d(:,3), spz, '.');
%     sa = gca;
%     axis square;
%     sa.XAxis.Visible = 'off';
%     sa.YAxis.Visible = 'off';
%     sa.XLim = [0 axmax];
%     sa.YLim = [0 axmax];
%     title('y-z scatter');
%     
    % polarscatter 3d
    subplot(2,2,[3 4]);
    plot3(p3dx, p3dy, p3dz, '.')
    sa = gca;
    axis square;
    sa.XAxis.Visible = 'off';
    sa.YAxis.Visible = 'off';
    sa.ZAxis.Visible = 'off';
    sa.XLim = [-axmax axmax];
    sa.YLim = [-axmax axmax];
    sa.ZLim = [-axmax axmax];
    grid on;
    zoom(1.1);
    title('3D polarscatter');
        
    sgtitle(ftname);
    
    % if the figure should be saved run this code
    if dumpfigure 
        exportgraphics(gcf, strjoin(fvfilename), 'Resolution', 600, 'BackgroundColor','none','ContentType','vector'); 
        exportgraphics(gcf, strjoin(fpfilename), 'Resolution', 300, 'BackgroundColor','w');
        close(figure(fh));
        set(gcf,'WindowStyle','docked')
    end
end
