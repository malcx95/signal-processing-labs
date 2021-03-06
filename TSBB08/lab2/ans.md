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

```matlab
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

```matlab
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

```matlab
xf = floor(xff);
yf = floor(yff);
xe = xff - xf;
ye = yff - yf;

g(yg, xg) = f(yf, xf) * h(ye) * h(xe) + 
        f(yf, xf + 1) * h(ye) * h(1 - xe) + 
        f(yf + 1, xf) * h(1 - ye) * h(xe) + 
        f(yf + 1, xf + 1) * h(1 - ye) * h(1 - xe);
```

# 24

The difference image once again looks like the contours from the original image, since
that is where the errors are located.

# 25

The energy is approximately 94, which is less than the two others.

# 26

The errors are even more in the higher frequencies.

# 27

Because h is no longer positive for all inputs.

# 28

The errors are even less than from bicubic4, and still located around the 
edges.

# 29

The energy is approximately 52, which is again lower than the others.

# 30

Again, the errors are even more distributed in the higher frequencies.

# 31

I'm content at least.

# 32

Yes, it's 134 here again.

# 33

You change the string 'nearest' to 'linear'. And yes, the energy is 
again about 129.

# 34

You change the string to 'cubic'. And the energy is again about 52.

