function c = threshysteris(a, T1, T2)

b = a > T1;
c = a > T2;

[w, h] = size(b);

e = zeros(w, h);
while sum(sum(abs(c - e))) > 0
    e = c;
    d = expand(c, 8, 1);
    c = d .* b;
end

