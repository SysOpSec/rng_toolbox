function [] = rng_welch_plots(d)
% Generate some welch (windowed fft) plots from a given dataset
%   Syntax:    [] = rng_welch_plots(d)
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
    winsizes = [100 1000 10000];
    
    li = 0;
    for winsize=winsizes
        li = li +1;
        % windowsets
        requiredsets = floor(numel(d)/winsize);
        windowssets = round(linspace(1, winsize, requiredsets));
        winsetcount = length(windowssets);
        scope = linspace(0, numel(d)/2, floor(winsize/2+1));
        scopesize = length(scope);

        % initialize the power matrix 
        power = zeros(winsetcount,length(scope));

        % loop over windowsets
        for idx=1:winsetcount
            % get a chunk of data for current window
            chunk = d(windowssets(idx):windowssets(idx)+winsize);
            % compute its power
            tp = 2*abs((fft(chunk)/winsize).^2);
            tp(1) = tp(1)/2;
            % enter into matrix
            power(idx,:) = tp(1:scopesize);
        end
        
        % use the matlab summulative pwelch powerestimate
        pw = pwelch(d, winsize);
        
        % get the data out for plotting (can be done much nicer!!!)
        if li ==1
            p1    = power;
            x1    = 1:length(p1(1,:));
            x1mat = repmat(x1, length(p1(:,1)),1);
            y1    = 1:length(p1(:,1));
            y1mat = repmat(y1, length(p1(1,:)), 1);
            s1  = scope;
            ws1   = winsize;
            pw1   = pw;
        elseif li==2
            p2  = power;
            x2    = 1:length(p2(1,:));
            x2mat = repmat(x2, length(p2(:,1)),1);
            y2    = 1:length(p2(:,1));
            y2mat = repmat(y2, length(p2(1,:)), 1);
            s2  = scope;
            ws2 = winsize;
            pw2 = pw;
        elseif li==3        
            p3  = power;
            x3    = 1:length(p3(1,:));
            x3mat = repmat(x3, length(p3(:,1)),1);
            y3    = 1:length(p3(:,1));
            y3mat = repmat(y3, length(p3(1,:)), 1);
            s3  = scope;
            ws3 = winsize;
            pw3 = pw;
        else
            disp('Too much different windowssizes given');
        end
        
    end
    
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
    
    % windowed fft winsize #1
    subplot(3, 4 ,1);
    plot(s1, p1); 
    sa = gca;
    %sa.YAxis.Visible = 'off';
    sa.XLim = [0 ws1/2];
    sa.YScale = 'log';    
    %sa.XScale = 'log'; 
    t = ['Powerspectrum fon windowsize ' num2str(ws1)];
    title(t);
    
    % windowed fft winsize #2
    subplot(3,4,5);
    plot(s2, p2);
    sa = gca;
    %sa.YAxis.Visible = 'off';
    sa.XLim = [0 ws2/2];
    sa.YScale = 'log';    
    %sa.XScale = 'log'; 
    t = ['Powerspectrum fon windowsize ' num2str(ws2)];
    title(t);
          
    % windowed fft winsize #3
    subplot(3,4,9);
    plot(s3, p3);
    sa = gca;
    %sa.YAxis.Visible = 'off';
    sa.XLim = [0 ws3/2];
    sa.YScale = 'log';  
    %sa.XScale = 'log'; 
    t = ['Powerspectrum fon windowsize ' num2str(ws3)];
    title(t);
    
    %%%%%%%%%pwelch(d, winsize)
    
    % windowed fft winsize #1
    subplot(3, 4 ,2);
    plot(pw1); 
    sa = gca;
    %sa.YAxis.Visible = 'off';
    sa.XLim = [0 ws1/2];
    sa.YScale = 'log';    
    %sa.XScale = 'log'; 
    t = ['Powerestimate fon windowsize ' num2str(ws1)];
    title(t);
    
    % windowed fft winsize #2
    subplot(3,4,6);
    plot(pw2);
    sa = gca;
    %sa.YAxis.Visible = 'off';
    sa.XLim = [0 ws2/2];
    sa.YScale = 'log';    
    %sa.XScale = 'log'; 
    t = ['Powerestimate fon windowsize ' num2str(ws2)];
    title(t);
          
    % windowed fft winsize #3
    subplot(3,4,10);
    plot(pw3);
    sa = gca;
    %sa.YAxis.Visible = 'off';
    sa.XLim = [0 ws3/2];
    sa.YScale = 'log';  
    %sa.XScale = 'log'; 
    t = ['Powerestimate fon windowsize ' num2str(ws3)];
    title(t);
    
    % windowed fft winsize #1 3D
    subplot(3, 4 ,[3 4]);
    waterfall(y1mat', x1mat, p1);
    sa = gca;
    %sa.YAxis.Visible = 'off';
    %sa.YAxis.Visible = 'off';
    %sa.YAxis.Visible = 'off';
    sa.XLim = [0 length(p1(:,1))];
    sa.ZScale = 'log';    
    %sa.XScale = 'log'; 
    %sa.XDir = 'reverse';
    sa.YDir = 'reverse';
    %view([30 45]);
    t = ['Powerspectrum fon windowsize ' num2str(ws1)];
    title(t);
        
    % windowed fft winsize #2 3D
    subplot(3, 4 ,[7 8]);
    waterfall(y2mat', x2mat, p2);
    sa = gca;
    %sa.YAxis.Visible = 'off';
    %sa.YAxis.Visible = 'off';
    %sa.YAxis.Visible = 'off';
    sa.XLim = [0 length(p2(:,1))];
    sa.ZScale = 'log';  
    %sa.XScale = 'log';
    %sa.XDir = 'reverse';
    sa.YDir = 'reverse';
    %view([30 45]);
    t = ['Powerspectrum fon windowsize ' num2str(ws2)];
    title(t);
    
    % windowed fft winsize #3 3D
    subplot(3, 4 ,[11 12]);
    waterfall(y3mat', x3mat, p3);
    sa = gca;
    %sa.YAxis.Visible = 'off';
    %sa.YAxis.Visible = 'off';
    %sa.YAxis.Visible = 'off';
    sa.XLim = [0 length(p3(:,1))];
    sa.ZScale = 'log';
    %sa.XScale = 'log';
    %sa.XDir = 'reverse';
    sa.YDir = 'reverse';
    %view([30 45]);
    t = ['Powerspectrum fon windowsize ' num2str(ws3)];
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
