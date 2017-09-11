Im = double(imread('logo.tif')); % load image

[Ny, Nx] = size(Im);
N = min(min(Nx,Ny));
[x,y] = meshgrid(-ceil((Nx-1)/2):floor((Nx-1)/2), ...
-ceil((Ny-1)/2):floor((Ny-1)/2));
mask = (x.^2 + y.^2)<((N-1)/2)^2;
Im = Im.* mask;

figure(1); colormap gray;
rotatedIm = rotateimage(Im, pi / 6, 'nearest');
nIm = rotateimage(rotatedIm, -pi / 6, 'nearest');
subplot(131); imagesc(Im); axis image; colorbar;
subplot(132); imagesc(rotatedIm); axis image; colorbar;
subplot(133); imagesc(nIm); axis image; colorbar;
