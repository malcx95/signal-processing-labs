% Read original image;
im = double(imread('cmanmod.png'));

figure(1)
colormap(gray(256))
subplot(1,1,1); imagesc(im, [0 256]); colorbar;
axis image; axis off;

% Compute derivative images
dxf = [1 0 -1; 2 0 -2; 1 0 -1]/8; % sobelx
fx=conv2(im,dxf, 'valid'); % With valid you get rid of the dark frame
maxv = max(max(abs(fx)))/2;

dyf = rot90(dxf, 3); % sobely
fy=conv2(im,dyf, 'valid'); % With valid you get rid of the dark frame
maxvy = max(max(abs(fy)))/2;

figure(2)
colormap(gray(256))
subplot(1,2,1); imagesc(fx, [-maxv maxv]); colorbar('horizontal'); 
title('f_x')
axis image; axis off;
subplot(1,2,2); imagesc(fy, [-maxvy maxvy]); colorbar('horizontal'); 
title('f_y')
axis image; axis off;

figure(3)
colormap(gray(256))
subplot(1,2,1); imagesc(fx.^2, [0 maxv^2]); colorbar('horizontal'); 
title('T_{11}')
axis image; axis off;
subplot(1,2,2); imagesc(fy.^2, [0 maxvy^2]); colorbar('horizontal'); 
title('T_{22}')
axis image; axis off;


