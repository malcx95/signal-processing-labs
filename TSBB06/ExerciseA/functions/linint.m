function [F,mask] = linint(arg1,arg2,arg3)
%LINEAR 2-D bilinear data interpolation.
%   [ZI,MASK] = LININT(Z,XI,YI) uses bilinear interpolation to find ZI,
%   the values of the underlying 2-D function in Z at the points
%   in matrices XI and YI. 
%   Code borrowed from Matlab INTERP2, but rewritten for speed.
%
%   Values of XI and YI that are outside of the range of X and Y
%   are indicated by zeroes in MASK.
%  
%   If XI and YI are vectors, LININT returns vector ZI containing
%   the interpolated values at the corresponding points (XI,YI).
%
%   This function needs about 4 times SIZE(XI) memory to be
%   available.

[nrows,ncols] = size(arg1);
s = arg2; t = arg3;

if any([nrows ncols]<[2 2]), error('Z must be at least 2-by-2.'); end
if ~isequal(size(s),size(t)),
  error('XI and YI must be the same size.');
end

% Check for out of range values of s and set to 1
sout = find((s<1)|(s>ncols));
if length(sout)>0, s(sout) = ones(size(sout)); end

% Check for out of range values of t and set to 1
tout = find((t<1)|(t>nrows));
if length(tout)>0, t(tout) = ones(size(tout)); end

% Matrix element indexing
ndx = floor(t)+floor(s-1)*nrows;

% Compute interpolation parameters, check for boundary value.
if isempty(s), d = s; else d = find(s==ncols); end
s(:) = (s - floor(s));
if length(d)>0, s(d) = s(d)+1; ndx(d) = ndx(d)-nrows; end

% Compute interpolation parameters, check for boundary value.
if isempty(t), d = t; else d = find(t==nrows); end
t(:) = (t - floor(t));
if length(d)>0, t(d) = t(d)+1; ndx(d) = ndx(d)-1; end
d = [];

% Now interpolate
F =  ( arg1(ndx).*(1-t) + arg1(ndx+1).*t ).*(1-s) + ...
     ( arg1(ndx+nrows).*(1-t) + arg1(ndx+(nrows+1)).*t ).*s;

% Now set out of range values to 0.
% NOTE: Was set to NaN in interp2
%if length(sout)>0, F(sout) = 0; end
%if length(tout)>0, F(tout) = 0; end

if nargout>1,
  % Also output valid mask
  mask=ones(size(F));
  mask(sout)=0;
  mask(tout)=0;
end
