f = getactive;
h0 = ones(5,5)/25; % a suitable filter
g = circconv(f,h0,1); % convolve
snr = 20;
h = addnoise(g,snr); % add noise with SNR=20dB
rho = 0.80;
r = 1.0;
fhat=wiener(h,h0,snr,rho,r); % Wiener filter
figure(90), colormap(gray)
imagesc(f,[0 255]), axis image
figure(91), colormap(gray)
imagesc(h,[0 255]), axis image
figure(92), colormap(gray)
imagesc(fhat,[0 255]), axis image, title('Wiener filtered');

%% 1.1
% --------------------------------------------------------------

f = getactive;
h1 = 1; % small filter
g = circconv(f,h1,1);
snr = 10;
h = addnoise(g,snr); % add noise
rho = 0.80;
r = 1.0;
fhat=wiener(h,h1,snr,rho,r); % Wiener filter
figure(90), colormap(gray)
imagesc(f,[0 255]), axis image
figure(91), colormap(gray)
imagesc(h,[0 255]), axis image
figure(92), colormap(gray)
imagesc(fhat,[0 255]), axis image, title('Wiener filtered');

%% 1.2
% --------------------------------------------------------------

f = getactive;
h2 = ones(7, 7)/49;
h3 = ones(11, 11)/121;
g2 = circconv(f,h2,1);
g3 = circconv(f,h3,1);
snr = 40;
h_2 = addnoise(g2,snr); % add noise
h_3 = addnoise(g3,snr); % add noise
rho = 0.80;
r = 0.01;
fhat2=wiener(h_2,h2,snr,rho,r); % Wiener filter
fhat3=wiener(h_3,h3,snr,rho,r); % Wiener filter
figure(90), colormap(gray)
imagesc(f,[0 255]), axis image
figure(91), colormap(gray)
imagesc(h_2,[0 255]), axis image, title('Degenerate, big filter');
figure(92), colormap(gray)
imagesc(h_3,[0 255]), axis image, title('Degenerate, very big filter');
figure(93), colormap(gray)
imagesc(fhat2,[0 255]), axis image, title('Wiener filtered, big filter');
figure(94), colormap(gray)
imagesc(fhat3,[0 255]), axis image, title('Wiener filtered, very big filter');

%% 1.3
% --------------------------------------------------------------

f = getactive;
h2 = ones(7, 7)/49;
h3 = ones(11, 11)/121;

activeFilter = h2;

g = circconv(f,activeFilter,1);
snr = 10;
h = addnoise(g,snr); % add noise
rho = 0.80;
r = 0.1;
fhat=wiener(h,activeFilter,snr,rho,r); % Wiener filter
figure(90), colormap(gray)
imagesc(f,[0 255]), axis image
figure(91), colormap(gray)
imagesc(h,[0 255]), axis image
figure(92), colormap(gray)
imagesc(fhat,[0 255]), axis image, title('Wiener filtered');

%% 1.4
% --------------------------------------------------------------

f = getactive;
h2 = ones(7, 7)/49;
h3 = ones(11, 11)/121;
h4 = ones(1, 9)/9;

activeFilter = h4;

g = circconv(f,activeFilter,1);
snr = 10;
h = addnoise(g,snr); % add noise
rho = 0.80;
r = 1;
fhat=wiener(h,activeFilter,snr,rho,r); % Wiener filter
figure(90), colormap(gray)
imagesc(f,[0 255]), axis image
figure(91), colormap(gray)
imagesc(h,[0 255]), axis image
figure(92), colormap(gray)
imagesc(fhat,[0 255]), axis image, title('Wiener filtered');

%% 1.5
% --------------------------------------------------------------

f = getactive;

transformed = fft2(fftshift(f - mean(mean(f))));

squared = abs(transformed).^2;

rf = ifftshift(ifft2(squared));

orig = length(rf)/2 + 1;

rhox = rf(orig + 1, orig)/rf(orig, orig);
rhoy = rf(orig, orig + 1)/rf(orig, orig);
rho = (rhox + rhoy)/2;

fprintf('rho = %d\n', rho);

figure(90), colormap(gray)
imagesc(f), axis image, title('Original image');
figure(91), colormap(gray)
imagesc(rf), axis image, colorbar, title('ACF');

%% 2.3
% ---------------------------------------------------------------

im = getactive;
[cannyim1, tc] = edge(im, 'canny');
tc
newimage(cannyim1, 'canny1', 5);

T = 0.3;

cannyim2 = edge(im, 'canny', [0.4*T T], 1);
newimage(cannyim2, 'canny2', 5);

%% 3
% ---------------------------------------------------------------

a = getactive;

maxval = max(max(a));
b = maxval * imnoise(a/maxval, 'gaussian', 0.005);
newimage(b, 'saturnbrus', 2);

c = wiener2(b, [5 5]);
newimage(c, 'saturn with wiener', 2);

