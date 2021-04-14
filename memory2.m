function [user, sys] = memory2(unit)
% memory2 Memory information in a multiple of the unit byte.
% 
%   memory2 is a wrapper for the memory function but displays memory 
%   information in a multiple of the unit byte. 
%
%   Accepted units are: B, kB, MB, GB, KiB, MiB and GiB.
%
%  See also memory.
%  Copyright 2016, Jerome Briot
narginchk(0, 1)
if nargin==0 || strcmpi(unit, 'b')
    
    [user, sys] = memory;
    
else
    
    switch lower(unit)
        case 'gib'
            f = 2^-30;
        case 'mib'
            f = 2^-20;
        case 'kib'
            f = 2^-10;
        case 'gb'
            f = 10^-9;
        case 'mb'
            f = 10^-6;
        case 'kb'
            f = 10^-3;
        otherwise
            error('Wrong unit. Should be B, kB, MB, GB, KiB, MiB or GiB');
    end
    
    [user, sys] = memory;
    
    fn = fieldnames(user);    
    for n = 1:numel(fn)
        user.(fn{n}) = user.(fn{n})*f;
    end
    
    fn = fieldnames(sys);
    for m = 1:numel(fn)
        fn2 = fieldnames(sys.(fn{m}));
        for n = 1:numel(fn2)
            sys.(fn{m}).(fn2{n}) = sys.(fn{m}).(fn2{n})*f;
        end
    end
    
end

