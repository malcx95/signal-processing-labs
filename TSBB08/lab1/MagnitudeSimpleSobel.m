im = double(imread('circle.tif'));
image_size = length(im);

% simple filter
cd = [1 0 -1] / 2;
simple_imdx = conv2(im,cd,'same');
r90cd = [-1; 0; 1] / 2;
simple_imdy = conv2(im, r90cd, 'same');

simple_gradient = sqrt(simple_imdx .^ 2 + simple_imdy .^ 2);

% simple_gradient = zeros(image_size, image_size);
% 
% for i = 1:image_size
%     for j = 1:image_size
%         simple_gradient(i, j) = sqrt(pow2(simple_imdx(i, j)) + pow2(simple_imdy(i, j)));
%     end
% end

% sobel filter
sobelx = [1 0 -1; 2 0 -2; 1 0 -1] / 8;
sobely = [-1 -2 -1; 0 0 0; 1 2 1] / 8;
sobel_imdx = conv2(im, sobelx, 'same');
sobel_imdy = conv2(im, sobely, 'same');

sobel_gradient = sqrt(sobel_imdx .^ 2 + sobel_imdy .^ 2);

% sobel_gradient = zeros(image_size, image_size);
% 
% for i = 1:image_size
%     for j = 1:image_size
%         sobel_gradient(i, j) = sqrt(pow2(sobel_imdx(i, j)) + pow2(sobel_imdy(i, j)));
%     end
% end

figure(1)
colormap(gray(256))

subplot(1,2,1), imagesc(simple_gradient, [0 160])
axis image; axis off; title('simple gradient'); colorbar

subplot(1,2,2), imagesc(sobel_gradient, [0 160])
axis image; axis off; title('sobel gradient'); colorbar

figure(2)
colormap(gray(256))

subplot(1,2,1), imagesc(simple_gradient, [110 160])
axis image; axis off; title('simple gradient high contrast'); colorbar

subplot(1,2,2), imagesc(sobel_gradient, [110 160])
axis image; axis off; title('sobel gradient high contrast'); colorbar
