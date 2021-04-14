%% Random numbers toolbox
%  Example for using the linear shift registers
% ------np(2)------------------------------------------------------------------
% (c) 2019 Andreas Huemmer <andreas.huemmer@sysopsec.de>
%   v 1.0     initial version 
% ------------------------------------------------------------------------
%% init workspace
% clean desk
clear all; close all; clc; format compact;

% generate a dataset
% pls use 2^16 samples if you want to use the rng_test function, otherwise
% you might have to ajust the testroutines accordingly

% number of samples to generate
samples = 2^16;

% seedvalue (IV) of the rng generator
seed = 1;

%% LFSR specific settings
% lfsr
l = 16;                                  % length of the shift registert
p = lfsr_poly(l);                       % get a maximum length polynomial 
                                        % for the feedback function
name = num2str(l) + "Bit LFSR";         % create a nice heading for reports
text = " mit taps @ " + num2str(p);
textheading = strcat(name, text);

%% generate the data
rnd(1) = rnd_lfsr(p, l, seed);          % put in the seed (note it is a
                                        % parallel load)
for i=[2 : samples]                     % now generate the desired dataset
    rnd(i)=rnd_lfsr(p, l, rnd(i-1));  
end
%% do some processing
rnd_test(rnd, samples, textheading);    % look at your data and get some 
                                        % nice figures