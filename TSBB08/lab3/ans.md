# 1

The outcome should just be the original image.

# 2

Black: 0
Gray: around 128
White: 255

It simply converts converts the value x to the RGB value (x, x, x).

# 3

A bright value seems to correspond to a high absolute value.
This means that the values are transformed x -> (abs(x), abs(x), abs(x))

# 4

__clic__ is brighter, so the values in the histogram are mostly concentrated
to the right. __blod256__ is darker, so the histogram is more concentrated
to the left.

# 5

The values are not very spread out.

# 6

```
0 = A * 50 - B
200 = A * 200 - B
=>
A = 1.7, B = 85
```

# 7

The values are more spread out in the higher contrast image.

# 8

Dilation involves expanding the edges of white elements in an image.
Erosion means contracting these edges.

# 9

(see notes for sketches)

d(oct) gives the most uniform dilation/erosion.

# 10

To remove cracks and holes we can perform Closing, meaning we dilate and then erode.
To remove spurs and small branches, we can perform Opening, which is eroding and then dilating.

# 11

We can look in the histogram and see that we should threshold it right
where there is a local minimum between the two large bumps. This will
be close to using the least error method.

We can see that we should threshold at about 132.

