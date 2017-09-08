function shearIm = shearimageFast(Im, T)

T=inv(T);
[rows, cols] = size(Im);
shearIm = zeros(rows, cols);
[xgGrid, ygGrid] = meshgrid(1:cols, 1:rows);
xfGrid = round(xgGrid * T(1,1) + ygGrid * T(1,2));
yfGrid = round(xgGrid * T(2,1) + ygGrid * T(2,2));
ind1 = find(xfGrid>0 & xfGrid<=cols & yfGrid>0 & yfGrid<=rows);
ind2 = sub2ind([rows, cols],  yfGrid(ind1), xfGrid(ind1));
shearIm(ind1)=Im(ind2);
