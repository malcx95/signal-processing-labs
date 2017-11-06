
%% shadingcorr

fpath='shadingcorr/';

load([fpath 'whiteimage']);
load([fpath 'darkimage']);
load([fpath 'blackimage']);
load([fpath 'origimage']);

fA = mean(mean(darkimage));
fB = mean(mean(whiteimage));

bA = darkimage;
bB = whiteimage;

c = (fB - fA)./(bB - bA);
d = (fA*bB - fB*bA)./(fB - fA);

corrected = c.*(origimage + d);

figure(2); colormap(jet);
imagesc(corrected, [0 255]);

figure(3); colormap(jet);
imagesc(origimage, [0 255]);

fA = mean(mean(blackimage));
fB = mean(mean(whiteimage));

fprintf('fA for black: %d\n', fA);
fprintf('fB for black: %d\n', fB);

bA = blackimage;
bB = whiteimage;

c = (fB - fA)./(bB - bA);
d = (fA*bB - fB*bA)./(fB - fA);

corrected = c.*(origimage + d);

figure(4); colormap(jet);
imagesc(corrected, [0 255]);

%% deinterlacing

im = im2double(imread('interlaced_image.png'));
figure(1);

subplot(2, 2, 1);
imshow(im); title('Original image');

[rows,cols,ndim] = size(im);
mask1 = zeros(rows, cols);
mask1(1:2:end,:) = 1;
mask2 = zeros(rows, cols);
mask2(2:2:end,:) = 1;

subplot(2, 2, 2);
imshow(im.*repmat(mask1, [1 1 3])); title('Odd lines');

subplot(2, 2, 3);
imshow(im.*repmat(mask2, [1 1 3])); title('Even lines');

f = [1 2 1]'/2;

im1 = zeros(size(im));
im2 = zeros(size(im));

for k = 1:3
	bk = im(:,:, k);
	im1(:,:,k) = conv2(bk.*mask1, f, 'same');
	im2(:,:,k) = conv2(bk.*mask2, f, 'same');
end

figure(2);
subplot(1, 2, 1);
imshow(im1), title('Interpolated 1');
subplot(1, 2, 2);
imshow(im2), title('Interpolated 2');

figure(3)
imshow(im);

figure(4)
imshow(im1);

%% Bayer pattern interpolation

close all;
im = im2double(imread('A-DigitalCamera/bayer/raw0001.png'));

figure(1);

% GBRG
% [rows,cols,ndim] = size(im);
% mask1 = zeros(rows, cols);
% mask1(2:2:end,1:2:end) = 1;
% 
% mask2 = zeros(rows, cols);
% mask2(1:2:end,1:2:end) = 1;
% mask2(2:2:end,2:2:end) = 1;
% 
% mask3 = zeros(rows, cols);
% mask3(1:2:end,2:2:end) = 1;
% 
% subplot(2, 2, 1);
% im_rgb = reshape([im.*mask1 im.*mask2 im.*mask3], [size(im) 3]);
% imshow(im_rgb); title('GBRG');
% 
% % RGGB
% [rows,cols,ndim] = size(im);
% mask1 = zeros(rows, cols);
% mask1(1:2:end,1:2:end) = 1;
% 
% mask2 = zeros(rows, cols);
% mask2(1:2:end,2:2:end) = 1;
% mask2(2:2:end,1:2:end) = 1;
% 
% mask3 = zeros(rows, cols);
% mask3(2:2:end,2:2:end) = 1;
% 
% subplot(2, 2, 2);
% im_rgb = reshape([im.*mask1 im.*mask2 im.*mask3], [size(im) 3]);
% imshow(im_rgb); title('RGGB');

% BGGR
[rows,cols,ndim] = size(im);
mask1 = zeros(rows, cols);
mask1(2:2:end,2:2:end) = 1;

mask2 = zeros(rows, cols);
mask2(1:2:end,2:2:end) = 1;
mask2(2:2:end,1:2:end) = 1;

mask3 = zeros(rows, cols);
mask3(1:2:end,1:2:end) = 1;

subplot(2, 2, 3);
im_rgb = reshape([im.*mask1 im.*mask2 im.*mask3], [size(im) 3]);
imshow(im_rgb); title('BGGR');


% GRBG
% [rows,cols,ndim] = size(im);
% mask1 = zeros(rows, cols);
% mask1(1:2:end,2:2:end) = 1;
% 
% mask2 = zeros(rows, cols);
% mask2(1:2:end,1:2:end) = 1;
% mask2(2:2:end,2:2:end) = 1;
% 
% mask3 = zeros(rows, cols);
% mask3(2:2:end,1:2:end) = 1;
% 
% subplot(2, 2, 4);
% im_rgb = reshape([im.*mask1 im.*mask2 im.*mask3], [size(im) 3]);
% imshow(im_rgb); title('GRBG');


f = [1 2 1]/4;

img = conv2(f, f, im.*mask1, 'same');

meanim = mean(mean(im))
meanimg = mean(mean(img))

imgred = conv2(f, f, im.*mask1, 'same')./conv2(f, f, mask1, 'same');
imggreen = conv2(f, f, im.*mask2, 'same')./conv2(f, f, mask2, 'same');
imgblue = conv2(f, f, im.*mask3, 'same')./conv2(f, f, mask3, 'same');

meanimgred = mean(mean(imgred))

im_rgb = reshape([imgred imggreen imgblue], [size(im) 3]);

figure(2);
imshow(im);

figure(3);
imshow(im_rgb);

%% Noise measurements

fpath = 'A-DigitalCamera/bayer/';
im = cell(100, 1);
for k = 1:100
	fname = sprintf('raw%04d.png', k);
	im{k} = imread([fpath fname]);
end


imm = zeros(size(im{1}));

for k = 1:100
	imm = imm + im2double(im{k});
end

imm = imm / 100;

immrgb = raw2rgb(imm);

figure(1)
subplot(2, 2, 1);
imshow(raw2rgb(im{1})); title('One of the originals');

subplot(2, 2, 2);
imshow(immrgb); title('immrgb');

imv = zeros(size(im{1}));

for k = 1:100
	imv = imv + im2double(im{k}).^2;
end

imv = imv / 100 - imm.^2;
imv = imv;% - min(min(imvrgb(:,:,k)));
imvscaled = imv/max(max(imv));

imvrgb = raw2rgb(imvscaled);
% for k = 1:3
% 	imvrgb(:,:,k) = imvrgb(:,:,k) - min(min(imvrgb(:,:,k)));
% 	imvrgb(:,:,k) = imvrgb(:,:,k)/max(max(imvrgb(:,:,k)));
% end

subplot(2, 2, 3);
imshow(imvrgb); title('imv');

% for k = 1:100,
% 	imshow(raw2rgb(im{k}));
% 	axis([871 980 401 480]);
% 	drawnow;
% end

subplot(2, 2, 4);
imshow(raw2rgb(imvscaled./imm.^2)); title('SNR')

% the final thing

[rows,cols,ndim] = size(im{1});
mask1 = zeros(rows, cols);
mask1(2:2:end,2:2:end) = 1;

mask2 = zeros(rows, cols);
mask2(1:2:end,2:2:end) = 1;
mask2(2:2:end,1:2:end) = 1;

mask3 = zeros(rows, cols);
mask3(1:2:end,1:2:end) = 1;

indim = uint8(imm*255);
rhist = zeros(256, 1);
ghist = zeros(256, 1);
bhist = zeros(256, 1);

for k = 0:255
	k
	redk = find(mask1);
	indk = redk(find(indim(redk) == k));
	rhist(k + 1) = sum(imv(indk))/(length(indk) + eps);

	greenk = find(mask2);
	indk = greenk(find(indim(greenk) == k));
	ghist(k + 1) = sum(imv(indk))/(length(indk) + eps);

	bluek = find(mask3);
	indk = bluek(find(indim(bluek) == k));
	bhist(k + 1) = sum(imv(indk))/(length(indk) + eps);

end

figure(2)
plot([0:255], [bhist ghist rhist]*255^2);
axis([0 255 0 10])
grid on

