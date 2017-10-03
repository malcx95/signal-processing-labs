img1 = imread('img1.ppm');
img2 = imread('img2.ppm');

figure(1); imagesc(img1);
title('Original image 1');
figure(2); imagesc(img2);
title('Original image 2');

y1  = vgg_get_homg([ 130, 130; 275, 275; 526, 190; 335, 193; 416, 477; 196, 141; 288, 138; 192, 276; 516, 345; 229, 384 ]');
% y1 = vgg_get_homg([191 140; 125 498; 421 367; 611 88;  735 291; 630 409; 394 125; 44 282; ]');
y2 = vgg_get_homg([ 114, 247; 274, 344; 440, 214; 297, 257; 443, 487; 171, 242; 244, 219; 209, 364; 477, 349; 271, 453 ]');
% y2 = vgg_get_homg([166 242; 222 588; 411 391; 470 111; 611 256; 576 378; 322 184; 87 408; ]');

figure(1);hold('on');plot(y1(1,:),y1(2,:),'go');
figure(2);hold('on');plot(y2(1,:),y2(2,:),'go');

[~, N] = size(y1);
A = [];
for i = 1:N
    A = [A;
            [ y1(1, i), 0,       -y1(1, i)*y2(1, i), y1(2, i), 0,       -y1(2, i)*y2(1, i), 1, 0, -y2(1, i) ];
            [ 0,       y1(1, i), -y1(1, i)*y2(2, i), 0,       y1(2, i), -y1(2, i)*y2(2, i), 0, 1, -y2(2, i) ];
        ];
end

A0 = A(1:8, :);

H1 = createhomography2(A);

y2b = vgg_get_nonhomg(H1*y1);
y1b = vgg_get_nonhomg(inv(H1)*y2);

figure(1);plot(y1b(1,:),y1b(2,:),'rx');
figure(2);plot(y2b(1,:),y2b(2,:),'rx');

img2t=image_resample(double(img1),H1,640,800);
figure(3);imagesc(uint8(img2t));

figure(4);imagesc(uint8(img2t) - img2);

fprintf('Total geometric error e1: %d\n', geom_err(y1, y2, y1b, y2b));

fprintf('Geometric error for img1: %d\n', geom_err_non_sym(y1, y1b));
fprintf('Geometric error for img2: %d\n', geom_err_non_sym(y2, y2b));

[U S V] = svd(A);
H2 = reshape(V(:,end), 3, 3);
r = A * V(:,end);

fprintf('Residual error for homogenous method: %d\n', sum(r .* r));


y2b2 = vgg_get_nonhomg(H2*y1);
y1b2 = vgg_get_nonhomg(inv(H2)*y2);
figure(1);plot(y1b(1,:),y1b(2,:),'bx');
figure(2);plot(y2b(1,:),y2b(2,:),'bx');

fprintf('Total geometric error e1: %d\n', geom_err(y1, y2, y1b2, y2b2));

[y1tilde T1] = liu_preconditioning(y1);
[y2tilde T2] = liu_preconditioning(y2);

[w, ~] = size(y1tilde);

meandist1 = 0
meandist2 = 0

for i = 1:w
    dist1 = y1tilde(1, i)^2 + y1tilde(2, i)^2 + y1tilde(3, i)^2;
    dist2 = y2tilde(1, i)^2 + y2tilde(2, i)^2 + y2tilde(3, i)^2;

    meandist1 = meandist1 + sqrt(dist1);
    meandist2 = meandist2 + sqrt(dist2);

end

meandist1 = meandist1 / w;
meandist2 = meandist2 / w;

fprintf('Mean dist for y1tilde: %d\n', meandist1);
fprintf('Mean dist for y2tilde: %d\n', meandist2);

