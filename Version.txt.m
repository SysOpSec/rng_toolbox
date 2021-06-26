%% Random numbers toolbox
%  Things that have been done and that have to be done ,-)
% ------------------------------------------------------------------------
% (c) 2019, 2020, 2021 Andreas Huemmer <andreas.huemmer@sysopsec.de>
%   v 1.0     initial version 11/2019
%   v 1.01    minor improvements and errorcorrections 12/2019
%   v 1.02    minor improvements
%   v 1.1     created testsuite and supporting functions 03/2021
%   v 1.11    extended testsuite and supporting functions 03/2021
%   v 1.12    extended testsuite and supporting functions 03/2021
%   v 1.13    extended testsuite and supporting functions 04/2021
%   v 1.14    extended testsuite and supporting functions 04/2021
%   v 1.16    extended testsuite and supporting functions 04/2021
%   v 1.17    extended testsuite and supporting functions 05/2021
%   v 1.18    extended testsuite and supporting functions 05/2021
%   v 1.19    extended testsuite and supporting functions 05/2021
%   v 1.20    extended testsuite and supporting functions 05/2021
%   v 1.21    extended testsuite and supporting functions 06/2021
%   v 1.22    optimization, improvements and correction of erros 06/2021
% ------------------------------------------------------------------------
%% Things already implemented and done
% included in v 1.0
% Parametrized mixed linear congruence generator
% Parametrized lfsr generator up do 32 (64) FF
% Polynome database for 4..32 and 64 bit shift registers for max period
% Database of settings for ancient or actual mixed linear congruencee generator
% A basic testsuite for random numbers generator
% Some Examples on how to use
% -------------------------------------------------------------------
% v 1.01 07.12.2019
% added visualisation of noise sphere plots
%           see http://mathworld.wolfram.com/NoiseSphere.html
% added some textoutput for statistical data
% added examples on matlab rngs
% -------------------------------------------------------------------
% v 1.02 30.12.2019
% added nlfsr
% -------------------------------------------------------------------
% v 1.1 27.03.2021
% added testsuite
% added fileload
% added statisticfuncion (for testsuite)
% added statisticplots (for testsuite)
% added simpleplots (for testsuite)
% -------------------------------------------------------------------
% v 1.11 30/31.3.2021
% added addl. datasource options
% added kart. scatterplot
% added pol. scatterplot
% minor fixex in graphical output
% removed statitics text output
% replaced old controlscript by rng-testsuite.m
%--------------------------------------------------------------------
% v 1.12 02.04.2021
% added PCB and DCB
% added experimental GUI
% added 1D FFT
% added more statistics, added output for stats
% added settings output
%--------------------------------------------------------------------
% v 1.13 03.04.2021
% added Welch (windowed FFT)
% added spectrum analysis
%--------------------------------------------------------------------
% v 1.14 05.04.2021
% added reference-function
% added raw dataplots
%--------------------------------------------------------------------
% v 1.15 07.04.2021
% modified reference-function
% added welch 3d plots over time
% spectrum analysis rerwritten, still incomplete
%--------------------------------------------------------------------
% v 1.16 09.04.2021
% fixing errors in reference-functions
% fix interger type alignment errors in ref and statistics
% added and cleeaned up stat calculation and oputput
%--------------------------------------------------------------------
% v 1.17 01.05.2021
% added dct
% added walsh-hardamond
%--------------------------------------------------------------------
% v 1.18 20.05.2021
% fixing errors in reference-functions
% added and rewrite of spectral analysis
% unified en lang on plots
%--------------------------------------------------------------------
% v 1.19 25.05.2021
% added 1D wavlet decompositions
%--------------------------------------------------------------------
% v 1.20 26.05.2021
% minor fixes and optimizations
%--------------------------------------------------------------------
% v 1.22 26.06.2021
% minor fixes and optimizations
% added some experimental stuff
% cleanups
%--------------------------------------------------------------------

%--------------------------------------------------------------------
% Planed:
% - externalize figure settings in own subfucntion
% - externalize dump in subfunction, along with option to choos for image
% or vector dump
% - play around with ltfat
%
%--------------------------------------------------------------------

%% KNOWN Problems
% tests are dependent from choosen integer type
%   partially resolved
% high memoryconsumption with big junksizes
% histogram-functions do not scale for integers > uint16
%   reduce calculatation for bins and limit to u16
% lincon has some issues with datatype
% hostogram bin calculation does not work well under certain circumsdances

%% Things that are on my todo list
%--------------------------------------------------------------------
% Planed for next versions
% done - add fileinput for testing (v 1.1)
% wip - improvement of statistics output (v 1.1)
% wip - improvement of testsuite and its interface over all (v 1.1)
% - add generalized non linear timing for glfsr (v 2.0)
% - add generalized non linear taps beween multiple gnlfsr (v 2.0)
% - add generalized non linear tap on output of gnlfsr(v 2.0)
% - add A5/1 as an example (v 1.2)
% - add other rng algorithms like KISS/XORSHIFT/Twister etc. (v 3.0)
% - add other krypto algorithms like AED/DES etc. (v 3.0)
% - add other CRC/Hash algorithms like CRC/SHA etc. (v 3.0)
% - add a playbookwrapper arround (v 4.0)
% - publish on mathworks for a broader audience and feedback





