im = double(imread('circle.tif'));
figure(1)
colormap(gray(256))
subplot(2,2,1), imagesc(im, [0 255])
axis image; axis off; title('original image'); colorbar

% derived in x-direction
cd = [1 0 -1] / 2;
imdx = conv2(im,cd,'same');
subplot(2,2,3), imagesc(imdx, [-128 127])
axis image; axis off; title('imdx image'); colorbar

% derived in y-direction
r90cd = [-1; 0; 1] / 2;
imdy = conv2(im, r90cd, 'same');
subplot(2,2,4), imagesc(imdy, [-128 127])
axis image; axis off; title('imdy image'); colorbar

% gradient magnitude

image_size = length(im);

gradient = zeros(image_size, image_size);

for i = 1:image_size
    for j = 1:image_size
        gradient(i, j) = sqrt(pow2(imdx(i, j)) + pow2(imdy(i, j)));
    end
end
subplot(2,2,2), imagesc(gradient, [-128 127])
axis image; axis off; title('magnitude of gradient image'); colorbar

