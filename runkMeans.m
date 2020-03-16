function [centroids, idx] = runkMeans(X, initial_centroids, ...
                                      max_iters, plot_progress)
%This function runs the K-Means algorithm on data matrix X

% Initiali values
[m n] = size(X);
K = size(initial_centroids, 1);
centroids = initial_centroids;
previous_centroids = centroids;
idx = zeros(m, 1);

% Running K-Means
for i=1:max_iters    
    % Output progress
    %fprintf('K-Means iteration %d/%d...\n', i, max_iters);
    % For each example in X, closest centroid is assigned
    idx = findClosestCentroids(X, centroids);
    % Given the memberships, new centroids are computed
    centroids = computeCentroids(X, idx, K);
end

%plotDataPoints(X, idx, K);
%hold on;
%plot(centroids(:,1), centroids(:,2), 'o', ...
%     'MarkerEdgeColor','k', ...
 %    'MarkerSize', 10, 'LineWidth', 3);

end

