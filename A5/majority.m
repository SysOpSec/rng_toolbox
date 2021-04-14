function [maj] = majority(in)
% Return the majority vote for a given vector
%
%   Syntax:   [maj] = majority(in)
%   Input:    in  - array with dataset on whitch a majority vote should be
%               done. Must be mumeric. E.g.: [1 0 1]            
%   Output:   maj - returns the value that occured most often in the given array    
% ------------------------------------------------------------------------
% (c) 2019 Andreas Huemmer <andreas.huemmer@sysopsec.de>
%   v 1.0     initial version 
% ------------------------------------------------------------------------

    [count,values]=hist(in,unique(in));
    %Find the array index corresponding to  the value with the most occurrences
    [Vmax,argmax]=max(count);
    %Output function with most occurrences
    maj=values(argmax);
end

