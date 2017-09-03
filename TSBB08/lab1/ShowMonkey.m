
im = double(imread('baboon.tif'));
figure(1);
colormap(gray());
subplot(1, 2, 1), imagesc(im, [0, 255]);
axis image; 
title('original image');
colorbar('SouthOutside');

subplot(1, 2, 2), imagesc(im, [50 200]);
axis image; 
title('high contrast image');
colorbar('SouthOutside');

% fprintf('Min value of baboon: %d\n', min(min(im)));
% fprintf('Max value of baboon: %d\n', max(max(im)));

figure(2);
imagesc(im, [0, 255]);
axis image;

mycolormap = gray(256);
mycolormap(1:51,:,:) = ones(51, 1) * [0 1 0]; % setting lower values to green
mycolormap(201:256,:,:) = ones(56, 1) * [0 0 1]; % higher to blue
colormap(mycolormap);
colorbar('SouthOutside');
title('Custom color map');

