img = getimg('B1');

T1 = 55;
T2 = 80;

th = threshysteris2(img, T1, T2);
[out, ~] = labeling(th, 8);
selected = selectobj(out, 40, 1000);
[~, num] = labeling(selected, 8);

figure(26);
imagesc(overlay(img, selected));


fprintf('Num blood cells: %d\n', num);

