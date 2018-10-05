## Copyright (C) 2006 Michel D. Schmid  <michaelschmid@users.sourceforge.net>
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

## author: msd


## load data
mData = load("mData.txt","mData");
mData = mData.mData;
[nRows, nColumns] = size(mData);
# this file contains 13 columns. The first 12 columns are the inputs
# the last column is the output
# remove column 4, 8 and 12
# 89 rows

## this neural network example isn't a mirror of "the real life work"
## it will be used to compare the results with MATLAB(TM) results.

mOutput = mData(:,end);
mInput = mData(:,1:end-1);
mInput(:,[4 8 12]) = []; # delete column 4, 8 and 12

## now prepare data
mInput = mInput';
mOutput = mOutput';


# now split the data matrix in 3 pieces,
# train data, test data and validate data
# the proportion should be about 1/2 train,
# 1/3 test and 1/6 validate data
# in this neural network we have 12 weights,
# for each weight at least 3 train sets..
# (that's a rule of thumb like 1/2, 1/3 and 1/6)
# 1/2 of 89 = 44.5; let's take 44 for training
nTrainSets = floor(nRows/2);
# now the rest of the sets are again 100%
# ==> 2/3 for test sets and 1/3 for validate sets
nTestSets = (nRows-nTrainSets)/3*2;
nValiSets = nRows-nTrainSets-nTestSets;

# now divide mInput & mOutput in the three sets
mValiInput = mInput(:,1:nValiSets);
mValliOutput = mOutput(:,1:nValiSets);
mInput(:,1:nValiSets) = []; # delete validation set
mOutput(:,1:nValiSets) = []; # delete validation set
mTestInput = mInput(:,1:nTestSets);
mTestOutput = mOutput(:,1:nTestSets);
mInput(:,1:nTestSets) = []; # delete test set
mOutput(:,1:nTestSets) = []; # delete test set
mTrainInput = mInput(:,1:nTrainSets);
mTrainOutput = mOutput(:,1:nTrainSets);

[mTrainInputN,cMeanInput,cStdInput] = prestd(mTrainInput);# standardize inputs

## comments: there is no reason to standardize the outputs because we have only
# one output ...

# define the max and min inputs for each row
mMinMaxElements = min_max(mTrainInputN); # input matrix with (R x 2)...

%% define network
nHiddenNeurons = [2 2];
nOutputNeurons = 1;

MLPnet = newff(mMinMaxElements,[nHiddenNeurons nOutputNeurons],{'tansig','tansig','tansig','purelin'},'trainlm','learngdm','mse');
%% for test purpose, define weights by hand
# MLPnet.IW{1,1}(:) = 1.5;
# MLPnet.LW{2,1}(:) = 0.5;
# MLPnet.b{1,1}(:) = 1.5;
# MLPnet.b{2,1}(:) = 0.5;

## define validation data new, for MATLAB(TM) compatibility
VV.P = mValiInput;
VV.T = mValliOutput;

## standardize also the validate data
VV.P = trastd(VV.P,cMeanInput,cStdInput);

## now train the network structure
MLPnet.trainParam.show = NaN;
[net] = train(MLPnet,mTrainInputN,mTrainOutput,[],[],VV);

## make preparations for net test and test MLPnet
 # standardise input & output test data
[mTestInputN] = trastd(mTestInput,cMeanInput,cStdInput);

# will output the network results
[simOut] = sim(net,mTestInputN);
