function b = threshysteris2(a, T1, T2)

b = a < T1;
c = a < T2;

[w, h] = size(b);

e = zeros(w, h);
while sum(sum(abs(b - e))) > 0
    e = b;
    d = expand(b, 8, 1);
    b = d .* c;
end

