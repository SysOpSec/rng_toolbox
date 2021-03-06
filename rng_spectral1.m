function [] = rng_spectral1(d)
% Generate some spectral plots from a given dataset
%   Syntax:    [] = rng_spectral1(d)
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
    samples = numel(d);
    time    = 1:samples;
    
    % periodogram - power spectral density estimate
    % pg =  periodogram(double(d));
    % Multitaper power spectral density estimate
    % pt = pmtm(double(d));
    
    % Analyse frequency and time frequency domains
    [ ps_p_pwr, ps_f_pwr, ps_t_pwr ] = pspectrum(double(d),'power');
    [ ps_p_spe, ps_f_spe, ps_t_spe ] = pspectrum(double(d),'spectrogram','FrequencyLimits',[0 1]*pi);
    [ ps_p_per, ps_f_per, ps_t_per ] = pspectrum(double(d),'persistence');
    
    % create new figure
    fh = figure;

    % set some parameters for the current figure
    if dumpfigure 
        set(gcf,'WindowStyle','normal')
        set(gcf, 'Position', get(0, 'Screensize'));
        set(gcf,'color','w');
    end
    
    figname     = 'Spektrogramanalysis II';
    ftname      = [figname '-' FILE];
    fpfilename    = [PICDIR ftname '.png']; % save as bitmapformat
    fvfilename    = [PICDIR ftname '.pdf']; % save as vectorformat
    
    % spectrogramm cummulative
    subplot(3,1,1);
    plot(ps_p_spe);
    sa = gca;
    %sa.XScale = 'log';
    sa.YScale = 'log';
    sa.YAxis.Visible='off';
    sa.XAxis.Visible='off';
    axis tight;
    sa=ylabel('Powerspectrum(dB)');
    title('Spectrogram cumulative');

    % spectrogramm over time
    subplot(3,1,[2 3]);
    waterfall(ps_f_spe,ps_t_spe,ps_p_spe');
    sa = gca;
    %sa.XScale = 'log';
    %sa.YScale = 'log';
    sa.ZScale = 'log';
    
    wtf.XDir = 'reverse';
    view([30 45])
    sa.ZAxis.Visible='off';
    zlabel('Powerspectrum(dB)');
    title('Spectrogram over time');
    sa.YAxis.Visible='on';
    ylabel('Samples');
    sa.XAxis.Visible='on';
    xlabel('Frequency 10^4');
    
    sgtitle(ftname);
    
    % if the figure should be saved run this code
    if dumpfigure 
        exportgraphics(gcf, strjoin(fvfilename), 'Resolution', 600, 'BackgroundColor','none','ContentType','vector'); 
        exportgraphics(gcf, strjoin(fpfilename), 'Resolution', 300, 'BackgroundColor','w');
        close(figure(fh));
        set(gcf,'WindowStyle','docked')
    end
end
