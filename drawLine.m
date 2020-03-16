function drawLine(p1, p2, varargin)
%This function draws a line from point p1 to point p2

plot([p1(1) p2(1)], [p1(2) p2(2)], 'k', varargin{:});

end