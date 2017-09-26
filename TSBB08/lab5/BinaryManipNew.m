%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% An example about how to read images,
% how to do binary manipulation 
% and how to overlay a pattern.
% Written by Maria Magnusson, 2007-05-08
% Updated by Maria Magnusson, 2008-08-11
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Read a colour image
%--------------------
im1 = double(imread('C9minpeps2.bmp'));
figure(1), imshow(im1/255);

% Look at the three colour components RGB
%----------------------------------------
im1r=im1(:,:,1); im1g=im1(:,:,2); im1b=im1(:,:,3);
figure(2), imshow(im1r,[0 255]), colormap(gray), colorbar;
figure(3), imshow(im1g,[0 255]), colormap(gray), colorbar;
figure(4), imshow(im1b,[0 255]), colormap(gray), colorbar;

% Compute the histogram of the blue image and do threshholding
%-------------------------------------------------------------
histo = hist(im1b(:),[0:255]);
figure(5), stem(histo);
im1bT = im1b > 50;
figure(6), imshow(im1bT,[0 1]), colormap(gray), colorbar;

% Perfom opening
%---------------
tmp = bwmorph(im1bT,'erode',2);
tmp = bwmorph(tmp,'dilate',2);

% Perform closing
%----------------
tmp = bwmorph(tmp,'dilate',2);
im1bTmorph = bwmorph(tmp,'erode',2);

figure(7), imshow(im1bTmorph,[0 1]), colormap(gray), colorbar;

% Overlay a pattern
%------------------
immask1 = zeros(1000,1000);
immask1(200:800,200:800) = 1;
immask2 = zeros(1000,1000);
M = [ 1 1 0 0 0 0 0 0 0 0 1 1;
      1 1 1 0 0 0 0 0 0 1 1 1;
      1 1 1 1 0 0 0 0 1 1 1 1;
      1 1 0 1 1 0 0 1 1 0 1 1;
      1 1 0 0 1 1 1 1 0 0 1 1;
      1 1 0 0 0 1 1 0 0 0 1 1;
      1 1 0 0 0 0 0 0 0 0 1 1;
      1 1 0 0 0 0 0 0 0 0 1 1;
      1 1 0 0 0 0 0 0 0 0 1 1;
      1 1 0 0 0 0 0 0 0 0 1 1;
      1 1 0 0 0 0 0 0 0 0 1 1;
      1 1 0 0 0 0 0 0 0 0 1 1];
immask2(500:511,500:511) = 255*M; 

imny = zeros(1000,1000,3);
imny(:,:,1) = max(im1r, immask2);
imny(:,:,2) = max(im1g, immask2);
imny(:,:,3) = max(im1b, immask2);
imny(:,:,1) = imny(:,:,1) .* immask1;
imny(:,:,2) = imny(:,:,2) .* immask1;
imny(:,:,3) = imny(:,:,3) .* immask1;

figure(8), imshow(imny/255);


% Laplace filter the padlock signals
lfilter = [
	-2 -4 -4 -4 -2;
	-4	0  8  0 -4;
	-4	8  24 8 -4; 
	-4	0  8  0 -4; 
	-2 -4 -4 -4 -2
	] / 64;
laplfiltim = conv2(im1r, lfilter);
figure(9), imshow(laplfiltim, []);
title('Laplace filtered padlocks');
fprintf('Number of padlocks: %d\n', countpadlocks(laplfiltim));

