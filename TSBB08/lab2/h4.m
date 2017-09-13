function y = h4(x)

if abs(x > 1)
    y = 0;
else
    y = 2 * abs(x).^3 - 3 * x.^2 + 1;
end

