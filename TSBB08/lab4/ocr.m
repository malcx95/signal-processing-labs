
im = getactive;
hist = histogram(im);

meanh = meanhist(hist);

th = 0;

try
	th = leasterror(hist, meanh)
catch me
	kern = getkern('laplace25neg');
	im = circconv(im, kern, 625);
	im = s2u(im);
	hist = histogram(im);
	meanh = meanhist(hist);
	th = leasterror(hist, meanh)
end

thIm = threshold(im, th, '<');

figure(20);
subplot(2, 3, 1);
imagesc(thIm);
colormap gray;

subplot(2, 3, 2);

dilated = expand(thIm, 8, 2);
eroded2 = contract(dilated, 4, 2);
dilated = expand(eroded2, 8, 2);
eroded2 = contract(dilated, 4, 2);

imagesc(eroded2);
colormap gray;

subplot(2, 3, 3);
[labeled, num] = labeling(eroded2, 8);
imagesc(labeled);

object = eroded2;

if num > 1
	subplot(2, 3, 4);
	extracted = ocrextract(labeled, 0);
	imagesc(extracted);
	object = extracted;
end;

thinned = thin2(object, 8, 11);
subplot(2, 3, 5);
imagesc(thinned);

result = ocrdecide(thinned, 8)

