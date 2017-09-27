function drawline(l,varargin),
%drawline: draws a line in the current figure where the line is represented
%using dual homogeneous coordinates l (a 3 element column vector)
%
%  Optional arguments: key-value pairs graphics arguments for setting
%  colour, line width, etc.
%
%  By default the function uses the ij coordinate system: origin at the upper
%  left corner, first axis pointing right and second axis pointing down.
%
%  Use key-value 'axis'-'xy' to use a xy coordinate system: origin at the
%  upper left corner, first axis pointing right and second axis pointing
%  down.

ax=axis;

line_length=2000;

if (sign(l(3))~=0),
  l=-l/norm(l(1:2))*sign(l(3));
else
  l=-l/norm(l(1:2));
end

y0=-l(1:2)*l(3);
y1=y0+line_length*[l(2) -l(1)]';
y2=y0-line_length*[l(2) -l(1)]';

xyflag=false;
for ix=1:2:length(varargin),
  if ((strcmp(varargin{ix},'axis'))&&(strcmp(varargin{ix+1},'xy'))),
    xyflag=true;
  end
end

if (xyflag),
  h=plot([y1(1) y2(1)],[y1(2) y2(2)]);
else
  h=plot([y1(2) y2(2)],[y1(1) y2(1)]);
end

if (~isempty(varargin)),
  for ix=1:2:length(varargin)
    if (~strcmp(varargin{ix},'axis')),
      set(h,varargin{ix},varargin{ix+1});
    end
  end
end  

axis(ax);

return
