im1 = double(imread('C9minpeps2.bmp'));
figure(1), imshow(im1/255);

% Look at the three colour components RGB
%----------------------------------------
im1r=im1(:,:,1); im1g=im1(:,:,2); im1b=im1(:,:,3);
figure(2), imshow(im1r,[0 255]), colormap(gray), colorbar;
figure(3), imshow(im1g,[0 255]), colormap(gray), colorbar;
figure(4), imshow(im1b,[0 255]), colormap(gray), colorbar;

% Compute the histogram of the blue image and do threshholding
%-------------------------------------------------------------
histo = hist(im1b(:),[0:255]);
figure(5), stem(histo);
im1bT = im1b > 50;
figure(6), imshow(im1bT,[0 1]), colormap(gray), colorbar;

% Perfom opening
%---------------
tmp = bwmorph(im1bT,'erode',2);
tmp = bwmorph(tmp,'dilate',2);

% Perform closing
%----------------
tmp = bwmorph(tmp,'dilate',2);
im1bTmorph = bwmorph(tmp,'erode',2);

figure(7), imshow(im1bTmorph,[0 1]), colormap(gray), colorbar;

% Compute the distance transform inside the objects
%--------------------------------------------------
D = bwdist(~im1bTmorph);
figure(8), imshow(D,[],'InitialMagnification','fit');
title('Distance transform of ~bw');
colormap(jet), colorbar;

% Change the sign of the distance transform and 
% set pixels outside the object to the minimum value
%---------------------------------------------------
Dinv = -D;
Dinv(~im1bTmorph) = min(min(Dinv));
figure(9), imshow(Dinv,[],'InitialMagnification','fit');
title('Complement distance transform of ~bw');
colormap(jet), colorbar;

% Search for regional min
%------------------------

suppressed = imhmin(Dinv, 30); % supress local minima with depth less than 30
figure(30), imshow(suppressed, [], 'InitialMagnification', 'fit')
title('Suppressed');

RegMin = imregionalmin(suppressed,8);
figure(10), imshow(RegMin,[],'InitialMagnification','fit');
colormap(jet), colorbar;
title('regional min of Dinv');

% Perform labeling
%-----------------
labelstruct = bwconncomp(RegMin,8); 

% Make a labelimage to look at
%-----------------------------
NumObj = labelstruct.NumObjects;
labelim = zeros(labelstruct.ImageSize);
for no = 1:NumObj
  labelim(labelstruct.PixelIdxList{no}) = no;
end
figure(11), imshow(labelim,[],'InitialMagnification','fit');
colormap(jet), colorbar;
title('labeling of regional min');

% Compute the watershed transform
%--------------------------------
W1 = watershed_meyer(Dinv,8,labelstruct);
figure(12), imshow(W1,[],'InitialMagnification','fit');
colormap(jet), colorbar;
title('Watershed of Dinv');

W2 = W1;
loc = find(W1==1);
W2(loc) = 0;
figure(13), imshow(W2,[],'InitialMagnification','fit');
colormap(jet), colorbar;
title('Fixed Watershed of Dinv')

W2T = W2>=1;
figure(14), imshow(W2T,[],'InitialMagnification','fit');
colormap(gray), colorbar;
title('Final segmentation result')

% Compute the distance map outside the nuclei
%--------------------------------------------

dMap = bwdist(W2T);
for i = 1:length(dMap)
	for j = 1:length(dMap(:, 1))
		if dMap(i, j) > 100
			dMap(i, j) = 0;
		end
	end
end
figure(15), imshow(dMap, [], 'InitialMagnification', 'fit')
colormap(jet), colorbar;
title('Distance map of nuclei');

% Create water holes
%-------------------
holeMap = W2T;
% place a hole somewhere in the sea
holeMap(2, 2) = 1;
holesstruct = bwconncomp(holeMap, 8);

% Compute watershed
wShed = watershed_meyer(dMap, 8, holesstruct);
figure(16), imshow(wShed, [], 'InitialMagnification', 'fit')
colormap(jet), colorbar;
title('Watershed of dMap (cytoplasm)');

% Extract the border of the watershed
%-----------------------------------

[w, h] = size(wShed);
border = zeros(w, h);
for i = 1:w
    for j = 1:h
        if wShed(i, j) == 0
            border(i, j) = 1;
        end
    end
end

border = bwmorph(border, 'dilate', 1);
border = border * 255;
figure(18), imshow(border, [], 'initialmagnification', 'fit')
colormap(gray);
title('border of watershed');


% Create the image of the isolated cell
%-----------------------------------------------------------

isolated = zeros(w, h, 3);
for i = 1:w
    for j = 1:h
        if wShed(i, j) == 6
            isolated(i, j, :) = im1(i, j, :)/255;
        end
    end
end

% Remove the green
isolated(:,:, 2) = isolated(:,:,2)*0;

figure(18), imshow(isolated, [], 'initialmagnification', 'fit')
title('Isolated cell');

% Laplace filter the padlocks
%--------------------------------------------------------

redIm = isolated(:,:,1)*255;
lfilter = [
	-2 -4 -4 -4 -2;
	-4	0  8  0 -4;
	-4	8  24 8 -4; 
	-4	0  8  0 -4; 
	-2 -4 -4 -4 -2
	] / 64;
laplfiltim = conv2(redIm, lfilter);
figure(19), imshow(laplfiltim, []);
title('Laplace filtered padlocks');

% Count padlocks and generate maxpoints
%-------------------------------------------------------
[num, maxpoints] = countpadlocks(laplfiltim);

figure(20), imshow(maxpoints, []);
title('Padlock points');

% Create padlock circles
%-------------------------------------------------------
C = [ 0 0 0 0 0 1 1 0 0 0 0 0;
      0 0 0 1 1 0 0 1 1 0 0 0;
      0 0 1 0 0 0 0 0 0 1 0 0;
      0 1 0 0 0 0 0 0 0 0 1 0;
      0 1 0 0 0 0 0 0 0 0 1 0;
      1 0 0 0 0 0 0 0 0 0 0 1;
      1 0 0 0 0 0 0 0 0 0 0 1;
      0 1 0 0 0 0 0 0 0 0 1 0;
      0 1 0 0 0 0 0 0 0 0 1 0;
      0 0 1 0 0 0 0 0 0 1 0 0;
      0 0 0 1 1 0 0 1 1 0 0 0;
      0 0 0 0 0 1 1 0 0 0 0 0];

[cw, ch] = size(C);

circleIm = zeros(w, h);

for i = 1:w
    for j = 1:h
        if maxpoints(i, j) == 1
            circleIm(i - cw/2 - 1:i + cw/2 - 2, j - ch/2 - 1:j + ch/2 - 2) = ...
                circleIm(i - cw/2 - 1:i + cw/2 - 2, j - ch/2 - 1:j + ch/2 - 2) | C;
        end
    end
end

circleIm = circleIm * 255;

figure(21), imshow(circleIm, []);
title('Circles');

% Create final image
%---------------------------------------------------------
finalIm = im1;

borderAndCircles = ((border / 255) | (circleIm / 255)) * 255;

% add the border
finalIm(:,:,1) = max(im1r, border);
finalIm(:,:,2) = max(im1g, borderAndCircles);
finalIm(:,:,3) = max(im1b, circleIm);

figure(22), imshow(finalIm/255), title('Final image!');

