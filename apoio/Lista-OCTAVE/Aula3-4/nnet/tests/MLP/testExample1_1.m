## Copyright (C) 2007 Michel D. Schmid <michaelschmid@users.sourceforge.net>
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
## along with this program; see the file COPYING.  If not, see
## <http://www.gnu.org/licenses/>.

## author: msd


## This file is used to test all the m-files inside
## the example1 directory.

## it exist for each m-file a corresponding dat-file with
## the numerical results of matlab

## actually, following m-files will be tested:
## A. One hidden layer
## ==================
## 1. mlp9_1_1_tansig
## 2. mlp9_2_1_tansig
## 3. mlp9_2_2_tansig
## 4. mlp9_2_3_tansig
## 5. mlp9_5_3_tansig
##
## B. Two hidden layer
## ==================


####### mlp9_1_1_tansig ######
%!shared cAr, mTestResults, simOut, line, fid
%!  diary log_test1_1
%!  dir = "example1";
%!  [cAr, mTestResults] = loadtestresults([dir "/mlp9_1_1_tansig.dat"]);
%!  preparedata9_x_1;
%!  [mTrainInputN,cMeanInput,cStdInput] = prestd(mTrainInput);# standardize inputs
%!  mMinMaxElements = min_max(mTrainInputN); # input matrix with (R x 2)...
%!  nHiddenNeurons = 1;
%!  nOutputNeurons = 1;
%!  MLPnet = newff(mMinMaxElements,[nHiddenNeurons nOutputNeurons],{"tansig","purelin"},"trainlm","learngdm","mse");
%!  MLPnet.IW{1,1}(:) = 1.5;
%!  MLPnet.LW{2,1}(:) = 0.5;
%!  MLPnet.b{1,1}(:) = 1.5;
%!  MLPnet.b{2,1}(:) = 0.5;
%!  VV.P = mValiInput;
%!  VV.T = mValliOutput;
%!  VV.P = trastd(VV.P,cMeanInput,cStdInput);
%!  [net] = train(MLPnet,mTrainInputN,mTrainOutput,[],[],VV);
%!  [mTestInputN] = trastd(mTestInput,cMeanInput,cStdInput);
%!  [simOut] = sim(net,mTestInputN);
%!assert(simOut,mTestResults,0.0001)
%!  diary off ;
%!  fid = fopen("log_test1_1","r");
%!  line = fgetl(fid);
%!	if (line==-1)
%!    error("no String in Line: Row 67");
%!  endif
%!assert(substr(line,16,1),substr(cAr{1,1},16,1))
%!assert(substr(line,27,7),substr(cAr{1,1},27,7))
%!assert(substr(line,47,7),substr(cAr{1,1},47,7))
%!  line = fgetl(fid);
%!assert(substr(line,16,1),substr(cAr{1,2},16,1))
%!assert(substr(line,27,7),substr(cAr{1,2},27,7))
%!assert(substr(line,48,6),substr(cAr{1,2},48,6))
%!assert(strcmp("TRAINLM, Validation stop.",substr(cAr{1,3},1,25)))
%!  fclose(fid);

