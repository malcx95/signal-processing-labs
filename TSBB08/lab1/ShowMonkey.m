
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



