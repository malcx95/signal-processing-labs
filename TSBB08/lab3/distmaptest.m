img = getactive;

dmap = distmap(img, 4, 0);

figure(20)
imagesc(dmap)

figure(21)
imagesc(distskel(dmap))
