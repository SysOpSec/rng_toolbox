function [r] = rnd_lincon(c, a, m, s)
% Linear kongruenz generator
%   Syntax:   [rndnumber] = rnd_lincon(c, a, m, s)
%   Input:    a - additive constant
%             c - multiplicator
%             m - modulo operator
%             s - seed value (optional) or state
%             t - type of integer
%   Output:   r - random number
%
% It takes the parameter for the following formula of a mixed linear
%   congruenz generator:
%       x = (a + c * s) mod m
%
% ------------------------------------------------------------------------
% (c) 2019 Andreas Huemmer <andreas.huemmer@sysopsec.de>
%   v 1.0     initial version 
% ------------------------------------------------------------------------
        r = (mod(a + c * s, m));
end

