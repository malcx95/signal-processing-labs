execute('chooseobject', 'B1', 200, 165, 17, 17)

pattern = getactive;
img = getimg('B1');

correlated = corrdcp(img, pattern);

th = threshold(correlated, 140, '>');

figure(25);
subplot(2,1,1);imagesc(img);title('Original image');
subplot(2,1,2);imagesc(overlay(img, th));title('Correlated image');

colormap(gray);

[~, num] = labeling(th, 8);

fprintf('Num blood cells: %d\n', num);

