%function img=image_resample(img0,H,rows,cols)
%
% Resample image using bilinear interpolation
%
% IMG0   Input image (UINT8,MxNx3)
% H      Homography for bilinear interpolation
% ROWS   Number of rows in output image (default is maxy)
% COLS   Number of cols in output image (default is maxx)
%
%Per-Erik Forssen, June 2008
function [img mask Xs Ys]=image_resample(img0,H,rows,cols)

[r,c,ndim]=size(img0);

if nargin<4,
    X=[1 c c 1;1 1 r r]
    Xm=map_points(H,X)
    rows=max(Xm(2,:));%rows=max(Xm,2)
    cols=max(Xm(1,:));%cols=max(Xm,1)
end

% Find coordinates to sample from
[X,Y]=meshgrid(1:cols,1:rows);
P=map_points(inv(H),[X(:)';Y(:)']);
Xs=reshape(P(1,:),size(X));
Ys=reshape(P(2,:),size(Y));

for k=1:ndim,
    [tempim mask] =linint(img0(:,:,k),Xs,Ys);
    img(:,:,k) = tempim .* mask;
end

%img=cvRemap_mex(img0,single(Xs-1),single(Ys-1),'CV_INTER_LINEAR',0);
