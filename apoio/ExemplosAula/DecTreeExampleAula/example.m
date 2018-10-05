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
y = [zeros(nFeats,1); ones(nFeats,1)];

%% Generate the classifier

t = classregtree(X,y);

%% Compute the classification error on the training set
yfit = eval(t,X);
fprintf('\nTr Set Accuracy: %f\n', mean(double((yfit>0.5) == y)) * 100);

%% Plot the tree
view(t);

%% Prune the tree
t2 = prune(t,'level',25);
view(t2);
yfit = eval(t2,X);
fprintf('\nTr Set Accuracy: %f\n', mean(double((yfit>0.5) == y)) * 100);



