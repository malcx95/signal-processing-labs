load('pirat.mat')
im = pirate;
figure(1)
colormap(gray(256))
subplot(1,2,1), imagesc(im, [0 255])
axis image; title('original image')
colorbar('SouthOutside')
laplace = [0 1 0; 1 -4 1; 0 1 0];
imlaplace = conv2(im, laplace, 'same');
subplot(1,2,2), imagesc(imlaplace, [-100 100])
axis image; title('Laplace image')
colorbar('SouthOutside')

figure(2)

colormap(gray(256))
imHP = -imlaplace;
imsharp = im + imHP;
imsharp2 = im + 2*imHP;
subplot(1,2,1), imagesc(imsharp, [0 255])
axis image; title('imsharp')
colorbar('SouthOutside')
subplot(1,2,2), imagesc(imsharp2, [0 255])
axis image; title('imsharp2')
colorbar('SouthOutside')

