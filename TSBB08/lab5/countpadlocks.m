function [res, maxpoints] = countpadlocks(filteredIm)


thresholded = filteredIm > 25;
multiplied = thresholded .* filteredIm;

maxpoints = imregionalmax(multiplied);

res = sum(sum(maxpoints));

