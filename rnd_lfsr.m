function [r] = rnd_lfsr(p, l, s)
% Linear feedback shiftregister
%   Syntax:   [rndnumber] = rng_lfsr(p, l, s)
%   Input:    p - feedbackpolynomial in a decimalvector representation
%             l - length of the shift register (5 means 5 ff)
%             s - seed value (optional) or state
%   Output:   r - random number
%
%   LFSRs can be computed from 4Bits to 64Bits. Bigger ones require some
%   dealing with BigInt.
% ------------------------------------------------------------------------
% (c) 2019 Andreas Huemmer <andreas.huemmer@sysopsec.de>
%   v 1.0     initial version 
% ------------------------------------------------------------------------
    % check for plausibility
    if ( max(p) > l && length( de2bi(s) ) )
        printf('polynom or seed must not exceet length');
        exit;    %polynomdegree must not exceed sf length and seed must
    end          %not exceed length too
    r = uint64(s);            % feed the seed
    msb = bitget(r, l);       % get the msb from integer for a sf with given length. 
    pl = length(p);           % get the length of polyvector
%    polymax = max(p);         % get the maximum degree of polynomial
    fb = msb;
    for i= [pl-1:-1:1]
        fb = bitxor(fb, bitget(r, p(i) ) ); % xor with the next polypart
    end
    % we have our feedback, lets shift
    r = bitshift(r,1);        % one step to the left (lsb will be 0)
    r = bitor(r, fb);         % put in our feedback
    % finally we have to strip, according to a given lenth and cut off
    % whats above our length
    r = bitand(r,uint64(2^l-1),'uint64');
end

