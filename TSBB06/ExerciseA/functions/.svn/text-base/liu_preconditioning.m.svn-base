function [newdata T] = liu_preconditioning(data,s),
%
% [newdata T] = liu_preconditioning(data[,s])
%
% Transforms data, homogeneous 2D or 3D coordinates, into
% Hartley-normalized coordinate system (translation + uniform scaling).
% After transformation the centroid is at (0,0) and the mean distance to
% (0,0) is = s.
%
% newdata is the transformed (Hartley-normalized) data
% T a the 3 x 3 transformation matrix such that newdata = T * data
%
% If s is not specified, s is given by sqrt(dim), dim=dimension of the
% Eucldiean space for data.
%
% NOTE: all homogeneous corodinates are 1-LAST

dim=size(data,1);
if (nargin==1),
  s=sqrt(dim-1);
end

ndata=data./(ones(dim,1)*data(end,:));
m=mean(ndata,2);
tt=[eye(dim-1) -m(1:(dim-1));zeros(1,dim-1) 1];
ndata=tt*ndata;
d=mean(sqrt(sum(ndata(1:(dim-1),:).^2)))+eps;
st=[s*eye(dim-1)/d zeros(dim-1,1);zeros(1,dim-1) 1];
newdata=st*ndata;
T=st*tt;

return
