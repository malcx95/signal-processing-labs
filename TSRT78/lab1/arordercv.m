function [n, W] = arordercv(y1, y2, nmax)

for n = 1:nmax
    th = sig2ar(y1, n);
    e2 = filter([1; th], 1, y2);
    W(n) = e2'*e2/(y2'*y2);
end

if nargout == 0
    figure
    plot(1:nmax, W, '-o')
else
    [~, n] = min(W);
end

