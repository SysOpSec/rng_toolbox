function [] = rng_wavelet_1D_2_plots(d,w)
% Generate some convolution with complex wavelets plots for a given dataset
%   Syntax:    [] = rng_wavelet_1D_1_plots(d,w)
%   Input:      d - vector or matrix to process
%               w - wavelet to use for processing (ony orthognal or
%               biorthorgonal types are supported)
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
    data       = double(d);
    n          = numel(d);
  
    wtree      = wpdec(d, 5, w);
    
    % create new figure
    %fh = figure;

    % set some parameters for the current figure
    if dumpfigure 
        set(gcf,'WindowStyle','normal')
        set(gcf, 'Position', get(0, 'Screensize'));
        set(gcf,'color','w');
    end
    
    figname     = strcat('Wavelet coefficients-',w);
    ftname      = [figname '-' FILE];
    fpfilename    = [PICDIR ftname '.png']; % save as bitmapformat
    fvfilename    = [PICDIR ftname '.pdf']; % save as vectorformat
    
    % show coefficients
    wpviewcf(wtree, 2);
    sa = gca;
    axis tight;
    sa.XAxis.Visible='off';
    t = ['coefficients'];
    title(t);
            
    sgtitle(ftname);
    
    % if the figure should be saved run this code
    if dumpfigure 
        exportgraphics(gcf, strjoin(fvfilename), 'Resolution', 600, 'BackgroundColor','none','ContentType','vector'); 
        exportgraphics(gcf, strjoin(fpfilename), 'Resolution', 300, 'BackgroundColor','w');
        close(figure(fh));
        set(gcf,'WindowStyle','docked')
    end
end
