function plotDataPoints(X, idx, K)
%This function plots data points in X, with grouped colors

% Created color palette
palette = hsv(K + 1);
colors = palette(idx, :);

% Scatter Plot
scatter(X(:,1), X(:,2), 15, colors);

end
