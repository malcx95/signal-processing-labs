function out = minalgoritm (in, step)
a = threshold (in, 128 ,'>');
colimage (a, 'gray', 1.0); % show intermediate result
b = expand (a, 8, step);
c = contract(b, 8, step + 1);
out = andBinary(c, invert(a));
