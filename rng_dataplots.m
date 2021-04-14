function [] = rng_statisticplots(d)
% Generate some simple statistic plots from a given dataset
%   Syntax:    [] = rng_statisticplot(d)
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
    
    % create new figure
    fh = figure;

    % set some parameters for the current figure
    if dumpfigure 
        set(gcf,'WindowStyle','normal')
        set(gcf, 'Position', get(0, 'Screensize'));
        set(gcf,'color','w');
    end
    
    figname     = 'Data Plots';
    ftname      = [figname '-' FILE];
    fpfilename    = [PICDIR, ftname, '.png']; % save as bitmapformat
    fvfilename    = [PICDIR, ftname, '.pdf']; % save as vectorformat
    
    % raw data
    subplot(2,1,1);
    plot(d);
    sa = gca;
    sa.XAxis.Visible = 'off';
    sa.YAxis.Visible = 'off';
    sa.XLim = [0 numel(d)];
    %sa.Ylim = [-1.1 1.1];
    title('Rohdaten');
    
    % absolutvalues
%     subplot(2,1,2);
%     plot(abs(d));
%     sa = gca;
%     sa.XAxis.Visible = 'off';
%     sa.YAxis.Visible = 'off';
%     sa.XLim = [0 numel(d)];
%     title('Absolutwerte');
        
    sgtitle(ftname);
    
    % if the figure should be saved run this code
    if dumpfigure 
         exportgraphics(gcf, strjoin(fvfilename), 'Resolution', 600, 'BackgroundColor','none','ContentType','vector'); 
         exportgraphics(gcf, strjoin(fpfilename), 'Resolution', 300, 'BackgroundColor','w');
         close(figure(fh));
    end
end
