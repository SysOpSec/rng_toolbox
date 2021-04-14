function [p] = lfsr_poly(d)
% Return the (a) generatorpolynomial (minimal, irreducible) for the given 
% degree
%
%   Syntax:   [p] = lfsr_poly(d)
%   Input:    d  - degree of the polynome (equiv to the number of
%               registercells (e.g. for a 4ff shiftregister you need a 4th
%               degree polynom.
%             
%   Output:   n - an integer vector representing the polynome
%               e.g. [3 4] for a 4th degree polynome x^4 + x^3 + 1
%   
%   Polynomials are given for 4..32 and 64 for more polynomial refere to
%   https://users.ece.cmu.edu/~koopman/lfsr/index.html
%   or
%   http://courses.cse.tamu.edu/walker/csce680/lfsr_table.pdf
%   or
%   https://www.xilinx.com/support/documentation/application_notes/xapp210.pdf
%
%   All polynomials will have a cycle size of 2^n - 1 (max)
% ------------------------------------------------------------------------
% (c) 2019 Andreas Huemmer <andreas.huemmer@sysopsec.de>
%   v 1.0     initial version 
% ------------------------------------------------------------------------
    switch d
        case 4
            p = [3 4];      
        case 5
            p = [3 5]; 
        case 6
            p = [5 6];
        case 7
            p = [6 7];
        case 8
            p = [4 5 6 8];   
        case 9
            p = [5 9];   
        case 10
            p = [7 10];   
        case 11
            p = [9 11];   
        case 12
            p = [6 8 11 12];   
        case 13
            p = [9 10 12 13];   
        case 14
            p = [9 11 13 14];   
        case 15
            p = [14 15];   
        case 16
            p = [11 13 14 16];   
        case 17
            p = [14 17];   
        case 18
            p = [11 18];   
        case 19
            p = [14 17 18 19];   
        case 20
            p = [17 20];   
        case 21
            p = [19 21];   
        case 22
            p = [21 22];   
        case 23
            p = [18 23];   
        case 24
            p = [20 21 23 24];  
        case 25
            p = [22 25];  
        case 26
            p = [20 24 25 26];  
        case 27
            p = [22 25 26 27];   
        case 28
            p = [25 28];   
        case 29            
            p = [27 29];   
        case 30
            p = [24 26 29 30];   
        case 31            
            p = [28 31];   
        case 32
            p = [25 26 30 32];   
        case 64
            p = [60 61 63 64];   
        otherwise
            fprintf('Polynomial degree must be within 4..32 or 64 \n (you may look in the refeneced material \n for extending the list)\n');
    end
end

