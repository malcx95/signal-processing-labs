function x=liu_qmult(varargin),

if (nargin==2),

  s1=varargin{1}(1);
  s2=varargin{2}(1);

  v1=varargin{1}(2:4);
  v2=varargin{2}(2:4);

  x=[s1*s2-v1'*v2;
     s1*v2+s2*v1+cross(v1,v2)];
  
else
    
  x=liu_qmult(liu_qmult(varargin{1},varargin{2}),varargin{3:end});
  
end

return
