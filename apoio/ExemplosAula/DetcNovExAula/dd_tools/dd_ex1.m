clear all
clc

% generate normal classification problem: train data:
a = gendatb([30 30]);
% make the second class the target class and change the labels:
a = oc_set(a,'1');
% only use target class:
a = target_class(a);

% first show a 2D plot:
figure(1); clf; hold on; H = [0;0];
h = scatterd(a);
V = axis; axis(1.5*V);

% train the individual data descriptions and plot them
% the error on the target class:
fracrej = 0.2;
% train the nndd:
w1 = knndd(a,fracrej,3);
% and plot the decision boundary:
h = plotc(w1,'k-');
H(1) = h(1);
% second, train the svdd:
w2 = svdd(a,fracrej,7);
% and also plot this:
h = plotc(w2,'r--');
H(2) = h(1);
% second, train the svdd:
w3 = kmeans_dd(a,fracrej,3);
% and also plot this:
h = plotc(w3,'b--');
H(3) = h(1);
legend(H,'kNNdd','SVDD','kMeans');
axis equal;
axis image;




