Im = double(imread('logo.tif'));
[Ny, Nx] = size(Im);
N = min(min(Nx,Ny));
[x,y] = meshgrid(-ceil((Nx-1)/2):floor((Nx-1)/2), ...
-ceil((Ny-1)/2):floor((Ny-1)/2));
mask = (x.^2 + y.^2)<((N-1)/2)^2;
Im = Im.* mask;
[rows, cols] = size(Im);
cx = cols/2;
cy = rows/2;
[X1, Y1] = meshgrid(1:cols, 1:rows); % inimage grid
[X2, Y2] = meshgrid(1:cols, 1:rows); % outimage grid
phi = pi/6;
X1interp = cos(phi)*(X2-cx) - sin(phi)*(Y2-cy) + cx;
Y1interp = sin(phi)*(X2-cx) + cos(phi)*(Y2-cy) + cy;
X1interpback = cos(-phi)*(X2-cx) - sin(-phi)*(Y2-cy) + cx;
Y1interpback = sin(-phi)*(X2-cx) + cos(-phi)*(Y2-cy) + cy;
rotIm = interp2(X1, Y1, Im, X1interp, Y1interp, 'cubic');
backrotIm = interp2(X1, Y1, rotIm, X1interpback, Y1interpback, 'cubic');
figure(5); colormap gray;
subplot(221); imagesc(Im,[0 1]);
axis image; colorbar; title('orig Im')
subplot(222); imagesc(rotIm,[0 1]);
axis image; colorbar; title('rotated Im')
subplot(223); imagesc(backrotIm,[0 1]);
axis image; colorbar; title('backrotated Im')
nansum(nansum((backrotIm-Im).*(backrotIm-Im)))
