Im = double(imread('logo.tif')); % load image
T = [1 -1/3; 0 1]; % assign shear matrix

figure(1); colormap gray;
tic;
shearIm = shearimage(Im,T);
fprintf('ShearImage took %f seconds\n', toc);
subplot(221); imagesc(Im); axis image; colorbar;
subplot(222); imagesc(shearIm); axis image; colorbar;

tic;
shearIm = shearimageFast(Im,T);
fprintf('ShearImageFast took %f seconds\n', toc);
subplot(223); imagesc(Im); axis image; colorbar;
subplot(224); imagesc(shearIm); axis image; colorbar;

