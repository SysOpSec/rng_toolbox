function [pval] = rng_statistics_monobit(d)
% Calculate the monobit frequency for proove of randomnes
%   Syntax:   [ pval ] = rng_statistics_monobit(d)
%   Input:      d - vector or matrix to process
%   Output:     calcluated p-value
% ------------------------------------------------------------------------
% (c) 2021 Andreas Huemmer <andreas.huemmer@sysopsec.de>
%   v 1.0     initial version 
% ------------------------------------------------------------------------

% (https://www.random.org/analysis/Analysis2005.pdf)
    itype = class(d);
    bm     = [];
    switch itype
        case 'uint8'
            for xj = 1:numel(d)
                bm = [bm  bitget(d(xj), 1:8) ];
            end
        case 'uint16'
            for xj = 1:numel(d)
                bm = [bm  bitget(d(xj), 1:16) ];
            end
        case 'uint32'
            for xj = 1:numel(d)
                bm = [bm  bitget(d(xj), 1:32) ];
            end
        otherwise
            disp('Unsupported integer');
            finish;
    end
    sobs = abs(sum(bm==1)-sum(bm==0))/sqrt(numel(d));
    pval = erfc(sobs/sqrt(2));
    
end
