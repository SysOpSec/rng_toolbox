function [a c m name txt] = lincon(d)
% Return the parameter of the given congruencegenerator identified by its
% ID
%   Syntax:   [a c m name txt] = lincon(d)
%   Input:    d  - ID of the mixed linearcongruence generator in the
%               datamatrix in this m-file
%             
%   Output:   a - the additive constant
%             c - the multiplicative constant
%             m - the modulo
%             name - the short name (aka) of this parameter set
%             txt - a text containing addl. information
%   
% ------------------------------------------------------------------------
% (c) 2019 Andreas Huemmer <andreas.huemmer@sysopsec.de>
%   v 1.0     initial version 
% ------------------------------------------------------------------------
% If you have other generatros pls. give me a hint on it, if possible along
% with some reference to spec or whatsoever so that I can put it in here.
% ------------------------------------------------------------------------
    switch d
        case 1
            name = 'RANDU';  
            txt = ' - IBM Mainframes (historisch)';
            a = uint64(0);
            c = uint64(2^16 + 3);
            m = uint64(2^31);
        case 2
            name = 'TI-59';  
            txt = ' - Tablecalculator from Texas Instruments';
            a = uint64(99991);
            c = uint64(24298);
            m = uint64(199017);
        case 3
            name = 'Unix';  
            txt = ' - used in historical Unix implementations';
            a = uint64(12345);
            c = uint64(1103515245);
            m = uint64(2^32);
        case 4
            name = 'UNIVAC';  
            txt = ' - used on SIMULA/UNIVAC Systems in the past';
            a = uint64(0);
            c = uint64(5^13);
            m = uint64(2^31);
        case 5
            name = 'SIMPL-I';  
            txt = ' - used used bei IBM in the past';
            a = uint64(0);
            c = uint64(48271);
            m = uint64(2^31 - 1);
        case 6
            name = 'SIMSCRIPT-II5';  
            txt = ' - used in the past';
            a = uint64(0);
            c = uint64(630360016);
            m = uint64(2^31 - 1);
        case 7
            name = 'LECUYER';  
            txt = ' - used in the past';
            a = uint64(0);
            c = uint64(4645906587823291368);
            m = uint64(2^63 - 25);
        case 8
            name = 'VAX/VMS';  
            txt = ' - used in Fortran RAN and Basic RND function in the past';
            a = uint64(1);
            c = uint64(69069);
            m = uint64(2^32);
        case 9
            name = 'VAX C';  
            txt = ' - used in C rand() in the past';
            a = uint64(12345);
            c = uint64(1103515245);
            m = uint64(2^31);
        case 10
            name = 'Microsoft C v4.0';  
            txt = ' - used in the rand() function';
            a = uint64(2531011);
            c = uint64(214013);
            m = uint64(2^31);
        case 11
            name = 'Turbo Pascal v6.0';  
            txt = ' - used in the random function';
            a = uint64(1);
            c = uint64(134775813);
            m = uint64(2^32);
        case 12
            name = 'Ansi-C';  % as suggested by Kerningham/Ritchi
            txt = ' - used in the rand() function';
            a = uint64(12345);
            c = uint64(1103515245);
            m = uint64(2^15);

        
        otherwise
            fprintf('No such linear congruence generator with that ID can \nbe found in this list)\n');
    end
                 
end

