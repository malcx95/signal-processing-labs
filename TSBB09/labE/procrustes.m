function R = procrustes(p1, p2)

P1 = cart2sphere(p1);
P2 = cart2sphere(p2);
[U D V] = svd(P2*P1');
R = V*U';


