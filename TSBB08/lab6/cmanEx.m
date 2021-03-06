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

T11 = fx.^2;
subplot(1,2,1); imagesc(T11, [0 maxv^2]); colorbar('horizontal'); 
title('T_{11} before filtering')
axis image; axis off;
T22 = fy.^2;
subplot(1,2,2); imagesc(T22, [0 maxvy^2]); colorbar('horizontal'); 
title('T_{22} before filtering')
axis image; axis off;

sigma=1.25;
lpH=exp(-0.5*([-9:9]/sigma).^2);
lpH=lpH/sum(lpH); % Horizontal filter
lpV=lpH'; % Vertical filter

lp = conv2(lpV, lpH);

T11 = conv2(T11, lp, 'same');
T22 = conv2(T22, lp, 'same');

figure(4)
subplot(1,2,1); imagesc(T11, [0 maxv^2]); colorbar('horizontal'); 
title('T_{11}')
axis image; axis off;
subplot(1,2,2); imagesc(T22, [0 maxvy^2]); colorbar('horizontal'); 
title('T_{22}')
axis image; axis off;
colormap(gray(256));

T12 = fx.*fy;
T12 = conv2(T12, lp, 'same');

z = T11 - T22 + 1i*2*T12;

zabs = abs(z);
zarg = atan2(imag(z), real(z));

[h, w] = size(zarg);

for i = 1:h
    for j = 1:w
        if zarg(i, j) < 0
            zarg(i, j) = zarg(i, j) + 2*pi;
        end
    end
end

figure(5)
imagesc(zabs, [0 maxv^2]), colorbar('horizontal'), 
title('abs(z)'), 
axis image,  axis off,
colormap(gray(256));
figure(6)
imagesc(zarg), colorbar('horizontal'),
title('arg(z)'),
axis image, axis off,
colormap(goptab);

figure(7);
gopimage(z);

