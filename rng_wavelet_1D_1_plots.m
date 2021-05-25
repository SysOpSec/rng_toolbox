function [] = rng_wavelet_1D_1_plots(d,w)
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
  
    [c, l]     = wavedec(d, 5, w);
    wtree      = wpdec(d, 5, w);
    approx     = appcoef(c, l, w);
    [cd1, cd2, cd3, cd4, cd5] = detcoef(c, l, [1 2 3 4 5]);
    
    % create new figure
    fh = figure;

    % set some parameters for the current figure
    if dumpfigure 
        set(gcf,'WindowStyle','normal')
        set(gcf, 'Position', get(0, 'Screensize'));
        set(gcf,'color','w');
    end
    
    figname     = strcat('Wavelet decomposition-',w);
    ftname      = [figname '-' FILE];
    fpfilename    = [PICDIR ftname '.png']; % save as bitmapformat
    fvfilename    = [PICDIR ftname '.pdf']; % save as vectorformat
    
    % show approximation
    subplot(6,1,1);
    plot(approx); 
    sa = gca;
    axis tight;
    sa.XAxis.Visible='off';
    t = ['Approximation coefficients'];
    title(t);
     
    % show decomposition
    subplot(6,1,2);
    plot(cd5);
    sa = gca;
    axis tight;
    sa.XAxis.Visible='off';
    t = ['L5 detail coefficients'];
    title(t);
    
    % show decomposition
    subplot(6,1,3);
    plot(cd4);
    sa = gca;
    axis tight;
    sa.XAxis.Visible='off';
    t = ['L4 detail coefficients'];
    title(t);
    
    % show decomposition
    subplot(6,1,4);
    plot(cd3);
    sa = gca;
    axis tight;
    sa.XAxis.Visible='off';
    t = ['L3 detail coefficients'];
    title(t);
    
    % show decomposition
    subplot(6,1,5);
    plot(cd2);
    sa = gca;
    axis tight;
    sa.XAxis.Visible='off';
    t = ['L2 detail coefficients'];
    title(t);
    
    % show decomposition
    subplot(6,1,6);
    plot(cd1);
    sa = gca;
    axis tight;
    sa.XAxis.Visible='off';
    t = ['L1 detail coefficients'];
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
