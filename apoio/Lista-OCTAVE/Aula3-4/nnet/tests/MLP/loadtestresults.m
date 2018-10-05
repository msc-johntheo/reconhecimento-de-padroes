## Copyright (C) 2007 Michel D. Schmid  <michaelschmid@users.sourceforge.net>
##
##
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2, or (at your option)
## any later version.
##
## This program is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
## General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program; see the file COPYING.  If not, write to the Free
## Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
## 02110-1301, USA.

## Author: Michel D. Schmid

function [cAr mData] = loadtestresults(strFileName)

  ## check range of input arguments
  error(nargchk(1,1,nargin))

  i = 1;
  mData = [];
  cAr = {};

  fid = fopen(strFileName,"rt"); # open read only

  strLine = fgetl(fid);
  while (!feof(fid)) # this means, while not eof

    [val, count] = sscanf (strLine, "%f");
    if (count)
      mData = [mData; val'];
    else
      cAr{i} = strLine;
    endif

    strLine = fgetl(fid);
    i += 1;
  endwhile
  
  # here, the strLine contains the last row of a file
  # so do the complete coding once more
  [val, count] = sscanf (strLine, "%f");
  if (count)
    mData = [mData; val'];
  else
    cAr{i} = strLine;
  endif

  fclose(fid);
  
endfunction