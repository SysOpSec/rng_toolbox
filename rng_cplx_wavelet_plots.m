function [] = rng_cplx_wavelet_plots(d)
% Generate some convolution with complex wavelets plots for a given dataset
%   Syntax:    [] = rng_cplx_wavelet_plots(d)
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
    d       = double(d);
   close all;
    n       = numel(d);
    srate   = 1000;
    time    = -srate : 1/srate : srate;
    pnts = length(time); 
    numfreq = 100; %[50 100];            % number of frequencies
    freq    = linspace(1, n/srate/2, numfreq);  % go from 1 to nyquest
    c       = 100                   % cycles of the wavelet
    % init of the wavelets and results for time-frequency calc
    [wlet, tfr] = deal(zeros(numfreq, pnts) );
    
    for widx = 1:numfreq
        % width of gaussian
        s = c / (2*pi*freq(widx));
        % construct the wavelets
        wlet(widx,:) = exp(1i*2*pi*time*freq(widx)) .* exp(-time.^2/(2*s^2));
    end
    figure
    contourf(time, freq, abs(wlet));%, 'linecolor', 'none');
    figure
    plot(time, real(wlet(1,:)))
    figure
    plot(time, real(wlet(5,:)))
    figure
    plot(time, real(wlet(50,:)))
    figure
    plot(time, real(wlet(100,:)))
%     winsizes = [100 1000 10000];
%     
%     li = 0;
%     for winsize=winsizes
%         li = li +1;
%         % windowsets
%         requiredsets = floor(numel(d)/winsize);
%         windowssets = round(linspace(1, winsize, requiredsets));
%         winsetcount = length(windowssets);
%         scope = linspace(0, numel(d)/2, floor(winsize/2+1));
%         scopesize = length(scope);
% 
%         % initialize the power matrix 
%         power = zeros(winsetcount,length(scope));
% 
%         % loop over windowsets
%         for idx=1:winsetcount
%             % get a chunk of data for current window
%             chunk = d(windowssets(idx):windowssets(idx)+winsize);
%             % compute its power
%             tp = 2*abs((fft(chunk)/winsize).^2);
% 
%             % enter into matrix
%             power(idx,:) = tp(1:scopesize);
%         end
%         % get the data out for plotting (can be done much nicer!!!)
%         if li ==1
%             p1 = power;
%             s1 = scope;
%             ws1 = winsize;
%         elseif li==2
%             p2 = power;
%             s2 = scope;
%             ws2 = winsize;
%         elseif li==3        
%             p3 = power;
%             s3 = scope;
%             ws3 = winsize;
%         else
%             disp('Too much different windowssizes given');
%         end
%     end
    
    % create new figure
    fh = figure;

    % set some parameters for the current figure
    if dumpfigure 
        set(gcf,'WindowStyle','normal')
        set(gcf, 'Position', get(0, 'Screensize'));
        set(gcf,'color','w');
    end
    
    figname     = 'Welch FFT';
    ftname      = [figname '-' FILE];
    fpfilename    = [PICDIR ftname '.png']; % save as bitmapformat
    fvfilename    = [PICDIR ftname '.pdf']; % save as vectorformat
    
    % show wcreated wavelets
    subplot(3,1,1);
    plot(s1, p1); 
    sa = gca;
    sa.YAxis.Visible = 'off';
    sa.XLim = [0 ws1/2];
    sa.YScale = 'log';    
    t = ['Leistungsspektren für Fenstergröße ' num2str(ws1)];
    title(t);
    
    % windowed fft winsize #2
    subplot(3,1,2);
    plot(s2, p2);
    sa = gca;
    sa.YAxis.Visible = 'off';
    sa.XLim = [0 ws2/2];
    sa.YScale = 'log';    
    t = ['Leistungsspektren für Fenstergröße ' num2str(ws2)];
    title(t);
    
    % windowed fft winsize #3
    subplot(3,1,3);
    plot(s3, p3);
    sa = gca;
    sa.YAxis.Visible = 'off';
    sa.XLim = [0 ws3/2];
    sa.YScale = 'log';    
    t = ['Leistungsspektren für Fenstergröße ' num2str(ws3)];
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
