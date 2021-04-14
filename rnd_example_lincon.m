%% Random numbers toolbox
%  Example for using the linear congruence modul
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

%% LINCON specific settings
% get some data from our database (or enter it manually)
conDBID = 1;                            % for further info what ID means 
                                        % what, pls refere to the DB file
                                        % in this cas ID 1 is "RANDU"
[a c m name text] = lincon(conDBID);

% !Pls note, that the choice for a and c might differ from some other
% documentations or literature. in our case a is the additive constant and
% c is the multiplier!

%a=0 ; c=13; m=64;                       % here you can use manual settings
                                         % !pls keep in mind that seed may
                                         % not be independet  from the
                                         % values you choose!
%name="individual mixed linear conguence"; text=" - a=10, c=2, m=9";
textheading = strcat(name, text);

%% generate the data
rnd(1) = rnd_lincon(c, a, m, seed);    % put in the seed
for i=[2 : samples]                     % now generate the desired dataset
     rnd(i) = rnd_lincon(c, a, m, rnd(i-1)); 
end
%% do some processing
%%rnd_test(rnd, samples, textheading);    % look at your data and get some 
                                        % nice figures
                                        
