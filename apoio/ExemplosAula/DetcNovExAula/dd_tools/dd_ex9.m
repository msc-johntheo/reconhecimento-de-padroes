% Show the crossvalidation procedure
%
% Generate some simple data, split it in training and testing data using
% 10-fold cross-validation, and compare several one-class classifiers on
% it.

% Copyright: D.M.J. Tax, D.M.J.Tax@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands
clear all
clc

% Standard parameter:
frac = 0.1;
reg = 1e-2;
% Define the classifiers
% w = {gauss_dd([],frac,reg)*dd_normc
%      mog_dd([],frac,3,'full',reg)*dd_normc
% 	  svdd([],frac,5)*dd_normc
% 	  };
w = {svdd([],frac,5)};
    %svdd_ml_ref([],frac,10,0.5)};
nrcl = length(w);
% Define the number of cross-validations:
nrbags = 10;

% Generating some OC dataset:
%a = oc_set(gendatb([100 60],1.6),'1');
load('oc_511.mat');
a=x;

% Set up:
auc = zeros(nrcl,nrbags);
I = nrbags;
% Run over the crossvalidation runs:
for i=1:nrbags
	[x,z,I] = dd_crossval(a,I);

	% Train three classifiers:
	for j=1:nrcl
		wtr = x*w{j};
		% evaluate the classifiers:
		auc(j,i) = dd_auc(z*wtr*dd_roc);
	end

end

% And the results:
for i=1:nrcl
	fprintf('w%d : %5.3f (%5.3f)\n',i,mean(auc(i,:),2),std(auc(i,:),[],2));
end
