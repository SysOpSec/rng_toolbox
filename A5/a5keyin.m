function [fb1, fb2, fb3] = a5keyin(key, count)
% Apply the key or framebits to the calculated feedbacks. Technically key
% and frame are the same.
%
%   Syntax:   [fb1, fb2, fb3] = a5keyin(key, count)
%   Input:    key - keydata or framedata
%             count - how many rounds to go, 64 for key and 22 for frame
%             fb1, fb2, fb3 - the calculated feedbacks for the #SR 1,2 and 3
%----------------------------------------------------------------------
% (c) 2019 Andreas Huemmer <andreas.huemmer@sysopsec.de>
%   v 1.0     initial version 
% ------------------------------------------------------------------------
%% keyround or frameround 
% spec unclear, so we assume a start with the lsb of the key
    for n = [1:1:count]
% apply keybit
        fb1 = bitxor(fb1, bitget(key,n));
        fb2 = bitxor(fb2, bitget(key,n));
        fb3 = bitxor(fb3, bitget(key,n));
    end    

