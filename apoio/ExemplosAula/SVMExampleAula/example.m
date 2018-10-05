close all; clc; clear; rand('seed',0); randn('seed',0);

%% Dataset
mu1 = [ 1, 1 ].';
mu2 = [ 1.5, 1.5 ].';
sigmasSquared = 0.2; 
d = size(mu1,1); 
 
nFeats = 200; 
 
X1 = mvnrnd( mu1, sigmasSquared*eye(d), nFeats ); 
X2 = mvnrnd( mu2, sigmasSquared*eye(d), nFeats ); 
 
figure(1), plot(X1(:,1),X1(:,2),'r.', X2(:,1),X2(:,2),'bo');

X = [X1; X2];
y = [ones(nFeats,1); -1*ones(nFeats,1)];

%% Generate the required SVM classifier
kernel='linear';
kpar1=0;
kpar2=0;
C=5; 
tol=0.001;
steps=100000;
eps=10^(-10);
method=0;
[alpha, w0, w, evals, stp, glob] = SMO2(X, y,kernel, kpar1, kpar2, C, tol, steps, eps, method);

%% Compute the classification error on the training set
acuracia = 1 - (sum((2*(w*X'-w0>0)-1).*y'<0)/length(y));

%% Plot the classifier hyperplane
global figt4
figt4=2;
svcplot_book(X,y,kernel,kpar1,kpar2,alpha,-w0);



