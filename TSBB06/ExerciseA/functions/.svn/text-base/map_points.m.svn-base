%function P2=map_points(H,P1)
%
% Map point list P1=[x; y] to
% a new point list using the homography H
%
%Per-Erik Forssen, Aug 2003

function P2=map_points(H,P1)

Np=size(P1,2);

Ph=H*[P1; ones(1,Np)];
P2=[Ph(1,:)./Ph(3,:); Ph(2,:)./Ph(3,:)];
