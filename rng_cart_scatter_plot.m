function [] = rng_cart_scatter_plots(d)
% Generate some cartesian (scatter) plots from a given dataset
%   Syntax:    [] = rng_cart_scatter_plot(d)
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
    % split the datavector into a 3d matrix (skip the last datapoints
    % if 3 does not divide numel
    %mat3d = reshape(d(1:floor(numel(d)/3)*3), 3,[]);
    mat3d =  vec2mat(d, 3);
    spz   = 1;          % size of points for the scaterplots  
    axmax = max(d);     % no gca beyond data
    
    % create new figure
    fh = figure;

    % set some parameters for the current figure
    if dumpfigure 
        set(gcf,'WindowStyle','normal')
        set(gcf, 'Position', get(0, 'Screensize'));
        set(gcf,'color','w');
    end
    
    figname     = 'Kartesian Scatter Plots';
    ftname      = [figname '-' FILE];
    fpfilename    = [PICDIR ftname '.png']; % save as bitmapformat
    fvfilename    = [PICDIR ftname '.pdf']; % save as vectorformat
    
    % scatter 2d x-y
    subplot(2,2,1);
    scatter(mat3d(:,1), mat3d(:,2), spz, '.');
    %scatterhist(mat3d(:,1), mat3d(:,2),'NBins',[255,255],'Marker','.');
    sa = gca;
    %axis square;
    sa.XAxis.Visible = 'off';
    sa.YAxis.Visible = 'off';
    sa.XLim = [0 axmax];
    sa.YLim = [0 axmax];
    title('x-y scatter');
    
    % scatter 2d x-z
    subplot(2,2,2);
    scatter(mat3d(:,1), mat3d(:,3), spz, '.');    
    %scatterhist(mat3d(:,1), mat3d(:,3),'NBins',[255,255],'Marker','.');
    sa = gca;
    %axis square;
    sa.XAxis.Visible = 'off';
    sa.YAxis.Visible = 'off';
    sa.XLim = [0 axmax];
    sa.YLim = [0 axmax];
    title('x-z scatter');

    % scatter 2d y-z
    subplot(2,2,3);
    scatter(mat3d(:,2), mat3d(:,3), spz, '.');
    %scatterhist(mat3d(:,2), mat3d(:,3),'NBins',[255,255],'Marker','.');
    sa = gca;
    %axis square;
    sa.XAxis.Visible = 'off';
    sa.YAxis.Visible = 'off';
    sa.XLim = [0 axmax];
    sa.YLim = [0 axmax];
    title('y-z scatter');
    
    % scatter 3d
    subplot(2,2,4);
    scatter3(mat3d(:,1), mat3d(:,2), mat3d(:,3), spz, '.');
    sa = gca;
    %axis square;
    sa.XAxis.Visible = 'off';
    sa.YAxis.Visible = 'off';
    sa.ZAxis.Visible = 'off';
    sa.XLim = [0 axmax];
    sa.YLim = [0 axmax];
    sa.ZLim = [0 axmax];
    grid on;
    title('3D scatter');
        
    sgtitle(ftname);
    
    % if the figure should be saved run this code
    if dumpfigure 
        exportgraphics(gcf, strjoin(fvfilename), 'Resolution', 600, 'BackgroundColor','none','ContentType','vector'); 
        exportgraphics(gcf, strjoin(fpfilename), 'Resolution', 300, 'BackgroundColor','w');
        close(figure(fh));
        set(gcf,'WindowStyle','docked')
    end
end
