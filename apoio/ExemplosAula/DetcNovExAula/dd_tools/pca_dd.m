%PCA_DD Principal Component data description
%
%       W = PCA_DD(A,FRACREJ,N)
%       W = PCA_DD(A,FRACREJ,VAR)
%
% Fit a Principal Component Analysis data description by estimating
% first a PCA on the target class, and mapping the training data onto
% the PCA subspace. The distance between the original objects and the
% mapped objects is used to detect outliers. 
% The number of dimensions of the PCA can be supplied by N.
% Alternatively the fraction of explained variance can be given (in
% VAR).
%
% Default: FRACRE=0.05, VAR=0.9

% Copyright: D.M.J. Tax, D.M.J.Tax@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function W = pca_dd(a,fracrej,n)

if (nargin<3)
	n = 0.9;
end
if (nargin<2)
	fracrej = 0.05;
end
if (nargin<1)||isempty(a)
	W = mapping(mfilename,{fracrej,n});
	if (n<1)
		W = setname(W,'PCA dd (%4.2f)',n);
	else
		W = setname(W,'PCA dd (%dD)',n);
	end
	return
end

if ~ismapping(fracrej)           %training

	% remove the labels:
	a = target_class(a);     % only use the target class
	[m,k] = size(a);
	% Be careful with the mean:
	meana = repmat(mean(a),m,1);
	a = (a - meana);

	% Train it and compute the reconstruction error:
	w = pca(a,n);
	W = w.data.rot;
	dim = size(W,2);
	if dim==k
		warning('dd_tools:NoFeatureReduction',...
			'Output dimensionality is equal to input dimensionality!');
	end
	Proj = W*inv(W'*W)*W';
	% project and find the distribution of the distance:
	dif = a - a*Proj;
	d = sum(dif.*dif,2);

	% obtain the threshold:
	thr = dd_threshold(d,1-fracrej);

	%and save all useful data:
	% (I know I just have to store W instead of Proj, but I do not like
	% to compute the inverse of W'*W over and over again, this uses just
	% some disk/memory space):
	W = [];  % W was already used, forget that one...
	W.P = Proj;
	W.mean = meana(1,:);
	W.dim = dim;  %just for inspection...
	W.threshold = thr;
	W.scale = mean(d);
	W = mapping(mfilename,'trained',W,str2mat('target','outlier'),k,2);
	if (n<1)
		W = setname(W,'PCA dd (%4.2f)',n);
	else
		W = setname(W,'PCA dd (%dD)',n);
	end

else                               %testing

	W = getdata(fracrej);  % unpack
	m = size(a,1);

	%compute reconstruction error:
	dif = +a - repmat(W.mean,m,1);
	dif = dif - dif*W.P;
	out = sum(dif.*dif,2);
	newout = [out, repmat(W.threshold,m,1)];

	% Store the distance as output:
	W = setdat(a,-newout,fracrej);
	W = setfeatdom(W,{[-inf 0;-inf 0] [-inf 0;-inf 0]});
end

return
