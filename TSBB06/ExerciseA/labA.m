function labA()
%% lab 1 macro

img1 = imread('img1.ppm');
y  = vgg_get_homg([ 130, 130; 275, 275; 526, 190; 335, 193; 416, 477; 196, 141; 288, 138; 192, 276; 516, 345; 229, 384 ]');
yy = y(:, 1:4);

img2 = imread('img2.ppm');
yp = vgg_get_homg([ 114, 247; 274, 344; 440, 214; 297, 257; 443, 487; 171, 242; 244, 219; 209, 364; 477, 349; 271, 453 ]');
yyp = yp(:, 1:4);

plot_image(figure(1), img1, y);
plot_image(figure(2), img2, yp);

[ A0, z0, H0, e0 ] = solve_inhomogenous(yy, yyp);
[ A1, z1, H1, e1 ] = solve_inhomogenous(y, yp);

[ w, h, ~ ] = size(img1);

img2t = uint8(image_resample(double(img1), H1, w, h));

plot_image(figure(3), img2t, yp);
plot_image(figure(4), img2t-img2);

[ A2, z2, H2, e2 ] = solve_homogenous(yy, yyp);
[ A3, z3, H3, e3 ] = solve_homogenous(y, yp);

[ yt,  T1 ] = liu_preconditioning(y);
[ ypt, T2 ] = liu_preconditioning(yp);

[ At, zt, H4, e4 ] = solve_hartley(y, yp);

l1 = cross(y(:, 3), y(:, 4))

figure(1);
hold('on');
drawline(l1, 'axis', 'xy');

l2 = inv(H1)'*l1

figure(2);
hold('on');
drawline(l2, 'axis', 'xy');

return;

function A = create_system(y, yp)
%% creates equation system from points
[~, N] = size(y);
A = [];
for i=1:N
    A = [   
            A                                                                                           ;
            [ y(1, i), 0,       -y(1, i)*yp(1, i), y(2, i), 0,       -y(2, i)*yp(1, i), 1, 0, -yp(1, i) ];
            [ 0,       y(1, i), -y(1, i)*yp(2, i), 0,       y(2, i), -y(2, i)*yp(2, i), 0, 1, -yp(2, i) ];
        ];
end
return;

function [ A, z, H, e ] = solve_homogenous(y, yp)
    A = create_system(y, yp);
    z = homogen(A);
    H = unpack(z);
    H = H ./ H(3, 3);
    e = geometric_error(H, y, yp);
return;

function [ A, z, H, e ] = solve_inhomogenous(y, yp)
    A = create_system(y, yp);
    z = inhomogen(A);
    H = unpack(z);
    e = geometric_error(H, y, yp);
return;

function [ A, z, H, e ] = solve_hartley(y, yp)
    [ yt,  T1 ] = liu_preconditioning(y);
    [ ypt, T2 ] = liu_preconditioning(yp);
    A = create_system(yt, ypt);
    z = homogen(A);
    Hp = unpack(z);
    H = T2^-1 * Hp * T1;
    H = H ./ H(3, 3);
    e = geometric_error(H, y, yp);

return;
function z = inhomogen(A)
%% estimates the inhomogenous solution of z
    [ ~, N ] = size(A);
    A0 = A(:, 1:(N-1));
    b = A(:, N);

    s1 = A0'*A0;
    s2 = s1^-1;
    s3 = s2*A0';
    s4 = s3*b;
    z = -s4;
    z =  [ z; 1 ];
return;

function z = homogen(A)
%% estimates the homogenous solution of z
[ ~, ~, V ] = svd(A);
z = V(:, end);
return;

function H = unpack(z)
%% unpack z into H

x = [ 1, 1, 1, 2, 2, 2, 3, 3, 3 ];
y = [ 1, 2, 3, 1, 2, 3, 1, 2, 3 ];

H = ones(3, 3);

for i=1:9
    H(y(i), x(i)) = z(i);
end

return;

function u = pnorm(v)
%% normalize each vector in v
[ ~, N ] = size(v);

for i=1:N
A0 = create_system(y(:, 1:4), yp(:, 1:4));
zmin = inhomogen(A0);
H0 = unpack(zmin)
e0 = geometric_error(H0, y(:, 1:4), yp(:, 1:4));

A = create_system(y, yp);
zmin = inhomogen(A);
H1 = unpack(zmin);
e1 = geometric_error(H1, y, yp);
    u(:, i) = v(:, i)/v(3, i);
end

return

function e = geometric_error(H, y, yp)
    ypv = H*y;
    yv = inv(H)*yp;
    
    deltaYp = vgg_get_nonhomg(yp) - vgg_get_nonhomg(ypv);
    deltaY  = vgg_get_nonhomg(y)  - vgg_get_nonhomg(yv);
    e = norm([ deltaYp, deltaY ], 'fro');
return

function plot_image(fig, img, pts)
    hold('off');
    figure(fig);
    imagesc(img);
    if(nargin > 2)        
        hold('on');
        [ ~, N ] = size(pts);
        scatter(pts(1, :), pts(2, :), 50, jet(N));
    end
return
