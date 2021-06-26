function [] = rng_walsh(d)
% Generate some walsh plots for a given dataset
%   Syntax:    [] = rng_walsh(d)
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
   
    % Discrete Walsh-Hadamard Transform
    %WS = fwht(d,n);
    WSh = fwht(d,n,'hadamard');
    WSd = fwht(d,n,'dyadic');
    WSs = fwht(d,n,'sequency');
     
    % create new figure
    fh = figure;

    % set some parameters for the current figure
    if dumpfigure 
        set(gcf,'WindowStyle','normal')
        set(gcf, 'Position', get(0, 'Screensize'));
        set(gcf,'color','w');
    end
    
    figname     = 'Walsh Transform';
    ftname      = [figname '-' FILE];
    fpfilename    = [PICDIR ftname '.png']; % save as bitmapformat
    fvfilename    = [PICDIR ftname '.pdf']; % save as vectorformat
    
    % walsh seq
    subplot(3,2,1);
    plot(WSs);
    sa = gca;
    %sa.XAxis.Visible = 'off';
    sa.YAxis.Visible = 'off';
    sa.YScale = 'log';
    sa.XLim = [0 n];
    title('WHT sequency');
    
    % walsh img seq
    subplot(3,2,2);
    imagesc(log(abs(WSs)));
    sa = gca;
    %sa.XAxis.Visible = 'off';
    sa.YAxis.Visible = 'off';
    sa.XLim = [0 n];
    %sa.XScale = 'log';
    sa.YScale = 'log';
    title('Imaging WHT sequency');

    % walsh hdamard
    subplot(3,2,3);
    plot(WSh);
    sa = gca;
    %sa.XAxis.Visible = 'off';
    sa.YAxis.Visible = 'off';
    sa.YScale = 'log';
    sa.XLim = [0 n];
    title('WHT hadamard');
    
    % walsh hadamard img
    subplot(3,2,4);
    imagesc(log(abs(WSh)));
    sa = gca;
    %sa.XAxis.Visible = 'off';
    sa.YAxis.Visible = 'off';
    sa.XLim = [0 n];
    %sa.XScale = 'log';
    sa.YScale = 'log';
    title('Imaging WHT hadamard');
    
    % walsh dyadic
    subplot(3,2,5);
    plot(WSd);
    sa = gca;
    %sa.XAxis.Visible = 'off';
    sa.YAxis.Visible = 'off';
    sa.YScale = 'log';
    sa.XLim = [0 n];
    title('WHT dyadic');
    
    % walsh dyadic img
    subplot(3,2,6);
    imagesc(log(abs(WSd)));
    sa = gca;
    %sa.XAxis.Visible = 'off';
    sa.YAxis.Visible = 'off';
    sa.XLim = [0 n];
    %sa.XScale = 'log';
    sa.YScale = 'log';
    title('Imaging WHT dyadic');
            
    sgtitle(ftname);
    
    % if the figure should be saved run this code
    if dumpfigure 
        exportgraphics(gcf, strjoin(fvfilename), 'Resolution', 600, 'BackgroundColor','none','ContentType','vector'); 
        exportgraphics(gcf, strjoin(fpfilename), 'Resolution', 300, 'BackgroundColor','w');
        close(figure(fh));
        set(gcf,'WindowStyle','docked')
    end
end
