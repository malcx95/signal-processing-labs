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
where there is a local minimum between the two large bumps.

We can see that we should threshold at about 132.

# 12

nuf0a was fixed using three erosions with d(8), and four dilations with d(8),
and then doing the erosion once more. (closing + opening)

nuf5 was fixed using several dilations with d(4), for example four times, 
and then performing an equal number of erosions with d(4).

# 13

(see notes)

# 14

Erosion removed the most noise and gave the smoothest outline. However, erosion
could split the object into two, since it's not connectivity preserving.

# 15

0, if we want to check when the image converges to one point.

# 16

It's a closed loop. This means that there will be no end points to trim off.

# 17

A 4 connective skeleton is a skeleton where only pixels above, below, 
to the left, and right of each pixel can be connected. With 8-connectivity,
it can be connected diagonally as well.

# 18

No, you can't. The skeleton contains no information about how thick
the original object was in different places.

# 19

(see notes)

# 20

Yes, it looks the same.

# 21

I use thin2 with 8-connectivity 8 iterations.

# 22

The three first columns can be removed.

# 23

Yes

# 24

I hope so.

# 25

One connector is too thin, and two connectors are too close to eachother.
There is also some solder garbage on the board.

# 26

When checking for too narrow distances between connectors, the soldering contacts
are incorrectly marked, since the holes causes the algorithm to think it's two
connectors that are too close.

# 27

It got the labels 0-93.

# 28

0

# 29

It assigns the lower values to the objects with top-left corners close to 
the top-left corner in the image, and the higher to the ones close to the 
bottom right corner, which was expected.

# 30

(see notes)

# 31

(see notes)

# 32

(see notes)

# 33

I think so.

# 34

Endpoints: 78
Ramifications: 44

# 35

Yes, using the default colormap, the furthest areas to the border are red.

# 36

Change bw from 0 to 1.

# 37

The skeleton is neither connected nor binary. (using bona.mat)

# 38

(see image on labyrinth 1)

# 39



