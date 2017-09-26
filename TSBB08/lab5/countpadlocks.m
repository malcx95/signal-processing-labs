function res = countpadlocks(filteredIm)


thresholded = filteredIm > 25;
multiplied = thresholded .* filteredIm;

maxpoints = imregionalmax(multiplied);

figure(10), imshow(maxpoints, []);
title('Padlock points');

res = sum(sum(maxpoints));

