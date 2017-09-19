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

var0 = sum(in(1:num0) .* ((lowersum2 - mean0) .^2));
var1 = sum(in(num0+1:num) .* ((uppersum2 - mean1) .^2));

P0 = lowersum2 / (lowersum2 + uppersum2);
P1 = uppersum2 / (lowersum2 + uppersum2);

one_over_a = (var1 - var0) / (var0 * var1);
b = -2 * ((mean0/stddev0) + (mean1/stddev1));
c = -2 * log(P0/P1) + log(var0/var1) + (mean0^2/var0) - (mean1^2/var0)

[root1, root2] = roots([one_over_a, b, c])

if root1 <= mean1 and root1 >= mean0
    t1 = root1
else
    t1 = root2

```

