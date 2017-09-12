function RotateIm = rotateimage(Im, theta, intpol)

% ....
[rows, cols] = size(Im);	
RotateIm = zeros(rows, cols);

T = [cos(theta) sin(theta); -sin(theta) cos(theta)];

cx = cols/2;
cy = rows/2;

switch intpol
    case 'nearest'
        for xg = 1:cols	
            for yg = 1:rows
                xyff = inv(T)*[xg - cx;yg - cy] + [cx; cy];
                xff  = xyff(1);
                yff  = xyff(2);
                if (xff<=cols & yff<=rows & xff>=1 & yff>=1)
                    xf = round(xff);
                    yf = round(yff);
                    RotateIm(yg,xg) = Im(yf,xf);
                end
            end
        end
    case 'bilinear'
        for xg = 1:cols	
            for yg = 1:rows
                xyff = inv(T)*[xg - cx;yg - cy] + [cx; cy];
                xff  = xyff(1);
                yff  = xyff(2);
                if (xff<=cols & yff<=rows & xff>=1 & yff>=1)
                    xf = floor(xff);
                    yf = floor(yff);
                    xe = xff - xf;
                    ye = yff - yf;

                    RotateIm(yg, xg) = Im(yf, xf) * (1 - xe) * (1 - ye) + Im(yf, xf + 1) * xe * (1 - ye) + Im(yf + 1, xf) * (1 - xe) * ye + Im(yf + 1, xf + 1) * xe * ye;
                end
            end
        end
    case 'bicubic'
     % rotation code with bicubic interpolation
    otherwise
         error('Unknown interpolation method');
end
