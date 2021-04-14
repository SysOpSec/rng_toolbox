function a5########(key, count)
% Get the shiftregisters initialized with the key data
% can also be used for framedata (see below)
%
%   Syntax:   a5########keyin(key, count)
%   Input:    key - keydata or framedata
%             count - how many rounds to go, 64 for key and 22 for frame
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

%% keyround 
% spec unclear, so we assume a start with the lsb of the key
        [fb1, fb2, fb3] = a5feedback;
        % apply keybit
        [fb1, fb2, fb3] = a5keyin(key,n);
        % now shift
        lfsr1 = bitshift(lfsr1,1);   % one step to the left (lsb will be 0)
        lfsr2 = bitshift(lfsr2,1);   % one step to the left (lsb will be 0)
        lfsr3 = bitshift(lfsr3,1);   % one step to the left (lsb will be 0)
        % put the feedbacks in
        lfsr1 = bitor(lfsr1, fb1);   % or is ok, due to lsb is always 0
        lfsr2 = bitor(lfsr2, fb2);   % or is ok, due to lsb is always 0
        lfsr3 = bitor(lfsr3, fb3);   % or is ok, due to lsb is always 0
 
end

