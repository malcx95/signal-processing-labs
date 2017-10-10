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

# 14

Only the abs() has not changed. This is consistent with the translation
theorem, which predicts that only the phase spectrum changes. Since
the phase spectrum changes, but not the amplitude spectrum, the
real an imaginary parts of the fourier transform is changed.

# 15

X: 62, Y: 62, value: 5679

# 16

Sum is 5679, which matches with question 15.

# 17

7x7

# 18

The correct value is 0.0977, and that is what we see in the image.

# 19

Convolution of 2D-signals corresponds to a multiplication of the signals'
fourier transforms.

# 20

You can clearly see that each value of the amplitude spectrums of `im` and 
`aver3im` are multiplied with eachother to create the spectrum of `imconv`.
Where the spectrum of `aver3im` is dark, the result is dark.

# 21

low, high, high

# 22

Since it's the derivative we have (approximately) calculated in a specific direction,
it will get bright when we go from dark to bright (outside to inside the circle).
The opposite happens when we exits the circle, we go from bright to dark, which results 
in a negative derivative, which means darker edge. The grayer parts of the edge are
caused by the direction of the derivative having a less sharp angle with respect to
the circle.

# 23

`sqrt((df(x,y)/dx)^2 + (df(x,y)/dx)^2)`

# 24

[1 -1] * [1 -1] = [1 -2 1]
[-1; 1] * [-1; 1] = [1; -2; 1]

# 25

Yes, we see a dark ring inside the bright ring, which corresponds to the plot
of f''(x), which goes down and then up around the edges of the 'rect'-like f(x).

# 26

The contrast increases.

# 27

Details in these regions become more clear.

# 28

`imsharp` becomes sharper (more detail is visible) than the original image, 
and `imsharp2` becomes even sharper than that.

# 29

The dark frame comes from the fact that we wanted an image with the same resolution
after the convolution as before. This meant that we needed to include some of the
zeros on the outside of the image in our averaging, which results in darker pixels.

The effect on the spectrum is a star.

# 30

Both images are similarly blurred, but the new image lacks the darker border. The
amplitude spectrum of the new image looks more like a multiplication of the original
image's transform and the transform of the kernel, since the star effect is no longer there.

# 31

You can se small rings in the image.

# 32

(see notes)

