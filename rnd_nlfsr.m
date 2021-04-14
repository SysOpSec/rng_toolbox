function [r] = rnd_nlfsr(p, np, l, s)
% Linear feedback shiftregister
%   Syntax:   [rndnumber] = rng_lfsr(p, l, s)
%   Input:    p - feedbackpolynomial in a decimalvector representation
%             np - nonlinear-fb-component represented as triples (tap1, 
%                   tap2, replacing tab)                
%             l - length of the shift register (5 means 5 ff)
%             s - seed value (optional) or state
%   Output:   r - random number
%
%   NLFSRs can be computed from 4Bits to 64Bits. Bigger ones require some
%   dealing with BigInt.
%   Nonliear components are implemented as AND. Position is identified by
%   a polynomerepresentation which is interpreted as an additional layer.
%
%   E.g.: nonlinear makes an AND between tap 4 and 2 of the shiftregister
%   and replaces the bitvalue at pos 1 in the tempvar of the shiftregister
%   data. then the feedback is calculated from the values in the tempvar.
%
%                     +---+---+---+---+---+
%  fb(p):+------------| feedbackpolynome  | 
%        |        ^   +---+---+---+---+---+
%        |        |   ^   ^   ^   ^   ^
%        |        |   |   |   |   |   |
%        |        +---+-&-----+   |   |
%        |            |   |   |   |   |
%        |          +---+---+---+---+---+
%  r:    +--------->| 0 | 1 | 2 | 3 | 4 | -> Y
%                   +---+---+---+---+---+
% ------------------------------------------------------------------------
% (c) 2019 Andreas Huemmer <andreas.huemmer@sysopsec.de>
%   v 1.0     initial version 
% ------------------------------------------------------------------------
    % check for plausibility
    if ( ( max(p) > l ) && ( max(np) > l ) && ( length( de2bi(s)) < l+1 ) && ( mod(length(np),3) == 0 ) )
        printf('polynoms or seed must not exceet length, nl must be triples');
        exit;    %polynomdegree must not exceed sf length and seed must
    end          %not exceed length too
    r = uint64(s);            % feed the seed
    msb = bitget(r, l);       % get the msb from integer for a sf with given length. 
    pl = length(p);           % get the length of polyvector
    npl = length(np);         % get the length of the nonlinear polyvector
    polymax = max(p);         % get the maximum degree of polynomial
    npolymax = max(np);       % get the maximum degree of nonliear polynomial
    % calculate the nonlinear feedback polynome
    % only for nlfp with 2 taps, nlfp with more taps had to be coded
    % otherwise, however our helper function is limited to deliver only
    % such polynomes with 2 taps.
    nfb = bitand( bitget(r, np(1) ), bitget(r, np(2) ) );
    fb = bitxor (nfb, msb);
    % calculate the linear feedback polynome
    for i= [pl-1:-1:1]
        fb = bitxor(fb, bitget(r, p(i) ) ); % xor with the next polypart
    end
    % until here we calculated with our tempvar rn...now back to
    % shiftregister var r.
    % we have our feedback, lets shift
    r = bitshift(r,1);        % one step to the left (lsb will be 0)
    r = bitor(r, fb);         % put in our feedback
    % finally we have to strip, according to a given lenth and cut off
    % whats above our length
    r = bitand(r,uint64(2^l-1),'uint64');
end

