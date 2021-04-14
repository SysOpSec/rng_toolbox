function [SS, OP, SM] = rng_userIF()
%Get interactive input from the user
%   INPUTS: - none-
%   OUTPUTS:  SS: sample size as binary exponent
%             OP: which type of subsystem do you want to run
%             SM: save the graphics to file?
% ------------------------------------------------------------------------
% (c) 2021 Andreas Huemmer <andreas.huemmer@sysopsec.de>
%   v 1.0     initial version 
% ------------------------------------------------------------------------

    quest = { 'Enter a binary exponent to specify sample size (2^x)';
              'Enter teh Opmode (file, dummy, matlab, rnd_lincon, rnd_lfsr, rnd_nlfsr';
              'Shall the output be saved as graphics (yes/no)' }
    answ = inputdlg(quest, 'Give some parameters or leave empty for defaults');      

    %process input
    ssin = sscanf(answ{1},'%g');
    if ssin > 1 && ssin <= 31
        SS = ssin;
    else
        disp('Invalid input, setting default (16)');
        SS = 16;
    end
    opin = answ{2};
    if opin != ""
        %check against list
    else
        OP = 'dummy';
    end
    smin = answ{3};
    if smin == "yes"
        SM = true;
    else
        SM=false;
    end

% h=msgbox([ VARIAble 'blablubb '1 ]);

% MATLAB THROUGH GUIDED PROBLEM SOLVING: Video 71 (gui to create random
% landscapes, Video 72 (GUIDE)
end

