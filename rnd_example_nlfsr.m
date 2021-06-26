%% Random numbers toolbox
%  Example for using the linear shift registers
% ------------------------------------------------------------------------
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
l = 21;                                  % length of the shift register
[p q] = nlfsr_poly(l);                       % get a maximum length polynomial 
                                        % for the feedback function
% nonlinear components
% [tap1 tap2 replace]: taps are the position to get the bit for AND
% operation and must be less or equal to the length. replacement specifies
% the position being updated by the nonlinear components.
% if more than one nl component is used, the replacement must not be a tap
% of another!
% np = [4 2 1];                         % example from the functionmodule           

name = num2str(l) + "Bit NLFSR";         % create a nice heading for reports
text = " mit linear taps @ " + num2str(p) + " & nonlinear taps @ " + num2str(q);
textheading = strcat(name, text);

%% generate the data
rnd(1) = rnd_nlfsr(p, q, l, seed);    % put in the seed (note it is a
                                        % parallel load)
for i=[2 : samples]                     % now generate the desired dataset
    rnd(i)=rnd_nlfsr(p, q, l, rnd(i-1));  
end
