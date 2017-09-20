function out = leasterror(in, start)
num = length(in);
t1 = round(start);
t0 = t1+2;
% Calculate the threshold
%------------------------
while abs(t0-t1) > 0.5
	t0 = t1;
	num0 = t0;
	% Calculate mean for the lower part of the histogram
	% --------------------------------------------------
	lowersum1 = sum(in(1:num0)*(1:num0)');
	lowersum2 = sum(in(1:num0));
	if lowersum2 ~= 0
		mean0 = lowersum1/lowersum2;
	else
		mean0 = num0;
	end;
	% Calculate mean for the upper part of the histogram
	% --------------------------------------------------
	uppersum1 = sum(in(num0+1:num)*(num0+1:num)');
	uppersum2 = sum(in(num0+1:num));
	if uppersum2 ~= 0
		mean1 = uppersum1/uppersum2;
	else
		mean1 = num0;
	end;
	% Calculate new threshold
	% -----------------------
	var0 = sum(in(1:num0) * (([1:num0] - mean0) .^2)') / lowersum2;
	var1 = sum(in(num0+1:num) * (([num0+1:num] - mean1) .^2)') / uppersum2;

	P0 = lowersum2 / (lowersum2 + uppersum2);
	P1 = uppersum2 / (lowersum2 + uppersum2);

	one_over_a = (var1 - var0) / (var0 * var1);
	b = 2 * ((-mean0/var0) + (mean1/var1));
	c = -2 * log(P0/P1) + log(var0/var1) + (mean0^2/var0) - (mean1^2/var1);

	rs = roots([one_over_a, b, c]);

	if rs(1) <= mean1 && rs(1) >= mean0
		t1 = round(rs(1));
	else
		t1 = round(rs(2));
    end;
end;
out = round(t1);

