
load([fpath 'whiteimage']);
load([fpath 'darkimage']);
load([fpath 'blackimage']);
load([fpath 'origimage']);

fA = mean(mean(darkimage));
fB = mean(mean(whiteimage));

bA = darkimage;
bB = whiteimage;

c = (fB - fA)./(bB - bA);
d = (fA*bB - fB*bA)./(fB - fA);

corrected = c.*(origimage + d);

figure(2); colormap(jet);
imagesc(corrected, [0 255]);

figure(3); colormap(jet);
imagesc(origimage, [0 255]);

fA = mean(mean(blackimage));
fB = mean(mean(whiteimage));

fprintf('fA for black: %d\n', fA);
fprintf('fB for black: %d\n', fB);

bA = blackimage;
bB = whiteimage;

c = (fB - fA)./(bB - bA);
d = (fA*bB - fB*bA)./(fB - fA);

corrected = c.*(origimage + d);

figure(4); colormap(jet);
imagesc(corrected, [0 255]);

