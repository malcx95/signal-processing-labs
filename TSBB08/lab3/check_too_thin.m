function out = check_too_thin(in, step)
a = threshold (in, 128 ,'>');
colimage (a, 'gray', 1.0); % show intermediate result
b = contract(a, 8, step);
c = expand(b, 8, step + 1);
out = andBinary(invert(c), a);

