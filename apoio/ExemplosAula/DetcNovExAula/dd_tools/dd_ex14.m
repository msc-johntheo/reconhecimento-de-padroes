% Show the combination of a one-class classifier and a standard
% multi-class classifier

% Generate data:
a = gendatb([100 100]);
a = setlablist(a,{'apple' 'banana'});

% Train a combination of a Gaussian one-class classifier and a Parzen
% density estimator
w = ocmcc(a,gauss_dd([],0.05), parzenc);

% Show it in a scatterplot:
figure(1); clf; scatterd(a,'legend'); 
plotc(w)

% And the confusion matrix becomes:
confmat(getlab(a),a*w*labeld)

