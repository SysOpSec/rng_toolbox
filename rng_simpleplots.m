function [] = rng_simpleplots(d)
% Generate some simple plots from a given dataset
%   Syntax:    [] = rng_statistics(d)
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
    % adjust accorting to samplecount
    s_limit     = floor(sqrt(numel(d)));
    
    % split it as we need it and form some basic underlyings
    matsquare   = vec2mat(d,s_limit);
    xyrange     = 1:s_limit;
    [X,Y]       = meshgrid(xyrange); % this creates a grid of X and Y values
    
    % create new figure
    fh = figure;

    % set some parameters for the current figure
    if dumpfigure 
        set(gcf,'WindowStyle','normal')
        set(gcf, 'Position', get(0, 'Screensize'));
        set(gcf,'color','w');
    end
    
    figname     = 'Simple Plots';
    ftname      = [figname '-' FILE];
    fpfilename    = [PICDIR ftname '.png']; % save as bitmapformat
    fvfilename    = [PICDIR ftname '.pdf']; % save as vectorformat
    
    % colorbar
    subplot(3,4,[1 4]);
    imagesc(d);
    %colormap(hst);
    sa = gca;
    %axis square;
    sa.XAxis.Visible = 'off';
    sa.YAxis.Visible = 'off';
    title('Colorbar');
    
    % color 2D image
    subplot(3,4,[5 6 9 10]);
    imagesc(matsquare);
    sa = gca;
    %axis square;
    sa.XAxis.Visible = 'off';
    sa.YAxis.Visible = 'off';
    title('Color(ed) noise');

    % contourplot 2D image
    subplot(3,4,[7 8 11 12]);
    contour(xyrange,xyrange,matsquare);
    sa = gca;
    %axis square;
    sa.XAxis.Visible = 'off';
    sa.YAxis.Visible = 'off';
    sa.YDir = 'reverse';
    title('Conturplot');
       
    sgtitle(ftname);
    
    % if the figure should be saved run this code
    if dumpfigure 
        exportgraphics(gcf, strjoin(fvfilename), 'Resolution', 600, 'BackgroundColor','none','ContentType','vector'); 
        exportgraphics(gcf, strjoin(fpfilename), 'Resolution', 300, 'BackgroundColor','w');
        close(figure(fh));
    end
end
