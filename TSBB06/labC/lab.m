k = 0:1:100;
s = sin(k/10);

%%
cert = double(rand(1, 101)>0.25);
scert = s.*cert;
run(scert);

x = (-3:3)';
b0 = ones(7, 1);
b1 = x;
b2 = x.^2;
a = exp(-x.^2/4);

f0 = b0.*a; f0 = f0(end:-1:1);
f1 = b1.*a; f1 = f1(end:-1:1);
f2 = b2.*a; f2 = f2(end:-1:1);

h0 = conv(scert, f0, 'same');
h1 = conv(scert, f1, 'same');

G11 = conv(cert, flipud(b0.*a.*b0), 'same');
G12 = conv(cert, flipud(b0.*a.*b1), 'same');
G22 = conv(cert, flipud(b1.*a.*b1), 'same');
detG = G11.*G22 - G12.^2;
c0 = (G22.*h0 - G12.*h1)./detG;
c1 = (-G12.*h0 + G11.*h1)./detG;
figure(7);
subplot(2, 1, 1);plot(c0);
subplot(2, 1, 2);plot(c1);

im = double(imread('Scalespace0.png'));
figure(8);colormap(gray);imagesc(im);
cert = double(rand(size(im))>0.9);
imcert = im.*cert;
figure(9);colormap(gray);imagesc(imcert);

kays = [3 5 9 11];
lims = [1 2 4 5];

for k = 1:4

	x = ones(kays(k),1)*(-lims(k):lims(k));
	y = x';
	a = exp(-(x.^2 + y.^2)/4);
	figure(10);
	subplot(2, 2, k);
	mesh(a);

	imlp = conv2(imcert, a, 'same');
	figure(11);
	subplot(2, 2, k);
	colormap(gray);imagesc(imlp);

	G = conv2(cert, a, 'same');
	c = imlp./G;
	figure(12);
	subplot(2, 2, k);
	colormap(gray);imagesc(c);

end
