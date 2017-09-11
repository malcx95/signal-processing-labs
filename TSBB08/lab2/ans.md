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

