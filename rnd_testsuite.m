%% Random numbers toolbox
%  Random number testsuite
% ------------------------------------------------------------------------
% (c) 2021 Andreas Huemmer <andreas.huemmer@sysopsec.de>
%   v 1.0     initial version 
%   v 1.1     var adds and corrections, see verstions.txt.m
%   v 1.2     var adds and corrections, see verstions.txt.m
% ------------------------------------------------------------------------
%% init workspace
% clean desk
clear all; close all; clc; format compact;
set(0,'DefaultFigureColormap',feval('jet'));
%set(0,'DefaultFigureColormap',feval('turbo'));
set(0,'DefaultFigureWindowStyle','docked');
%profile on;
warning('off','all'); warning
tic
%% set global parameters
MajVer = 1;
MinVer = 2;

% global variables
global dumpfigure;
global FILE;
global PICDIR;
global WORKDIR;

%% DataControlBlock
% note: 2^31 (2GB datachunk) reqires at least 24GB of RAM!!!
% chunksize based on 8Bit interpretation
% in most cases 2GB is the limit a 32GB machine can deal with
% NOTE sizes greater than 2^20 might even lead to systemhung due to mem
% requirements for some calculations
%samples = 2^31; % 2GB
%samples = 2^16; % 64MB
samples = 2^18;


% shall created figures automatically saved as images
% WARNING: will take some time for big sample sizes and/or vector graphics!
%dumpfigure = false;  
dumpfigure = true; 

% work with dummy data or real data, can be 
% 'file', 'matlab', 'rnd_lincon', 'rnd_lfsr', 'rnd_ nlfsr', 'dummy',
% 'reference'
% later, can also be 'gui' for interactive mode - not impemented yet
%ssource = 'reference';    
%ource = 'file';  
%source = 'matlab';  
source = 'rnd_lincon';
%source = 'rnd_lfsr';
%source = 'rnd_nlfsr';

% export data to db
dbexport = false;
% server =;
% db = ;
% user =;
% pass =;

% environment parameters
PICDIR  = 'x:\graphic\';    % directory for graphics
WORKDIR = 'x:\work\';        % the datadirectory

% integertype (be carefull, must be choosen according to source!!)
itype = 'uint32';
% seedvalue (IV) of the rng generator for reproducability - if needed
seed =1;

%% load or generate data
switch source
    case "file"
        % Available (used) sources: 
        % 'prg320.bin', 'prg420.bin', 'matlab-mt19937ar.bin', '041-randu.bin'
        FILE    = '041-randu.bin'; 
        TXT     = ' '    
        LOADFILE = [WORKDIR FILE];
        %load the desired data
        [data, n] = rng_loaddata(LOADFILE, samples, itype);
        FILE=convertCharsToStrings(FILE);
        
    case "matlab" % must be at least uint16!!
        % Available sources in matlab: see also RandStream.list (may differ
        % depending on matlab version
        % 'dsfmt19937', 'mcg16807', 'mlfg6331_64', 'mrg32k3a', 'mt19937ar', 
        % 'philox4x32_10', 'shr3cong', 'swb2712', 'threefry4x64_20'  
        name = 'Matlab 2021a';
        generator = "dsfmt19937";
        rs = RandStream.create(generator,'Seed',seed);
        RandStream.setGlobalStream(rs);
        FILE = strcat(name, " - ", generator);
        % generate the data
        data  = randi(intmax(itype), [1 samples], itype);
        
    case "rnd_lincon"
        % LINCON specific setting s- get some data from our database (or 
        % enter it manually) - look at DB file, for further info
        conDBID = 2;  
        [a c m name text] = lincon(conDBID);
        %a=0 ; c=23; m=65537;              % here you can use manual settings
        name ='periodentest';
        FILE = strcat("RND mixed LinCon - ", num2str(a), " + ", num2str(c), "X" , " mod ", num2str(m), " - ", name);
        % generate the data
        data(1) = rnd_lincon(c, a, m, seed);    % put in the seed
        for i=[2 : samples]                     % now generate the desired dataset
             data(i) = rnd_lincon(c, a, m, data(i-1)); 
        end
        
    case "rnd_lfsr"
        l = 16;                       % length of the shift register
        p = lfsr_poly(l);             % get a maximum length polynomial 
                                      % for the feedback function
        name = num2str(l) + "Bit LFSR"; % create a nice heading for reports
        text = " taps at " + num2str(p);
        FILE = strcat(name, text);
        % generate the data
        data(1) = rnd_lfsr(p, l, seed);   % put in the seed (note it is a
                                         % parallel load)
        for i=[2 : samples]              % now generate the desired dataset
          data(i)=rnd_lfsr(p, l, data(i-1));  
        end

        disp("experimental");
        
    case "rnd_nlfsr"
        l = 16;                       % length of the shift register
        [p q] = nlfsr_poly(l);            % get a maximum length polynomial 
                                      % for the feedback function
        name = num2str(l) + "Bit NLFSR"; % create a nice heading for reports
        text =  " linear taps at " + num2str(p) + " + nonlinear taps at " + num2str(q);
        FILE = strcat(name, text);
        % generate the data
        data(1) = rnd_lfsr(p, l, seed);   % put in the seed (note it is a
                                         % parallel load)
        for i=[2 : samples]              % now generate the desired dataset
          data(i)=rnd_lfsr(p, l, data(i-1));  
        end

        disp("experimental");
        
    case "dummy"
        % create dummy testdata instead of getting it from file
        data  = randi(intmax(itype), [1 samples], itype);
        FILE  = 'dummy';
    
    case "reference"
        % reference can be 'ref1' ... 'refx'...see what is defined in the
        % fucntion
        refname = 'ref10';
        data = rng_reference(samples, refname, itype);
        FILE = strcat("reference", " - ", refname);

    case "gui"
        disp("not yet implemented");
    
    otherwise
        finish;
end
%% ProgrammControlBlock
PCB_settings        = true;
PCB_statistic       = false;
PCB_data_plots      = false;
PCB_statistic_plots = true;
PCB_simple2d_plots  = false;
PCB_simple3d_plots  = false;
PCB_scatter_plots   = false;
PCB_fft_plots       = false;
PCB_welch_plots     = false;
PCB_hilbert_plots   = false;
PCB_walsh_plots     = false;
PCB_dct_plots       = false;
PCB_wavelet_plots   = false;
PCB_spectral_plots  = false;
% ltfat toolbox

%% collect and report the settings
if PCB_settings
   rng_settings(samples, source, itype, seed, MajVer, MinVer)
end

%% do some statstic tests
% note no histcounts for uint32 or uint64 due to memory restrictions
% !!!Out not defined yet, just do some calc!!!!
if PCB_statistic
    rng_statistics(data); 
end

%% plot input data 
% see notes on histogram for uint32 or uint64 due to memory restrictions
if PCB_data_plots 
    rng_dataplots(data); 
end

%% do some statistics graphics
% see notes on histogram for uint32 or uint64 due to memory restrictions
if PCB_statistic_plots 
    rng_statisticplots(data); 
end

%% do some simple (2D) visual tests
if PCB_simple2d_plots 
    rng_simpleplots(data); 
end

%% do some simple (3D) visual tests
if PCB_simple3d_plots 
   disp("not yet implemented");
end

%% do some scatter visual tests
if PCB_scatter_plots 
    rng_cart_scatter_plot(data);
    rng_pol_scatter_plot(data);
end

%% do some tests based on fft
if PCB_fft_plots 
    rng_fft_plots(data);
end

%% do some tests based on welch
if PCB_welch_plots
    rng_welch_plots(data);
end

%% do some tests based on hilbert
if PCB_hilbert_plots
    rng_hilbert_plots(data);
end

%% do some tests based on walsh
if PCB_walsh_plots
    rng_walsh_plots(data);
end

%% do some tests based on DCT
if PCB_dct_plots
    rng_dct_plots(data);
end
%% do some tests based on wavelets
if PCB_wavelet_plots
    for w = ["haar" "db2" ] % "sym2" "coif1"]
       rng_wavelet_1D_1_plots(data,w);
       rng_wavelet_1D_2_plots(data,w);
    end
    %rng_cplx_wavlet_plot;
    %%rng_wavelet_1D_1_plots(data,'gaus');
    %%rng_wavelet_1D_2_plots(data,'gaus');
end
%% do some tests spectral analysis
if PCB_spectral_plots
    rng_spectral2(data);   
    rng_spectral1(data);
    rng_spectral3(data);
end

%% finalize
toc
%profile viewer;
%profile off;
% done