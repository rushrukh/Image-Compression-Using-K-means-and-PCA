% Problem Statement
% The arrays are storing 6 sink co-ordinates p1(1,2), p2(5,8), p3(1.5, 1.8)...
% Apply K-means clustering (assume 2 cluster in this case). 
% Build a connected network, where you need to route a signal from a source to each 6-sinks.
% After clustering, you have 2 clusters (2 centroids, assume C1, C2), 
% probably each cluster contains 3-sinks. 
% Measure each centroids to sinks distances (d1, d2, d3 for cluster 1) and 
% (d4, d5, d6 for cluster 2). Assign the max(d1, d2,....d6) = dmax, as a height of network.
% Now find a path that will assign origin O=(0,0) to common point (X1), 
% then go to each C1, C2. Then C1-->p1 with a length dmax, C1-->p2 with a length dmax
% .......C2-->p4 = dmax, C-->p5 = dmax.
% x = [1, 5, 1.5, 8, 1, 9]
% y = [2, 8, 1.8, 9, 0.6, 11]
% Eventually, draw the network as O-->X1-->C1, X1-->C2, C1-->p1, 
% C1-->p2, C1-->p3, C2-->p4, C2-->p5, C2-->p6
% Apply same method when you assign distance for X1-->C1 and X1-->C2.
% Assume X1 is the centroid of C1 and C2

clear;
close all;
clc;

%The array  storing 6 sink co-ordinates
X = [1 2; 5 8; 1.5 1.8; 8 9; 1 0.6; 9 11];
%cluster size
K = 2;
initial_centroids = [3 3; 6 2];
%as working with very few points 5 times of iterations are more than enough
max_iters = 5;
%clustering the points using k-means clustering
fprintf('\n(Running k-means clustering on data points)\n');
figure(1)
[centroids, idx] = runkMeans(X, initial_centroids, max_iters, true);
hold on

fprintf('Centroid allotment for the points: \n')
fprintf(' %d', idx(:));
fprintf('Centroids computed after initial finding of closest centroids: \n')
fprintf(' %f %f \n' , centroids');

%Seperating the two cluster points 
c1 = 1;
c2 = 1;
for x = 1 : size(X,1)
    if idx(x) == 1
        clus1(c1,:) = X(x,:);
        c1 = c1 + 1;
    else
        clus2(c2,:) = X(x,:); 
        c2 = c2 + 1;
    end
end

%finding highest distance from the centroids
temp1 = bsxfun(@minus, clus1 , centroids(1, :));
dist1 = sum(temp1.^2, 2);

temp2 = bsxfun(@minus, clus2 , centroids(2, :));
dist2 = sum(temp2.^2, 2);

dist = [dist1;dist2];
dmax = sqrt(max(dist));

%finding out a common point between the two centroids
fprintf('\n(Running k-means clustering on two centroids )\n');
common = runkMeans(centroids, [0 0], max_iters, false);
hold off 

%assigning the origin O=(0,0) to common point 
clus1 = bsxfun(@minus, clus1 , common);
clus2 = bsxfun(@minus, clus2 , common);
centroids = bsxfun(@minus, centroids , common);
common = [0 0];

fprintf('New Centroids computed after origin transfered: \n')
fprintf(' %f %f \n' , centroids');

%Finding  C1-->p1 with a length dmax, C1-->p2 with a length dmax
% .......C2-->p4 = dmax, C-->p5 = dmax

new_sink_loc1 = reallocate(clus1, centroids(1,:), dmax);

new_sink_loc2 = reallocate(clus2, centroids(2,:), dmax);

% drawing the network as O-->X1-->C1, X1-->C2, C1-->p1, 
% C1-->p2, C1-->p3, C2-->p4, C2-->p5, C2-->p6
figure(2)
plotDataPoints([new_sink_loc1; new_sink_loc2], [ones(size(clus1,1),1); 2 * ones(size(clus1,1),1)], K);
hold on
plot(centroids(:,1), centroids(:,2), 'o', ...
     'MarkerEdgeColor','k', ...
     'MarkerSize', 10, 'LineWidth', 3);
hold on
plot(common(:,1), common(:,2), 'O', ...
     'MarkerEdgeColor','b', ...
     'MarkerSize', 12, 'LineWidth', 3);
hold on
drawLine(centroids(1, :), common(:, :));
hold on
drawLine(centroids(2, :), common(:, :));
hold on
for i = 1:size(clus1, 1)
    drawLine(centroids(1, :), new_sink_loc1(i, :));
end
for i = 1:size(clus2, 1)
    drawLine(centroids(2, :), new_sink_loc2(i, :));
end

hold off