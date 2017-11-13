addpath /site/edu/bb/Bildsensorer/C-CameraCalibration

load('images.mat')

figure(1)
imagesc(pattern); axis image;

figure(2)
imagesc(object); axis image;

% Calibration points in the world
%--------------------------------
X1 =  0; Y1 =  0;
X2 =  5; Y2 =  0;
X3 = 10; Y3 =  0;
X4 =  0; Y4 =  5;
X5 =  5; Y5 =  5;
X6 = 10; Y6 =  5;
X7 =  0; Y7 = 10;
X8 =  5; Y8 = 10;
X9 = 10; Y9 = 10;

% Calibration points in the image
%--------------------------------
u1 = 118; v1 = 77;
u2 = 189; v2 = 66;
u3 = 259; v3 = 55;
u4 = 127; v4 = 127;
u5 = 206; v5 = 114;
u6 = 281; v6 = 102;
u7 = 139; v7 = 187;
u8 = 226; v8 = 171;
u9 = 308; v9 = 157;

f = [u1 v1 u2 v2 u3 v3 u4 v4 u5 v5 u6 v6 u7 v7 u8 v8 u9 v9]';

% Calibration matrix
%-------------------
D = [  
    X1 Y1  1   0  0  0 -u1*X1 -u1*Y1;
     0  0  0  X1 Y1  1 -v1*X1 -v1*Y1;
    X2 Y2  1   0  0  0 -u2*X2 -u2*Y2;
     0  0  0  X2 Y2  1 -v2*X2 -v2*Y2;
    X3 Y3  1   0  0  0 -u3*X3 -u3*Y3;
     0  0  0  X3 Y3  1 -v3*X3 -v3*Y3;
    X4 Y4  1   0  0  0 -u4*X4 -u4*Y4;
     0  0  0  X4 Y4  1 -v4*X4 -v4*Y4;
    X5 Y5  1   0  0  0 -u5*X5 -u5*Y5;
     0  0  0  X5 Y5  1 -v5*X5 -v5*Y5;
    X6 Y6  1   0  0  0 -u6*X6 -u6*Y6;
     0  0  0  X6 Y6  1 -v6*X6 -v6*Y6;
    X7 Y7  1   0  0  0 -u7*X7 -u7*Y7;
     0  0  0  X7 Y7  1 -v7*X7 -v7*Y7;
    X8 Y8  1   0  0  0 -u8*X8 -u8*Y8;
     0  0  0  X8 Y8  1 -v8*X8 -v8*Y8;
    X9 Y9  1   0  0  0 -u9*X9 -u9*Y9;
     0  0  0  X9 Y9  1 -v9*X9 -v9*Y9];


c = pinv(D)*f;

c = [c; 1];

C = (reshape(c, 3, 3))';

test = C * [5 5 1]';
u5new = test(1) / test(3);
v5new = test(2) / test(3);

va = inv(C)*[133 333; 195 119; 1 1];

zoomdist = sqrt(21.65^2 + 1.64^2 + 911^2);

A = [
	2.1236 -0.0008 0.2240;
	0		1.9171 0.1086;
	0		0	   0.0010;
	] * 1.0e+03;

R = [
	0.8568	0.5110	-0.0020;
	-0.5157	0.8599	-0.0011;
	0.0012	0.0019	1.0003;
	];

t = [
	-21.6573;
	1.6429;
	910.8820;
	];


% cc1 = inv(C) * [176.5; 120.5; 1;]
% cc2 = inv(A*[R t]) * [176.5; 120.5; 0; 1;]

Abasic = [
	1.2955	-0.0016	0.1887;
	0		1.1749	0.1254;
	0		0		0.0010;
	] * 1.0e+03;


uvn = inv(Abasic)*[0;0;1];

thetau = atan(uvn(1)) * 180/pi
thetav = atan(uvn(2)) * 180/pi

%% 

C = A*[R t];
[K R t] = P2KRt(C)

