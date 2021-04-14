function [edges] = rng_statistics_his_edges(d)
% Calculate the histogramm edges/bins for a given dataset
%   Syntax:   [ edges ] = rng_statistics_his_edges(d)
%   Input:      d - vector or matrix to process
%   Output:     edges - calculated edges
% ------------------------------------------------------------------------
% (c) 2021 Andreas Huemmer <andreas.huemmer@sysopsec.de>
%   v 1.0     initial version 
% ------------------------------------------------------------------------

%calculate the required number of bins for histogramm
    if (isa(d, 'uint8'))
        edges = 0:(uint64(intmax('uint8'))+1); %adjust by 2 because of 0 and uint8 max +1
    elseif (isa(d, 'uint16'))
        edges = 0:(uint64(intmax('uint16'))+1);
    elseif (isa(d, 'uint32'))
        disp("The given type of uint32 requires a huge amount of memory,");
        disp("therefore this has been adjusted to uint16");
        %disp("Histcout data not computed");
        edges = 0:(uint64(intmax('uint16'))+1);
    elseif (isa(d, 'uint64'))
        disp("The given type of uint32 requires a huge amount of memory,");
        disp("therefore this has been adjusted to uint16");
        %disp("Histcout data not computed");
        edges = 0:(uint64(intmax('uint16'))+1);
    else
        disp("The given dataset has to be type of uint8, uint16 or uint32");
        disp("Histogram data can not be computed");
        edges = 0;
    end
    
end
