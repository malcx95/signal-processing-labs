# 1

Min: 2
Max: 207

# 2

Left: (x, y) = (45, 15), index: 100
Right: (x, y) = (45, 15), index: 100

# 3

They differ in the sense that `mycolormap0` is linearly
distributed between 0 and 1, while the map in the lecture
is between 0 and 255.

# 4

`mycolormapR` maps all the 56 brightest values to red (1.0, 0, 0).
The brightest parts of the left image therefore become red.

# 5

Blue and greenish blue

# 6

The fine details, edges and lines are blurred out.

# 7

The values outside the image are treated as zero, but the extra size gained from
convolving with the outside is thrown away, so the image stays the same size.

# 8

The filtering effect becomes stronger (more blur).

# 9

The convolution is a weighted average, where the sum of the values in the filter is 16.
To achieve an average we must therefore divide by 16, to preserve the brightness.
If this factor is decreased, the image brightness increases.

# 10

`full` means treating outside values as zeros, and keeping the values obtained from
convolving with part of the outside. With this option the image size increases.

`valid` means never convolving outside the image. This decreases the image size.

# 11

```
-------------------------------
|  1  |  4  |  4  |  0  |  0  |
-------------------------------
|  1  |  7  | 10  |  0  |  0  |
-------------------------------
|  1  |  9  | 20  |  8  |  0  |
-------------------------------
|  0  |  3  | 14  | 11  |  0  |
-------------------------------
|  0  |  1  |  7  | 13  |  3  |
-------------------------------
```

# 12

```
abs(IM): Even, since |F(u, v)| = |F(-u, -v)|
angle(IM): Odd, since arg{F(a, b)} = -arg{F(-a, -b)}
real(IM): Even
imag(IM): Odd
```

# 13

For any real constants a, b, and any 2D signal x(u, v), if x(u, v) has the amplitude
spectrum |X(u, v)|, then x(u - a, v - a) also has the spectrum |X(u, v)|.

# 17

7x7

# 19

