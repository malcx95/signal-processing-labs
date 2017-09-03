% Original image
im = double(imread('baboon.tif'));
figure(1);
colormap(gray(256));
subplot(1,2,1), imagesc(im, [0 255]);
axis image; 
title('original image');
colorbar('SouthOutside');

% Filtered image
aver = [1 2 1; 2 4 2; 1 2 1] / 16;
imaver = im
for i = 1:3
    imaver = conv2(imaver, aver, 'same');
end
subplot(1, 2, 2), imagesc(imaver, [0, 255]);
axis image; 
title('filtered image');
colorbar('SouthOutside');

