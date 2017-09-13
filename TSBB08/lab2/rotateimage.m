
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

                    RotateIm(yg, xg) = Im(yf, xf) * (1 - xe) * (1 - ye) ...
                                        + Im(yf, xf + 1) * xe * (1 - ye) ...
                                        + Im(yf + 1, xf) * (1 - xe) * ye ...
                                        + Im(yf + 1, xf + 1) * xe * ye;
                end
            end
        end
    case 'bicubic'
        for xg = 1:cols	
            for yg = 1:rows
                xyff = inv(T)*[xg - cx;yg - cy] + [cx; cy];
                xff  = xyff(1);
                yff  = xyff(2);
                if (xff <=cols & yff <=rows & xff>=1 & yff>=1)
                    xf = floor(xff);
                    yf = floor(yff);
                    xe = xff - xf;
                    ye = yff - yf;
                    RotateIm(yg, xg) = Im(yf, xf) * h4(ye) * h4(xe) + ...
                                Im(yf, xf + 1) * h4(ye) * h4(1 - xe) + ...
                                Im(yf + 1, xf) * h4(1 - ye) * h4(xe) + ...
                                Im(yf + 1, xf + 1) * h4(1 - ye) * h4(1 - xe);
                end
            end
        end
    case 'bicubic16'
        for xg = 1:cols	
            for yg = 1:rows
                xyff = inv(T)*[xg - cx;yg - cy] + [cx; cy];
                xff  = xyff(1);
                yff  = xyff(2);
                if (xff<cols-1 & yff<rows-1 & xff>2 & yff>2)

                    yf=floor(yff);
                    xf=floor(xff);
                     
                    dxf=xff-xf;
                    dxff=dxf+1;
                    dxc=1-dxf;
                    dxcc=1+dxc;
                     
                    dyf=yff-yf;
                    dyff=dyf+1;                    
                    dyc=1-dyf;                    
                    dycc=dyc+1;
                     
                    firstRow =  h(dxff)*h(dyff)*Im(yf-1,xf-1)+...
                    h(dxff)*h(dyf)* Im(yf,xf-1)+...
                    h(dxff)*h(dyc)* Im(yf+1,xf-1)+...
                    h(dxff)*h(dycc)*Im(yf+2,xf-1);

                    secondRow = h(dxf)*h(dyff)* Im(yf-1,xf)+...
                    h(dxf)*h(dyf)*  Im(yf,xf)+...
                    h(dxf)*h(dyc)*  Im(yf+1,xf)+...
                    h(dxf)*h(dycc)* Im(yf+2,xf);

                    thirdRow =  h(dxc)*h(dyff)* Im(yf-1,xf+1)+...
                    h(dxc)*h(dyf)*  Im(yf,xf+1)+...
                    h(dxc)*h(dyc)*  Im(yf+1,xf+1)+...
                    h(dxc)*h(dycc)* Im(yf+2,xf+1);

                    fourthRow = h(dxcc)*h(dyff)*Im(yf-1,xf+2)+...
                    h(dxcc)*h(dyf)* Im(yf,xf+2)+...
                    h(dxcc)*h(dyc)* Im(yf+1,xf+2)+...
                    h(dxcc)*h(dycc)*Im(yf+2,xf+2);

                    RotateIm(yg,xg) = firstRow+secondRow+thirdRow+fourthRow;

                elseif (xff<cols & yff<rows & xff>1 & yff>1)
                 
                    xf = floor(xff);
                    yf = floor(yff);
                    xe = xff - xf;
                    ye = yff - yf;
                    RotateIm(yg, xg) = Im(yf, xf) * h4(ye) * h4(xe) + ...
                                Im(yf, xf + 1) * h4(ye) * h4(1 - xe) + ...
                                Im(yf + 1, xf) * h4(1 - ye) * h4(xe) + ...
                                Im(yf + 1, xf + 1) * h4(1 - ye) * h4(1 - xe);

                end
            end
        end

    otherwise
         error('Unknown interpolation method');
end
end
