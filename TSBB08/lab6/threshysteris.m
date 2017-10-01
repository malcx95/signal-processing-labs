function b = threshysteris(a, T1, T2)

e = 0
b = a > T1;
c = a > T2;
while b ~= e
    e = b;
    d = expand(b, 8, 1);
    b = d .* c;
end

