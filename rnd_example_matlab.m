%% Random numbers toolbox
%  Example for using the matlab rngs
% ------------------------------------------------------------------------
% (c) 2019 Andreas Huemmer <andreas.huemmer@sysopsec.de>
%   v 1.0     initial version 
% ------------------------------------------------------------------------
%% init workspace
% clean desk
%clear all; close all; clc; format compact;

% generate a dataset
% pls use 2^16 samples if you want to use the rng_test function, otherwise
% you might have to ajust the testroutines accordingly

% number of samples to generate
samples = 2^16;

% seedvalue (IV) of the rng generator
seed = 1;

%% MatLab specific settings
% dsfmt19937:       SIMD-oriented Fast Mersenne Twister with Mersenne prime 2^19937-1
% mcg16807:         Multiplicative congruential generator, with multiplier 7^5, modulo 2^31-1
% mlfg6331_64:      Multiplicative lagged Fibonacci generator, with lags 63 and 31, 64 bit (supports parallel streams)
% mrg32k3a:         Combined multiple recursive generator (supports parallel streams)
% mt19937ar:        Mersenne Twister with Mersenne prime 2^19937-1
% philox4x32_10:    Philox 4x32 generator with 10 rounds (supports parallel streams)
% shr3cong:         SHR3 shift-register generator summed with CONG linear congruential generator
% swb2712:          Modified Subtract-with-Borrow generator, with lags 27 and 12
% threefry4x64_20:  Threefry 4x64 generator with 20 rounds (supports parallel streams)
name = 'Matlab 2019b';
generator = "dsfmt19937";
text = " - " + generator; 
rs = RandStream.create(generator,'Seed',seed);
RandStream.setGlobalStream(rs);
% RandStream.getGlobalStream
textheading = strcat(name, text);

%% generate the data
for i=[1 : samples]                     % now generate the desired dataset
    rnd(i)=randi(samples);  
end
%% do some processing
rnd_test(rnd, samples, textheading);    % look at your data and get some 
                                        % nice figures