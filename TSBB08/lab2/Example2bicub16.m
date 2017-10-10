Im = double(imread('baboon.tif')); % load image

[Ny, Nx] = size(Im);
N = min(min(Nx,Ny));
[x,y] = meshgrid(-ceil((Nx-1)/2):floor((Nx-1)/2), ...
-ceil((Ny-1)/2):floor((Ny-1)/2));
mask = (x.^2 + y.^2)<((N-1)/2)^2;
Im = Im.* mask;

figure(4); colormap gray;
nIm = rotateimage(Im, pi / 6.1, 'bicubic16');
for i = 1:11
	nIm = rotateimage(nIm, pi / 6.1, 'bicubic16');
end
rotatedIm = nIm;
subplot(331); imagesc(Im); title('Im'); axis image; colorbar;
subplot(332); imagesc(rotatedIm); title('RotatedIm'); axis image; colorbar;
subplot(333); imagesc(nIm); title('nIm'); axis image; colorbar;
errorIm = nIm - Im;
subplot(334); imagesc(errorIm); title('ErrorIm'); axis image; axis off; colorbar;


fprintf('Error energy in spatial domain: %d\n', sum(sum(errorIm.*errorIm)))

fIm = fftshift(fft2(ifftshift(Im)));
fnIm = fftshift(fft2(ifftshift(nIm)));
ferrorIm = fIm - fnIm;

subplot(335); imagesc(log10(1 + abs(fIm))); title('fIm'); axis image; colorbar;
subplot(336); imagesc(log10(1 + abs(fnIm))); title('fnIm');  axis image; colorbar;
subplot(337); imagesc(log10(1 + abs(ferrorIm))); title('ferrorIm');  axis image; colorbar;

N = size(fIm);
fprintf('Error energy in fourier domain: %d\n', sum(sum(ferrorIm.*conj(ferrorIm)))/(N(1)*N(2)))

relFerror = abs(fIm - fnIm) ./ abs(fIm);
subplot(338); imagesc(relFerror, [0 2]); title('relFerrorIm');  axis image; colorbar;


