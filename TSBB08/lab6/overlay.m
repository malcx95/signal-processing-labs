function res = overlay(img1, img2)

[w, h] = size(img1);

res = zeros(w, h, 3);

img1n = img1 ./ 255;

res(:,:,1) = img2;
res(:,:,2) = img1n;
res(:,:,3) = img1n;

