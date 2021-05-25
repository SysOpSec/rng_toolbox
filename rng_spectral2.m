function [] = rng_spectral2(d)
% Generate some spectral plots from a given dataset
%   Syntax:    [] = rng_spectral2(d)
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
    
    % for pspectrum
    frequencyLimits = [0 1]*pi; % Normalized frequency (rad/sample)
    overlapPercent = 50;
    
    % create new figure
    fh = figure;

    % set some parameters for the current figure
    if dumpfigure 
        set(gcf,'WindowStyle','normal')
        set(gcf, 'Position', get(0, 'Screensize'));
        set(gcf,'color','w');
    end
    
    figname     = 'Spektrogramanalysis I';
    ftname      = [figname '-' FILE];
    fpfilename    = [PICDIR ftname '.png']; % save as bitmapformat
    fvfilename    = [PICDIR ftname '.pdf']; % save as vectorformat
    
    % powerspectrum
    subplot(3,1,1);
    pspectrum(data,'power','FrequencyLimits', frequencyLimits);
    sa = gca;
    sa.YAxis.Visible = 'off';
    title('Powerspectrum');
    
    % persistencespectrum
    subplot(3,1,2);
    pspectrum(data, 'persistence', 'FrequencyLimits', frequencyLimits, 'OverlapPercent',overlapPercent);
    sa = gca;
    title('Persistenzspectrum');

    % phasespectrum
    subplot(3,1,3);
    pspectrum(double(d),'spectrogram','FrequencyLimits', frequencyLimits, 'OverlapPercent',overlapPercent);
    sa = gca;
    title('Spectrogram');
    
    sgtitle(ftname);
    
    % if the figure should be saved run this code
    if dumpfigure 
        exportgraphics(gcf, strjoin(fvfilename), 'Resolution', 600, 'BackgroundColor','none','ContentType','vector'); 
        exportgraphics(gcf, strjoin(fpfilename), 'Resolution', 300, 'BackgroundColor','w');
        close(figure(fh));
        set(gcf,'WindowStyle','docked')
    end
end
