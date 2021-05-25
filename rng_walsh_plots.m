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
    W = fwht(d,n);
    y = fwht(d,n,'hadamard');
    yy = fwht(d,n,'dyadic');
    yyy = fwht(d,n,'sequency');
    
    k=find(W==0);
    l = find(yy==0);
    
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
    subplot(2,2,1);
    plot(W);
    %stem(time, d,'linew',1,'MarkerEdgeColor','r','MarkerFaceColor','r', 'marker', '.');
    sa = gca;
    %sa.XAxis.Visible = 'off';
    sa.YAxis.Visible = 'off';
    sa.YScale = 'log';
    sa.XLim = [0 n];
    title('WHT sequency');
    
    % walsh img seq
    subplot(2,2,2);
    %stem(nyq, ampl(1:n/2),'green-s','linew',1,'MarkerEdgeColor','r','MarkerFaceColor','r', 'marker', '.');
    imagesc(log(abs(W)));
    sa = gca;
    %sa.XAxis.Visible = 'off';
    sa.YAxis.Visible = 'off';
    sa.XLim = [0 n];
    %sa.XScale = 'log';
    sa.YScale = 'log';
    title('Imaging WHT sequency');

    % walsh hdamard
    subplot(2,2,3);
    plot(y);
    %stem(time, d,'linew',1,'MarkerEdgeColor','r','MarkerFaceColor','r', 'marker', '.');
    sa = gca;
    %sa.XAxis.Visible = 'off';
    sa.YAxis.Visible = 'off';
    sa.YScale = 'log';
    sa.XLim = [0 n];
    title('WHT hadamard');
    
    % walsh hadamard img
    subplot(2,2,4);
    %stem(nyq, ampl(1:n/2),'green-s','linew',1,'MarkerEdgeColor','r','MarkerFaceColor','r', 'marker', '.');
    imagesc(log(abs(y)));
    sa = gca;
    %sa.XAxis.Visible = 'off';
    sa.YAxis.Visible = 'off';
    sa.XLim = [0 n];
    %sa.XScale = 'log';
    sa.YScale = 'log';
    title('Imaging WHT hadamard');
    
        
    sgtitle(ftname);
    
    % if the figure should be saved run this code
    if dumpfigure 
        exportgraphics(gcf, strjoin(fvfilename), 'Resolution', 600, 'BackgroundColor','none','ContentType','vector'); 
        exportgraphics(gcf, strjoin(fpfilename), 'Resolution', 300, 'BackgroundColor','w');
        close(figure(fh));
        set(gcf,'WindowStyle','docked')
    end
end
