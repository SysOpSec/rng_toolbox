function [fdata, n] = rng_loaddata(f, s, b)
% Load a dataset from a binary randomnumbersource
%   Syntax:   [rngdata, n ] = rng_loaddata(f, s, b)
%   Input:      f - file to load from - string
%               s - how many sample to load - decimal	             
%               b - uint datatype
%   Output:     rngdata - vector rngdata
%               n - numer of values loaded
%   
%   Please note that you might need to increase matlabs memory stack for loading big data sets
% ------------------------------------------------------------------------
% (c) 2021 Andreas Huemmer <andreas.huemmer@sysopsec.de>
%   v 1.0     initial version 
% ------------------------------------------------------------------------

% open file readmode
  fileID  = fopen(f,'r');

% get the data
  if b == "uint8"
    fdata = uint8(fread(fileID, [1 s], b));
  elseif b == "uint16"
    fdata = uint16(fread(fileID, [1 s], b));
  elseif b == "uint32"
    fdata = uint32(fread(fileID, [1 s], b));
  else
        disp("The given dataset has to be type of uint8, uint16 or uint32");
        return;
  end

  n = numel(fdata);

  %close the file
  fclose(fileID);

end

