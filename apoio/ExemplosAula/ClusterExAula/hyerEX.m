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
X12=X10';
[l,N]=size(X12);
figure(1), plot(X12(1,:),X12(2,:),'k.')
figure(1), axis equal

% Compute the distance matrix for the data vectors of X12
for i=1:N
    for j=i+1:N
        dista(i,j)=distan(X12(:,i),X12(:,j));
        dista(j,i)=dista(i,j);
    end
end

% Stack the computed distances to a data vector
dist_vec=[];
for i=1:N-1
    dist_vec=[dist_vec dista(i,i+1:N)];
end

% Apply the single link algorithm on X12 and draw the corresponding
% dissimilarity dendrogram
Z=linkage(dist_vec,'single');
[bel,thres]=agglom(dista,1); % 1 for single, 2 for complete link
figure(2), dendrogram(Z);

k=2;
IDX = bel(:,k);

% plot 
figure,
hold on;
data=X12';
for i=1:size(IDX,1)
    if IDX(i,1) == 1
        plot(data(i,1),data(i,2),'m+');
    elseif IDX(i,1) == 2
        plot(data(i,1),data(i,2),'g+');
    elseif IDX(i,1) == 3
        plot(data(i,1),data(i,2),'b+');
    elseif IDX(i,1) == 4
        plot(data(i,1),data(i,2),'r+');        
    end
end
hold off;
title('Clustering Results using single link');
grid on;shg

