im = double(imread('circle.tif'));
figure(1)
colormap(gray(256))
subplot(1,2,1), imagesc(im, [0 255])
axis image; title('original image')
colorbar('SouthOutside')
laplace = [0 1 0; 1 -4 1; 0 1 0];
imlaplace = conv2(im, laplace, 'same');
subplot(1,2,2), imagesc(imlaplace, [-200 200])
axis image; title('Laplace image')
colorbar('SouthOutside')
