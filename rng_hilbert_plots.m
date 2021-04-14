function [] = rng_hilbert_plots(d)
% Generate some Hilbert plots from a given dataset
%   Syntax:    [] = rng_hilbert_plots(d)
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
    d = double(d);
    num = numel(d);
    
    % calculate hilbert
    hi = hilbert(d);
    
    % create new figure
    fh = figure;

    % set some parameters for the current figure
    if dumpfigure 
        set(gcf,'WindowStyle','normal')
        set(gcf, 'Position', get(0, 'Screensize'));
        set(gcf,'color','w');
    end
    
    figname     = 'Hilbert Transformation';
    ftname      = [figname '-' FILE];
    fpfilename    = [PICDIR ftname '.png']; % save as bitmapformat
    fvfilename    = [PICDIR ftname '.pdf']; % save as vectorformat
    
    % hilbert realpart
    subplot(3,1,1);
    plot(1:num, real(hi)); 
    sa = gca;
    sa.YAxis.Visible = 'off';
    sa.XLim = [0 num];
    %sa.YScale = 'log';    
    title('Hilbert Realteil');
    
    % hilbert absolut
    subplot(3,1,2);
    plot(1:num, abs(hi)); 
    sa = gca;
    sa.YAxis.Visible = 'off';
    sa.XLim = [0 num];
    %sa.YScale = 'log';    
    title('Hilbert Betrag');
    
    % holbert angle
    subplot(3,1,3);
    plot(1:num, angle(hi)); 
    sa = gca;
    sa.YAxis.Visible = 'off';
    sa.XLim = [0 num];
    %sa.YScale = 'log';    
    title('Hilbert phase');
        
    sgtitle(ftname);
    
    % if the figure should be saved run this code
    if dumpfigure 
        exportgraphics(gcf, strjoin(fvfilename), 'Resolution', 600, 'BackgroundColor','none','ContentType','vector'); 
        exportgraphics(gcf, strjoin(fpfilename), 'Resolution', 300, 'BackgroundColor','w');
        close(figure(fh));
        set(gcf,'WindowStyle','docked')
    end
end
