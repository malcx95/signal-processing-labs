img = getactive;

dmap = distcad(img, 192, 52, 0);

res = distroute(dmap, 340, 240);

figure(22);
imagesc(res);

