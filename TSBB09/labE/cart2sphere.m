function res = cart2sphere(x)

dist = sqrt(x(1,:,:).^2 + x(2,:,:).^2 + 1);

res = x./[dist;dist;dist];

