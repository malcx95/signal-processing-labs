function RotateIm = rotateimage(Im, theta, intpol)

% ....

switch intpol
   case 'nearest'
    % rotation code with nearest neighbor interpolation
   case 'bilinear'
    % rotation code with bilinear interpolation
   case 'bicubic'
    % rotation code with bicubic interpolation
   otherwise
    error('Unknown interpolation method');
end
