function out = midway(in, start)
%# operation 'midway'
%# returns integer 'Threshold'
%# param in histogram 'Histogram'
%# param start integer 'Start'

num = length(in);
t1 = round(start);
t0 = t1+2;

% Calculate the threshold
%------------------------
while abs(t0-t1) > 0.5

  t0 = t1;
  num0 = t0;
    
  % Calculate mean for the lower part of the histogram
  %---------------------------------------------------
  lowersum1 = sum(in(1:num0)*[1:num0]');
  lowersum2 = sum(in(1:num0));
  if lowersum2 ~= 0
    mean0 = lowersum1/lowersum2;
  else
    mean0 = num0;
  end;
    
  % Calculate mean for the upper part of the histogram
  %---------------------------------------------------
  uppersum1 = sum(in(num0+1:num)*[num0+1:num]');
  uppersum2 = sum(in(num0+1:num));
  if uppersum2 ~= 0
    mean1 = uppersum1/uppersum2;
  else
    mean1 = num0;
  end;

  % Calculate new threshold
  %------------------------
  t1 = round((mean0+mean1)/2);

end;

out = t1;
