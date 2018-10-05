close all; clc; clear; rand('seed',0); randn('seed',0);

%% Dataset
mu1 = [ 1, 1 ].';
mu2 = [ 1.5, 1.5 ].';
sigmasSquared = 0.2; 
d = size(mu1,1); 
 
nFeats = 1000; 
 
X1 = mvnrnd( mu1, sigmasSquared*eye(d), nFeats ); 
X2 = mvnrnd( mu2, sigmasSquared*eye(d), nFeats ); 
 
h1 = plot( X1(:,1), X1(:,2), '.b' ); hold on; 
h2 = plot( X2(:,1), X2(:,2), '.r' ); hold on; 
legend( [h1,h2], {'classe 1', 'classe 2'} ); 

X = [X1; X2];
y = [ones(nFeats,1); 2*ones(nFeats,1)];

%% Initialize parameters
fprintf('Initializing parameters');
m = size(X, 1); % number of examples
lambda = 0; % regularization parameter
numLabels = size(unique(y),1); % number of labels
fprintf('...done\n');

%% Training Logistic Regression classifier
fprintf('Training Logistic Regression');

theta = LRClassifier(X, y, numLabels, lambda);
fprintf('...done\n');

%% Predict numbers 
prediction = predict(theta, X);

%% Calculate Accuracy over the training data
fprintf('\nTest Set Accuracy: %f\n', mean(double(prediction == y)) * 100);

