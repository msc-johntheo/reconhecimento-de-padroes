% Example 7.6.2
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear;

% 1. Generate the data set X10
rand('seed',0)
R1=3; %Radius of the 1st circle
R2=6; %Radius of the 2nd circle
center=[0 0; 1 1]'; % Centers of the circles (in columns)
n_points=[200 200]; %Number of points per cluster
step1=2*R1/(n_points(1)/2-1);
step2=2*R2/(n_points(2)/2-1);
% Points around the first circle
X10=[];
for x=-R1+center(1,1):step1:R1+center(1,1)
    y=sqrt(R1^2-(x-center(1,1))^2);
    X10=[X10; x center(2,1)+y+rand-.5; x center(2,1)-y+rand-.5];
end
% Points around the second circle
for x=-R2+center(1,2):step2:R2+center(1,2)
    y=sqrt(R2^2-(x-center(1,2))^2);
    X10=[X10; x center(2,2)+y+rand-.5; x center(2,2)-y+rand-.5];
end

% Plot the data set
X10=X10';
[l,N]=size(X10);
figure(1), plot(X10(1,:),X10(2,:),'k.')
figure(1), axis equal
data = X10';

% perform kmeans clustering on the matrix U
[IDX,C] = kmeans(data,2); 

% plot the eigen vector corresponding to the largest eigen value
%figure,plot(IDX)
figure,
hold on;
for i=1:size(IDX,1)
    if IDX(i,1) == 1
        plot(data(i,1),data(i,2),'m+');
    else IDX(i,1) == 2
        plot(data(i,1),data(i,2),'g+');
    end
end
hold off;
title('Clustering Results using K-means on data');
grid on;shg

