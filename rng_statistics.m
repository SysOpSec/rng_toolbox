function [ ] = rng_statistics(d)
% Evaluate some statistical data from a given dataset
%   Syntax:   [ smin smax smean sbmean sbsdt ] = rng_statistics(d)
%   Input:      d - vector or matrix to process
%   Output:     - none -
% ------------------------------------------------------------------------
% (c) 2021 Andreas Huemmer <andreas.huemmer@sysopsec.de>
%   v 1.0     initial version 
% ------------------------------------------------------------------------
    % use global variables
    global PICDIR;
    global FILE;
    global dumpfigure;
    
    % set local baselines
    significance = 0.01;
    
    % some simple stats
    smin        = min(d(:));            % min
    smax        = max(d(:));            % max
    smed        = median(d);            % median
    smean       = mean(d(:));           % mean
    emean       = intmax(class(d))/2;   % expected mean
    ssdt        = std(double(d));               % standard deviation
    scov        = cov(double(d));       % covariance (auto)
    [sacor salag] = autocorr(double(d),'NumLags',100,'NumSTD',3,'NumMA',0);% autocorl. coefficents
    
     %calculate histogram counts
    sbins       = histcounts(d, rng_statistics_his_edges(d));
    shmin       = min(sbins(:));        % smalest bin
    shmax       = max(sbins(:));        % larges bin
    shsdt       = std(sbins(:));        % sdt dev. of bins
    
    % entropy et al
    sentropy    = entropy(double((d/max(abs(d))))); %normalized as entropy is usually used for greyscal images
    sskew       = skewness(double(d));  % skewness
  
    % runstest (h=0 reject nullhypothesis, h=1 fails to reject)
    [hmedrun,pmedrun] = runstest(double(d),smed);
    [hmearun,pmearun] = runstest(double(d),emean);
    
    % monobit frequency test
    mbf_pvalue = rng_statistics_monobit(d);
    if mbf_pvalue < significance
        mbf_state = 'failed';
    else
        mbf_state = 'pass';
    end
    
    % monobit frequency blocktest
    % not implemenmted yet
    
    % binary matrix rank test
    % not implemenmted yet
    
    % discrete fourier transform (spectral) test
    % not implemenmted yet
    
    %%fh = figure;
    
    % set some parameters for the current figure
    if dumpfigure 
        set(gcf,'WindowStyle','normal')
        set(gcf, 'Position', get(0, 'Screensize'));
        set(gcf,'color','w');
    end
    
    line1  = sprintf('\n');
    line2  = sprintf('-------------------------------------------------------------\n');
    line3  = sprintf(' Statistics for %s  \n',FILE);
    line4  = sprintf('-------------------------------------------------------------\n');
    line5  = sprintf(' Minimum:                      %.0f\n', smin);
    line6  = sprintf(' Maximum:                      %.0f\n', smax);
    line7  = sprintf(' \n');
    line8  = sprintf(' Expected mean:                %.4f\n', emean);
    line9  = sprintf(' Calculated mean:              %.4f\n', smean);
    line10 = sprintf(' Std deviation:                %.4f\n', ssdt);
    line11 = sprintf(' Covariance:                   %.4f\n', scov);
    line12 = sprintf(' Entropy:                      %.4f\n', sentropy);
    line13 = sprintf(' Skewness:                     %.4f\n', sskew);
    line14 = sprintf('-------------------------------------------------------------\n');
    textblock1 = [ line1 line2 line3 line4 line5 line6 line7 line8 line9 line10 line11 line12 line13 line14];
    fprintf(textblock1);
    
    line1  = sprintf(' Smalest bin:                   %.1f\n', shmin);
    line2  = sprintf(' Biggest bin:                   %.1f\n', shmax);
    line3  = sprintf(' Std deviation among bins:      %.4f\n', shsdt);
    line4  = sprintf('-------------------------------------------------------------\n');
    
    textblock2 = [ line1 line2 line3 line4 ]; % line5 line6 line7 line8 line9 line10 line11 line12 line13 line14];
    fprintf(textblock2);
    
    line1  = sprintf(' RUNs(median):           p-val %7.4f -> h0: %7.4f \n', hmedrun, pmedrun);
    line2  = sprintf(' RUNs(exp mean):         p-val %7.4f -> h0: %7.4f \n', hmearun, pmearun);
    line3  = sprintf('\n');
    line4  = sprintf(' Monobit frequency:      p-val %7.4f -> %s\n', mbf_pvalue, mbf_state);
    line5  = sprintf('-------------------------------------------------------------\n');
    
    textblock3 = [ line1 line2 line3 line4 line5 ]; % line6 line7 line8 line9 line10 line11 line12 line13 line14];
    fprintf(textblock3);
    
    
    % if the figure should be saved run this code
    if dumpfigure 
%         exportgraphics(gcf, fvfilename, 'Resolution', 600, 'BackgroundColor','none','ContentType','vector'); 
%         exportgraphics(gcf, fpfilename, 'Resolution', 300, 'BackgroundColor','w');
%         close(figure(fh));
        set(gcf,'WindowStyle','docked')
        % wirte out the text
        tfname = strcat(PICDIR, FILE, '-statistics.txt');
        fid = fopen(tfname ,'w');
        fprintf(fid, textblock1);
        fprintf(fid, textblock2);
        fprintf(fid, textblock3);
        fclose(fid);
    end
    
    
end
