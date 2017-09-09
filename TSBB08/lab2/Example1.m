Im = double(imread('logo.tif')); % load image
T = [1 -1/3; 0 1]; % assign shear matrix

figure(1); colormap gray;
shearIm = shearimage(Im,T);
subplot(121); imagesc(Im); axis image; colorbar;
subplot(122); imagesc(shearIm); axis image; colorbar;
