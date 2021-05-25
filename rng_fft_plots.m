function [] = rng_fft_plots(d)
% Generate some dft plots for a given dataset
%   Syntax:    [] = rng_fft_plots(d)
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
    time = linspace(1, n, n);      %assume 1Hz samplerate
    nyq  = linspace(1, n/2, n/2);  %only positive spectrum
    
    % fft normalized by n and squared to get pwr, then calc the aps value
    % of complex coeff.
    ampl    = 2*abs((fft(d)/n).^2);
    ampl(1) = ampl(1)/ 2;          %adjustment due to our previous shorcut
    ang     = angle(fft(d));
    
    % create new figure
    fh = figure;

    % set some parameters for the current figure
    if dumpfigure 
        set(gcf,'WindowStyle','normal')
        set(gcf, 'Position', get(0, 'Screensize'));
        set(gcf,'color','w');
    end
    
    figname     = 'FFT';
    ftname      = [figname '-' FILE];
    fpfilename    = [PICDIR ftname '.png']; % save as bitmapformat
    fvfilename    = [PICDIR ftname '.pdf']; % save as vectorformat
    
    % raw data
    subplot(3,1,1);
    stem(time, d,'linew',1,'MarkerEdgeColor','r','MarkerFaceColor','r', 'marker', '.');
    sa = gca;
    %sa.XAxis.Visible = 'off';
    sa.YAxis.Visible = 'off';
    sa.XLim = [0 n];
    title('Data');
    
    % powerspectrum
    subplot(3,1,2);
    stem(nyq, ampl(1:n/2),'green-s','linew',1,'MarkerEdgeColor','r','MarkerFaceColor','r', 'marker', '.');
    sa = gca;
    %sa.XAxis.Visible = 'off';
    sa.YAxis.Visible = 'off';
    sa.XLim = [0 n/2];
    sa.XScale = 'log';
    sa.YScale = 'log';
    title('Power');

    % phasespectrum
    subplot(3,1,3);
    stem(nyq, ang(1:n/2),'green-s','linew',1,'MarkerEdgeColor','r','MarkerFaceColor','r', 'marker', '.');
    sa = gca;
    sa.XAxis.Visible = 'off';
    sa.YAxis.Visible = 'off';
    sa.XLim = [0 n/2];
    sa.YLim = [-pi pi];
    sa.XScale = 'log';
    sa.YScale = 'log';
    
    title('Phase');
        
    sgtitle(ftname);
    
    % if the figure should be saved run this code
    if dumpfigure 
        exportgraphics(gcf, strjoin(fvfilename), 'Resolution', 600, 'BackgroundColor','none','ContentType','vector'); 
        exportgraphics(gcf, strjoin(fpfilename), 'Resolution', 300, 'BackgroundColor','w');
        close(figure(fh));
        set(gcf,'WindowStyle','docked')
    end
end
