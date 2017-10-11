img1 = imread('img1.ppm');
img2 = imread('img2.ppm');

figure(1); imagesc(img1);
title('Original image 1');
figure(2); imagesc(img2);
title('Original image 2');

y1  = vgg_get_homg([ 130, 130; 275, 275; 526, 190; 335, 193; 416, 477; 196, 141; 288, 138; 192, 276; 516, 345; 229, 384 ]');
y2 = vgg_get_homg([ 114, 247; 274, 344; 440, 214; 297, 257; 443, 487; 171, 242; 244, 219; 209, 364; 477, 349; 271, 453 ]');

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

diag(S)'
figure(5);plot(log(diag(S)),'o');

y2b2 = vgg_get_nonhomg(H2*y1);
y1b2 = vgg_get_nonhomg(inv(H2)*y2);

fprintf('Total geometric error e1: %d\n', geom_err(y1, y2, y1b2, y2b2));

[y1tilde T1] = liu_preconditioning(y1);
[y2tilde T2] = liu_preconditioning(y2);

[h, w] = size(y1tilde);

meandist1 = 0;
meandist2 = 0;

for i = 1:w
    dist1 = y1tilde(1, i)^2 + y1tilde(2, i)^2;
    dist2 = y2tilde(1, i)^2 + y2tilde(2, i)^2;

    meandist1 = meandist1 + sqrt(dist1);
    meandist2 = meandist2 + sqrt(dist2);

end

meandist1 = meandist1 / w;
meandist2 = meandist2 / w;

fprintf('Mean dist for y1tilde: %d\n', meandist1);
fprintf('Mean dist for y2tilde: %d\n', meandist2);

[~, N] = size(y1tilde);
Atilde = [];
for i = 1:N
    Atilde = [Atilde; 
            [ y1tilde(1, i), 0,       -y1tilde(1, i)*y2tilde(1, i), y1tilde(2, i), 0,       -y1tilde(2, i)*y2tilde(1, i), 1, 0, -y2tilde(1, i) ];
            [ 0,       y1tilde(1, i), -y1tilde(1, i)*y2tilde(2, i), 0,       y1tilde(2, i), -y1tilde(2, i)*y2tilde(2, i), 0, 1, -y2tilde(2, i) ];
    ];
end

[Utilde Stilde Vtilde] = svd(Atilde);
Htilde = reshape(Vtilde(:,end),3,3);

H3 = inv(T2)*Htilde*T1;

diag(Stilde)'
figure(6);plot(log(diag(Stilde)),'o');

y2b3 = vgg_get_nonhomg(H3*y1);
y1b3 = vgg_get_nonhomg(inv(H3)*y2);
fprintf('Geometric error e3: %d\n', geom_err(y1, y2, y1b3, y2b3));


% Ground truth
%-------------------------------------

load -ascii H1to2p

y2gt = vgg_get_nonhomg(H1to2p*y1);
y1gt = vgg_get_nonhomg(inv(H1to2p)*y2);

egt1 = 0;
for k = 1:length(y1gt),
	egt1 = egt1 + norm(y2gt(:,k)-y2b(:,k))^2 + ...
		+ norm(y1gt(:,k)-y1b(:,k))^2;
end
egt1 = sqrt(egt1);

egt2 = 0;
for k = 1:length(y1gt),
	egt2 = egt2 + norm(y2gt(:,k)-y2b2(:,k))^2 + ...
		+ norm(y1gt(:,k)-y1b2(:,k))^2;
end
egt2 = sqrt(egt2);

egt3 = 0;
for k = 1:length(y1gt),
	egt3 = egt3 + norm(y2gt(:,k)-y2b3(:,k))^2 + ...
		+ norm(y1gt(:,k)-y1b3(:,k))^2;
end
egt3 = sqrt(egt3);

fprintf('Ground truth geometric error for H1: %d\n', egt1);
fprintf('Ground truth geometric error for H2: %d\n', egt2);
fprintf('Ground truth geometric error for H3: %d\n', egt3);

l1 = liu_crossop(y1(:, 1))*y1(:, 2);
figure(1);drawline(l1, 'axis', 'xy');

l2 = inv(H3')*l1;
figure(2);drawline(l2, 'axis', 'xy');

y1deg = vgg_get_homg([ 770, 36; 602, 82; 683, 54; 510 111; 383, 146; 275, 179; 175, 211; 86, 224; 31, 228; 348, 157]');
y2deg = vgg_get_homg([ 570, 41; 459, 106; 514, 76; 403, 152; 321, 205; 248, 259; 182, 310; 108, 346; 57, 363; 296, 222]');

figure(1);hold('on');plot(y1deg(1,:),y1deg(2,:),'bo');
figure(2);hold('on');plot(y2deg(1,:),y2deg(2,:),'bo');

[~, N] = size(y1deg);
Adeg = [];
for i = 1:N
    Adeg = [Adeg; 
            [ y1deg(1, i), 0,       -y1deg(1, i)*y2deg(1, i), y1deg(2, i), 0,       -y1deg(2, i)*y2deg(1, i), 1, 0, -y2deg(1, i) ];
            [ 0,       y1deg(1, i), -y1deg(1, i)*y2deg(2, i), 0,       y1deg(2, i), -y1deg(2, i)*y2deg(2, i), 0, 1, -y2deg(2, i) ];
    ];
end

[Udeg Sdeg Vdeg] = svd(Adeg);
Hdeg = reshape(Vdeg(:,end), 3, 3);

diag(Sdeg)'
figure(7);plot(log(diag(Sdeg)),'o');

[y1tildedeg T1] = liu_preconditioning(y1deg);
[y2tildedeg T2] = liu_preconditioning(y2deg);

[~, N] = size(y1tildedeg);
Atildedeg = [];
for i = 1:N
    Atildedeg = [Atildedeg; 
            [ y1tildedeg(1, i), 0,       -y1tildedeg(1, i)*y2tildedeg(1, i), y1tildedeg(2, i), 0,       -y1tildedeg(2, i)*y2tildedeg(1, i), 1, 0, -y2tildedeg(1, i) ];
            [ 0,       y1tildedeg(1, i), -y1tildedeg(1, i)*y2tildedeg(2, i), 0,       y1tildedeg(2, i), -y1tildedeg(2, i)*y2tildedeg(2, i), 0, 1, -y2tildedeg(2, i) ];
    ];
end

[Utildedeg Stildedeg Vtildedeg] = svd(Atildedeg);
Htildedeg = reshape(Vtilde(:,end),3,3);

diag(Stildedeg)'
figure(8);plot(log(diag(Stildedeg)),'o');

img2tdeg=image_resample(double(img1),Hdeg,640,800);
figure(9);imagesc(uint8(img2tdeg));

