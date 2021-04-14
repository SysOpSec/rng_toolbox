function [keyframe] = A51(key, startframe, count)
% Calculate and return a keyframe for a A5.1 cypher
%
%   Syntax:   [keyframe] = A51(key, startframe, count)
%   Input:    key - a 64 bit secret key
%             startframe - framenumber to start with
%             count - number of frames to calculate and to return
%   Output:   keyframe - returns the keyframedata    
% ------------------------------------------------------------------------
% (c) 2019 Andreas Huemmer <andreas.huemmer@sysopsec.de>
%   v 1.0     initial version 
% ------------------------------------------------------------------------

% set the shitfregisterrepresentations as global variables and init them
    global lfsr1;
    lfsr1 = uint32(0);
    global lfsr1poly;
    lfsr1poly = [14 17 18 19]; % pls note, in matlab we start with 1 instead of 0
    global lfsr1time;
    lfsr1time = 8;
    global lfsr1length; 
    lfsr1length = 19;
    global lfsr2;
    lfsr2 = uint32(0);
    global lfsr2poly;
    lfsr2poly = [21 22];
    global lfsr2time;
    lfsr2time = 10;
    global lfsr2length; 
    lfsr2length = 22;
    global lfsr3;
    lfsr3 = uint32(0);
    global lfsr3poly;
    lfsr3poly = [8 21 22 23];
    global lfsr3time;
    lfsr3time = 10;
    global lfsr3length; 
    lfsr3length = 23;
    
% set the key and the frame
key = uint64(1);
startframe = utint32(1);
    
% 1st round - apply key
a5keyin(key,64);

% 2nd round - apply frame
a5framein(startframe,22);

% 3rd round - initcycle
a5init();



end

