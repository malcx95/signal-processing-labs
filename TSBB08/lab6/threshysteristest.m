img = getactive;

T1 = 110;
T2 = 150;

th = threshysteris(img, T1, T2);

figure(20);
imagesc(th);

