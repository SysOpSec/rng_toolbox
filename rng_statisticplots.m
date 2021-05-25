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
    
    figname     = 'Statistic Plots';
    ftname      = [figname '-' FILE];
    fpfilename    = [PICDIR, ftname, '.png']; % save as bitmapformat
    fvfilename    = [PICDIR, ftname, '.pdf']; % save as vectorformat
    
    % raw data
    subplot(3,2,[1 2]);
    plot(d);
    sa = gca;
    %axis square;
    %sa.XAxis.Visible = 'off';
    %sa.YAxis.Visible = 'off';
    sa.XLim = [0 numel(d)];
    title('Data');
    
    % histogram
    subplot(3,2,[3 4]);
    e = rng_statistics_his_edges(d);
    %histogram(d, e);
    histogram(d,intmax('uint8')); %hardcoded workarround
    sa = gca;
    %axis square;
    %sa.XAxis.Visible = 'off';
    %sa.YAxis.Visible = 'off';
    sa.XLim = [0 max(e)];
    title('Histogram');

    % probability distribution
    subplot(3,2,5);
    hq=qqplot(d,makedist('uniform'));
    sa = gca;
    %axis square;
    %sa.XAxis.Visible = 'off';
    %sa.YAxis.Visible = 'off';
    xlabel('Equaly distributed density function');
    %ylim([0 numel(d)]);
    xticks([0 1])
    %yticks([0 300]);
    title('P-distribution');
    
    % autocorrelation
    subplot(3,2,6);
    autocorr(double(d),'NumLags',100,'NumSTD',3,'NumMA',0);
    sa = gca;
    %axis square;
    %sa.XAxis.Visible = 'off';
    %sa.YAxis.Visible = 'off';
    sa.YScale= 'log';
    title('Autokorrelation');
    
    
    sgtitle(ftname);
    
    % if the figure should be saved run this code
    if dumpfigure 
         exportgraphics(gcf, strjoin(fvfilename), 'Resolution', 600, 'BackgroundColor','none','ContentType','vector'); 
         exportgraphics(gcf, strjoin(fpfilename), 'Resolution', 300, 'BackgroundColor','w');
         close(figure(fh));
    end
end
