function [] = rng_dct_plots(d)
% Generate some dct plots for a given dataset
%   Syntax:    [] = rng_dct_plots(d)
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
    n = numel(d);             %number of samples
       
    % dct of a one domentional vector
    C = dct(d);
    maxd = abs(max(C));
    C_9999 = C;
    C_9999(abs(C_9999) < (maxd*0.001))=0;
    C_99999 = C;
    C_99999(abs(C_99999) < (maxd*0.0001))=0;
    C_999999 = C;
    C_999999(abs(C_999999) < (maxd*0.00001))=0;
    
    
    % create new figure
    fh = figure;

    % set some parameters for the current figure
    if dumpfigure 
        set(gcf,'WindowStyle','normal')
        set(gcf, 'Position', get(0, 'Screensize'));
        set(gcf,'color','w');
    end
    
    figname     = 'DCT';
    ftname      = [figname '-' FILE];
    fpfilename    = [PICDIR ftname '.png']; % save as bitmapformat
    fvfilename    = [PICDIR ftname '.pdf']; % save as vectorformat
    
    % dct 1d
    subplot(4,2,1);
    plot(C);
    %stem(time, d,'linew',1,'MarkerEdgeColor','r','MarkerFaceColor','r', 'marker', '.');
    sa = gca;
    %sa.XAxis.Visible = 'off';
    sa.YAxis.Visible = 'off';
    sa.YScale = 'log';
    sa.XLim = [0 n];
    title('DCT Coefficents');
    
    % dct full power
    subplot(4,2,2);
    %stem(nyq, ampl(1:n/2),'green-s','linew',1,'MarkerEdgeColor','r','MarkerFaceColor','r', 'marker', '.');
    imagesc(log(abs(C)));
    sa = gca;
    %sa.XAxis.Visible = 'off';
    sa.YAxis.Visible = 'off';
    sa.XLim = [0 n];
    %sa.XScale = 'log';
    sa.YScale = 'log';
    title('100%');
 
    % dct 1d 99,9999%
    subplot(4,2,3);
    plot(C_999999);
    sa = gca;
    %sa.XAxis.Visible = 'off';
    sa.YAxis.Visible = 'off';
    sa.YScale = 'log';
    sa.XLim = [0 n];
    title('DCT Coefficents 99,9999%');
    
    % dct 99,9999%
    subplot(4,2,4);
    imagesc(log(abs(C_999999)));
    sa = gca;
    %sa.XAxis.Visible = 'off';
    sa.YAxis.Visible = 'off';
    sa.XLim = [0 n];
    %sa.XScale = 'log';
    sa.YScale = 'log';
    title('99,9999%');
 
    % dct 99,999
    subplot(4,2,5);
    plot(C_99999);
    sa = gca;
    %sa.XAxis.Visible = 'off';
    sa.YAxis.Visible = 'off';
    sa.YScale = 'log';
    sa.XLim = [0 n];
    title('DCT Coefficents 99,999%');
    
    % dct 99,999%
    subplot(4,2,6);
    imagesc(log(abs(C_99999)));
    sa = gca;
    %sa.XAxis.Visible = 'off';
    sa.YAxis.Visible = 'off';
    sa.XLim = [0 n];
    %sa.XScale = 'log';
    sa.YScale = 'log';
    title('99,999%');

    % dct 99,99%
    subplot(4,2,7);
    plot(C_9999);
    sa = gca;
    %sa.XAxis.Visible = 'off';
    sa.YAxis.Visible = 'off';
    sa.YScale = 'log';
    sa.XLim = [0 n];
    title('DCT Coefficents 99,99%');
    
    % dct 99,99%
    subplot(4,2,8);
    imagesc(log(abs(C_9999)));
    sa = gca;
    %sa.XAxis.Visible = 'off';
    sa.YAxis.Visible = 'off';
    sa.XLim = [0 n];
    %sa.XScale = 'log';
    sa.YScale = 'log';
    title('99,99%');
 
    
    sgtitle(ftname);
    
    % if the figure should be saved run this code
    if dumpfigure 
        exportgraphics(gcf, strjoin(fvfilename), 'Resolution', 600, 'BackgroundColor','none','ContentType','vector'); 
        exportgraphics(gcf, strjoin(fpfilename), 'Resolution', 300, 'BackgroundColor','w');
        close(figure(fh));
        set(gcf,'WindowStyle','docked')
    end
end
