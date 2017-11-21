addpath 'util/'
addpath 'images1/'

% figure(1)
% subplot(2, 2, 1);
% imagesc(im);
% 
% im2 = image_lensdist_inv('atan', im, 0.001);
% subplot(2, 2, 2);
% imagesc(im2);
% 
% im3 = image_lensdist_inv('atan', im, );
% subplot(2, 2, 3);
% imagesc(im3);
% 
% im4 = image_lensdist_inv('atan', im, 0.0001);
% subplot(2, 2, 4);
% imagesc(im4);

close all;
gamma = 0.0003;
im1 = image_lensdist_inv('atan', imread('./images1/img23.jpg'), gamma);
im2 = image_lensdist_inv('atan', imread('./images1/img24.jpg'), gamma);

% [x1, x2] = correspondences_select(im1, im2);
% save corresp_1to2.mat x1 x2

% [y1, y2] = correspondences_select(im1, im2);

%% 

H12 = homography_stls(x1, x2);

mapped = map_points(H12, x1);

%%
figure(1)
subplot(2, 1, 1);
imagesc(im1);hold('on');plot(x1(1,:), x1(2,:), 'go');axis('image'); hold off;

subplot(2, 1, 2);
imagesc(im2);hold('on');plot(mapped(1,:), mapped(2,:), 'go');
plot(x2(1, :), x2(2, :), 'bx');axis('image');
hold off

diff = x1 - mapped(1:2, :);


%% 
[rows, cols, ndim] = size(im1);
imbox = [1 cols cols 1 1; 1 1 rows rows 1];

imbox12 = map_points(H12, imbox);
figure(2);imshow(im2);hold on
plot(imbox12(1,:),imbox12(2,:),'g');
axis image;

%%
cl = [imbox imbox12(1:2, :)];
cmin = floor(min(cl, [], 2));
cmax = ceil(max(cl, [], 2));
rows = cmax(2) - cmin(2);
cols = cmax(1) - cmin(1);

Ht = [1 0 1-cmin(1); 0 1 1-cmin(2); 0 0 1];
pano1 = image_resample(im1, Ht*H12, rows, cols);
pano2 = image_resample(im2, Ht, rows, cols);

close all;
figure(1)
subplot(2, 1, 1);imagesc(pano1);
subplot(2, 1, 2);imagesc(pano2);

alpha0 = ones(size(im1(:,:,1)), 'uint8')*255;
alpha1 = image_resample(alpha0, Ht*H12, rows, cols);
alpha2 = image_resample(alpha0, Ht, rows, cols);

pano = zeros(rows, cols, 3, 'int32');
asum = int32(alpha1) + int32(alpha2);
asum(asum == 0) = 1;

for k = 1:3
	pano(:,:,k) = pano(:,:,k) + int32(pano1(:,:,k)).*int32(alpha1);
	pano(:,:,k) = pano(:,:,k) + int32(pano2(:,:,k)).*int32(alpha2);
	pano(:,:,k) = pano(:,:,k)./asum;
end

figure(2)
imshow(uint8(pano));

%%

gamma = 0.0003;

im1 = image_lensdist_inv('atan', imread('./images1/img22.jpg'), gamma);
im2 = image_lensdist_inv('atan', imread('./images1/img23.jpg'), gamma);
im3 = image_lensdist_inv('atan', imread('./images1/img24.jpg'), gamma);

[h, w] = size(im1);

hfov = 2*atan(w/2/1420);
vfov = 2*atan(h/2/1420);

hoff = atan((w/2 - 808)/1420);
voff = atan((h/2 - 605)/1420);

hr = hfov/2*[-1.8 1.8]+hoff;
vr = vfov/2*[-1.1 1.1]+voff;

K = [1420 -3 808; 0 1420 605; 0 0 1];

p1 = map_points(inv(K), x1);
p2 = map_points(inv(K), x2);

yp1 = map_points(inv(K), y1);
yp2 = map_points(inv(K), y2);

step = 0.05 * pi/180;

R2 = procrustes(yp1, yp2);

R = procrustes(p1, p2);

[rows, cols, ndim] = size(im1);
imbox = [1 cols cols 1 1; 1 1 rows rows 1];
imbox12 = map_points(R, imbox);

% cl = [imbox imbox12(1:2, :)];
% cmin = floor(min(cl, [], 2));
% cmax = ceil(max(cl, [], 2));
% rows = cmax(2) - cmin(2);
% cols = cmax(1) - cmin(1);

alpha0 = ones(size(im1(:,:,1)), 'uint8')*255;
alpha1 = image_resample_sphere(alpha0, K, inv(R2), hr, vr, step);
alpha2 = image_resample_sphere(alpha0, K, eye(3, 3), hr, vr, step);
alpha3 = image_resample_sphere(alpha0, K, R, hr, vr, step);

pano1 = image_resample_sphere(im1, K, inv(R2), hr, vr, step);
pano2 = image_resample_sphere(im2, K, eye(3, 3), hr, vr, step);
pano3 = image_resample_sphere(im3, K, R, hr, vr, step);


pano = zeros(size(pano1), 'int32');
asum = int32(alpha1) + int32(alpha2) + int32(alpha3);
asum(asum == 0) = 1;

for k = 1:3
	pano(:,:,k) = pano(:,:,k) + int32(pano1(:,:,k)).*int32(alpha1);
	pano(:,:,k) = pano(:,:,k) + int32(pano2(:,:,k)).*int32(alpha2);
	pano(:,:,k) = pano(:,:,k) + int32(pano3(:,:,k)).*int32(alpha3);
	pano(:,:,k) = pano(:,:,k)./asum;
end

close all;
figure(1)
imshow(uint8(pano));

