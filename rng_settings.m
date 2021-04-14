function [ ] = rng_settings(samples, source, itype, seed, MajVer, MinVer)
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

    %%fh = figure;
    
    % set some parameters for the current figure
    if dumpfigure 
        set(gcf,'WindowStyle','normal')
        set(gcf, 'Position', get(0, 'Screensize'));
        set(gcf,'color','w');
    end
    
    line1  = sprintf('-!-\n');
    line2  = sprintf('-------------------------------------------------------------\n');
    line3  = sprintf(' Stettings for %s  \n',FILE);
    line4  = sprintf('-------------------------------------------------------------\n');
    line5  = sprintf(' Version %d.%d \n', MajVer, MinVer);
    line6  = ''; % sprintf(' Pichture dir:          %s \n', PICDIR);
    line7  = sprintf(' Number of samples:     %d \n', samples);
    line8  = sprintf(' Type of data           %s \n', itype);
    line9  = sprintf(' Datasource             %s \n', source);
    line10 = sprintf(' Seed:                  %d \n', seed);
    line11 = sprintf(' Save graphics:         %d \n',dumpfigure);
    line12 = sprintf('-------------------------------------------------------------\n');
    textblock1 = [ line1 line2 line3 line4 line5 line6 line7 line8 line9 line10 line11 line12 ];
    
    user = memory2('GB');
    line13 = sprintf(' Maximum possible array size:     %3.6f GB\n', user.MaxPossibleArrayBytes );
    line14 = sprintf(' Memory available for all arrays: %3.6f GB\n', user.MemAvailableAllArrays );
    line15 = sprintf(' Memory used by Matlab:           %3.6f GB\n', user.MemUsedMATLAB );
    line16 = sprintf('-------------------------------------------------------------\n');
    textblock2 = [ line13 line14 line15 line16 ];
    
    fprintf(textblock1);
    fprintf(textblock2);
    
    % if the figure should be saved run this code
    if dumpfigure 
%         exportgraphics(gcf, fvfilename, 'Resolution', 600, 'BackgroundColor','none','ContentType','vector'); 
%         exportgraphics(gcf, fpfilename, 'Resolution', 300, 'BackgroundColor','w');
%         close(figure(fh));
        set(gcf,'WindowStyle','docked');
        % write out the text
        tfname = strcat(PICDIR, FILE, '-settings.txt');
        fid = fopen(tfname ,'w');
        fprintf(fid, textblock1);
        fprintf(fid, textblock2);
        fclose(fid);
    end
    
    
end
