# 1

Because xg and xy are the coordinates in the out image.
To calculate the transformed coordinates (__v__) from the 
input (__u__), we use:

```
v = Tu
```

Since we have __v__ already, and want to know which __u__
should be mapped to it, we rearrange:

```
u = (T^-1)v
```

Therefore, we need the inverse of __T__.

# 2

The top of the image.

# 3

```matlab
xyff = inv(T)*[xg - cx;yg - cy] + [cx; cy];
```

That is, shifting the coordinates, transforming
them, and then shifting them back.

# 4

Yes, shearImageFast was 40 times faster.

# 5

```
|xg - xt|   | cos(theta) sin(theta)||x + xt| 
|yg - yt| = |-sin(theta) cos(theta)||y + yt|

```

# 6

```
xg = round(xf)
yg = round(yf)

```

# 7

The errors are all where neighboring pixels have different colors. So
around the edge of the ring and the text.

# 8

134

# 9

To avoid negative values in the image and avoid zero being undefined.

# 10

They look very similar.

# 11

They seem to be distributed in a noise-like way for both high 
and low frequencies equally.

# 12

134

# 13

Parseval's relation says that the signal energy in the spatial/temporal
domain is the same as the energy in the fourier domain. And that is what we
saw.

# 14

Yes, I told you!

# 15

It captures more of the higher frequencies, that is, it captures whether the
details in the image has changed.

# 16

The errors are mostly in the higher frequencies, which is to be expected.

# 17

```
xf = floor(xff);
yf = floor(yff);
xe = xff - xf
ye = yff - yf

g(xg, yg) = f(xf, yf) * (1 - xe) * (1 - ye)
            + f(xf + 1, yf) * xe * (1 - ye)
            + f(xf, yf + 1) * (1 - xe) * ye
            + f(xf + 1, yf + 1) * xe * ye
```

# 18

The difference image now consists of the contours from the original image.

# 19

The error energy is now about 129, which is less than 134.

# 20

Because the bilinear interpolation is essentially a weighted average filter 
(low-pass filter), which blurs the image and removes detail, which can be 
seen in the fourier domain as attenuated high frequencies.

# 21

The fourier transform of the kernel used in the nearest neighbor convolution
is a sinc, which does not correspond to any low pass filtering.

# 22

The errors are even more concentrated in the higher frequencies compared to
nearest-neighbor.

# 23



