function res = raw2rgb(raw)

im = im2double(raw);

[rows,cols,ndim] = size(im);
mask1 = zeros(rows, cols);
mask1(2:2:end,2:2:end) = 1;

mask2 = zeros(rows, cols);
mask2(1:2:end,2:2:end) = 1;
mask2(2:2:end,1:2:end) = 1;

mask3 = zeros(rows, cols);
mask3(1:2:end,1:2:end) = 1;

f = [1 2 1]/4;

imgred = conv2(f, f, im.*mask1, 'same')./conv2(f, f, mask1, 'same');
imggreen = conv2(f, f, im.*mask2, 'same')./conv2(f, f, mask2, 'same');
imgblue = conv2(f, f, im.*mask3, 'same')./conv2(f, f, mask3, 'same');

res = reshape([imgred imggreen imgblue], [size(im) 3]);

