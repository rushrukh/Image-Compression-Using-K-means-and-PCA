function idx = findClosestCentroids(X, centroids)
k = size(centroids, 1);
idx = zeros(size(X,1), 1);

dist = zeros(size(X,1), k);
for cntr = 1 : k
    temp = bsxfun(@minus, X , centroids(cntr, :));
    dist(:,cntr) = sum(temp.^2, 2);
end

[Y,idx] = min(dist, [], 2);

end

