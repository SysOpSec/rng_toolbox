function [fb1, fb2, fb3] = a5feedback()
% Calculate the feedback and return the feedbac bits
%
%   Syntax:   [fb1, fb2, fb3] = a5feedback()
%   Input:    fb1, fb2, fb3 - Feedbackbits for SR 1, 2 and 3
%             
%----------------------------------------------------------------------
% (c) 2019 Andreas Huemmer <andreas.huemmer@sysopsec.de>
%   v 1.0     initial version 
% ------------------------------------------------------------------------
%% get access to required globals
    global lfsr1;
    global lfsr1poly;
    global lfsr1length; 
    global lfsr2;
    global lfsr2poly;
    global lfsr2length; 
    global lfsr3;
    global lfsr3poly;
    global lfsr3length; 
%% do some precalculations
    pl1 = length(lfsr1poly);           % get the length of polyvector
    pl2 = length(lfsr2poly);           % get the length of polyvector
    pl3 = length(lfsr3poly);           % get the length of polyvector

%% feedbackcalculation 
   fb1 = 0;
   fb2 = 0;
   fb3 = 0;
% feedback 
   for i = [pl1:-1:1]
      fb1 = bitxor(fb1, bitget(lfsr1, plfsr1poly(i) ) ); % xor with the next polypart
   end
   for i = [pl2:-1:1]
      fb2 = bitxor(fb2, bitget(lfsr2, plfsr2poly(i) ) ); % xor with the next polypart
   end
   for i = [pl3:-1:1]
      fb3 = bitxor(fb3, bitget(lfsr3, plfsr3poly(i) ) ); % xor with the next polypart
   end

