# 1

We want to start somewhere between the peaks, which
could be given by the mean of the histogram.
# 2

The thresholding of nuf4a went pretty well, there is some noise to the right in the image.
With nuf2a we got a lot of noise, the thresholding didn't go very well.

# 3

(see notes)

# 4

Replace `t1 = round((mean0 + mean1) / 2)` with:

```matlab

	var0 = sum(in(1:num0) * (([1:num0] - mean0) .^2)') / lowersum2
	var1 = sum(in(num0+1:num) * (([num0+1:num] - mean1) .^2)') / uppersum2

	P0 = lowersum2 / (lowersum2 + uppersum2);
	P1 = uppersum2 / (lowersum2 + uppersum2);

	one_over_a = (var1 - var0) / (var0 * var1);
	b = 2 * ((-mean0/var0) + (mean1/var1))
	c = -2 * log(P0/P1) + log(var0/var1) + (mean0^2/var0) - (mean1^2/var1)

	rs = roots([one_over_a, b, c]);

	if rs(1) <= mean1 && rs(1) >= mean0
		t1 = round(rs(1));
	else
		t1 = round(rs(2));
    end;
```

# 5

The result is much better for both images.

# 6

(see notes)

# 7

Since 25x25=625.

# 8

With circconv, we avoid white borders on the edges.

# 9

For nuf0b, this works much better than global thresholding, but not with nuf4a.

# 10

(see notes)

# 11

- nuf2b, thresholding went wrong.
- nuf4b, again, thresholding went wrong
- nuf8b, image wasn't dilated enough

# 12

I think so.

