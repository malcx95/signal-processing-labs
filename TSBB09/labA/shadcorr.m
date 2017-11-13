% Helpfile for shading correction
%
% 2013-11 - Maria Magnusson

fpath='shadingcorr/';

figure(1); colormap(gray);

load([fpath 'whiteimage']);
subplot(2,2,1), imagesc(whiteimage, [0 255]); axis image;
title('white image')

load([fpath 'darkimage']);
subplot(2,2,2), imagesc(darkimage, [0 255]); axis image;
title('dark image')

load([fpath 'blackimage']);
subplot(2,2,3), imagesc(blackimage, [0 255]); axis image;
title('black image')

load([fpath 'origimage']);
subplot(2,2,4), imagesc(origimage, [0 255]); axis image;
title('original image')
