function [] = rng_spectral(d)
% Generate some spectral plots from a given dataset
%   Syntax:    [] = rng_spectral(d)
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
    
    figname     = '1D Spektrogramanalyse';
    ftname      = [figname '-' FILE];
    fpfilename    = [PICDIR ftname '.png']; % save as bitmapformat
    fvfilename    = [PICDIR ftname '.pdf']; % save as vectorformat
    
    % powerspectrum
    subplot(3,1,1);
    pspectrum(double(d),'power','FrequencyLimits',[0 2]*pi);
    sa = gca;
    sa.YAxis.Visible = 'off';
    title('Leistungsspektrum');
    
    % persistencespectrum
    subplot(3,1,2);
    pspectrum(double(d),'persistence','FrequencyLimits',[0 2]*pi,'OverlapPercent',50);
    sa = gca;
    title('Persistenzspektrum');

    % phasespectrum
    subplot(3,1,3);
    pspectrum(double(d),'spectrogram','FrequencyLimits',[0 2]*pi,'OverlapPercent',50);
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
