function [] = rng_spectral3(d)
% Generate some spectral plots from a given dataset
%   Syntax:    [] = rng_spectral3(d)
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
    % Parameters
    samples = numel(d);
    time    = 1:samples;
    data=double(d);
    
    % for cwt
    cwtLimits = [0 1];
    voicesPerOctave = 8;
    cwtLimits = cwtLimits/2;  % Convert to cycles/samples
    cwtLimits(1) = max(cwtLimits(1), cwtfreqbounds(samples));% Limit the cwt frequency limits
    
    % create new figure
    fh = figure;

    % set some parameters for the current figure
    if dumpfigure 
        set(gcf,'WindowStyle','normal')
        set(gcf, 'Position', get(0, 'Screensize'));
        set(gcf,'color','w');
    end
    
    figname     = 'Spektrogramanalysis III';
    ftname      = [figname '-' FILE];
    fpfilename    = [PICDIR ftname '.png']; % save as bitmapformat
    fvfilename    = [PICDIR ftname '.pdf']; % save as vectorformat
    
    % scalogram
    %subplot(4,1,4);
    cwt(data, 'VoicesPerOctave',voicesPerOctave, 'FrequencyLimits',cwtLimits);
    sa = gca;
    title('Scalogram');
            
    sgtitle(ftname);
    
    % if the figure should be saved run this code
    if dumpfigure 
        exportgraphics(gcf, strjoin(fvfilename), 'Resolution', 600, 'BackgroundColor','none','ContentType','vector'); 
        exportgraphics(gcf, strjoin(fpfilename), 'Resolution', 300, 'BackgroundColor','w');
        close(figure(fh));
        set(gcf,'WindowStyle','docked')
    end
end
