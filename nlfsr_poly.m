function [p q] = nlfsr_poly(d)
% Return the (a) generatorpolynomial (minimal, irreducible) for the given 
% degree
%
%   Syntax:   [p, q] = nlfsr_poly(d)
%   Input:    d  - degree of the polynome (equiv to the number of
%               registercells (e.g. for a 4ff shiftregister you need a 4th
%               degree polynom.
%             
%   Output:   p - an integer vector representing the polynome
%               e.g. [3 4] for a 4th degree polynome x^4 + x^3 + 1
%			  q - an integer vector representing the non linear polynom
%   
%   Polynomials are given for 4..24 for more polynomial refere to
%   https://users.ece.cmu.edu/~koopman/lfsr/index.html
%   or
%   http://courses.cse.tamu.edu/walker/csce680/lfsr_table.pdf
%   or
%   https://www.xilinx.com/support/documentation/application_notes/xapp210.pdf
%
%	For nonlinear polynomcombinations for nlfsr with max period, pls refere to
%	https://people.kth.se/~dubrova/nlfsr.html
%	pls note that polynomials in this work are in reverse order thus, the msb is 
%	indexed as 0. Note 2: only one polynomcombination from several posibilities is
%	implemented here.
%
%   All polynomials will have a cycle size of 2^n - 1 (max)
% ------------------------------------------------------------------------
% (c) 2019 Andreas Huemmer <andreas.huemmer@sysopsec.de>
%   v 1.0     initial version 
% ------------------------------------------------------------------------
    switch d
        case 4
            p = [2 3 4];
            q = [2 3];		
        case 5
            p = [3 4 5]; 
			q = [1 3];
        case 6
            p = [4 5 6];
			q = [4 5];
        case 7
            p = [3 6 7];
			q = [4 6];
        case 8
            p = [3 7 8];   
			q = [3 7];
        case 9
            p = [3 8 9];   
			q = [3 5];
        case 10
            p = [8 9 10];
            q = [1 2];
        case 11
            p = [2 10 11];   
            q = [7 10];
        case 12
            p = [4 9 12];   
            q = [3 9];
        case 13
            p = [2 12 13];   
            q = [4 8];
        case 14
            p = [12 13 14];   
            q = [2 7];
        case 15
            p = [6 10 15];   
            q = [4 13];
        case 16
            p = [3 14 16];
            q = [13 14];
        case 17
            p = [5 8 14 16 17];
            q = [4 10];
        case 18
            p = [5 7 9 15 18];  
            q = [2 14]; 
        case 19
            p = [7 10 19];
            q = [6 18];
        case 20
            p = [5 13 14 16 20];
            q = [13 17];
        case 21
            p = [2 4 6 20 21];   
            q = [6 8];
        case 22
            p = [10 14 16 21 22];   
            q = [5 12];
        case 23
            p = [9 13 17 21 23];   
            q = [10 18];
        case 24
            p = [9 15 16 23 24];  
            q = [6 17];
        otherwise
            fprintf('Polynomial degree must be within 4..24\n (you may look in the refeneced material \n for extending the list)\n');
    end
end

