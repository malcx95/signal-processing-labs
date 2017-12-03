# Introduction

  - Missing period at the end of the first sentence

# Part 1 - Whistle

  - Typesetting of the word "kHz"

  - Figure 1: Wrong horizontal axis scaling as well as incorrect unit (Hz)

## Tasks and implementation

  - The sentence "Then a bandpass filter was created, the filtered signal
    is refered to as xfilt" could be split into two for clarity

  - Equation punctuation is not consistent. In the course they seem to prefer
    period after the equation.

  - Typesetting of the word "Hdist"

  - Would be nice with some formulas / reference to the book / reference to
    the code for how the AR model is estimated

  - Would be nice with a graph over the residual error for different orders
    to clarify what you mean with "knee" and so on


## Results

  - What is "[X, Y]" ?

  - Figure 3: Wrong horizontal axis scaling as well as incorrect unit (Hz)

  - Dominating frequency not given

# Vowel

  - Sentence: The task was "to" determine

  - Typesetting of the word "kHz"

## Tasks and implementation

  - Would be nice with a reference to figure 5 when explaining how the
    order of the model is determined

  - You explain how you check whiteness but not why you want to do that

  - Might want to explain how you check the correlation between residual
    error and the validation data

## Results

  - Equation punctuation

  - Figures 6, 7 and 8: The unit of the horizontal axis. You maybe mean the
    order of the model, in which case it is inconsistent with figure 5 where
    you actually wrote "Order" instead of "k"

# Speech

  - Why do we divide the signal into segments ?

## Tasks and implementation

  - What do you mean by theta values ?

  - Should be segments of 160 samples each, not 160 segments.

  - The covariance function is always highest in the origin. You are
    looking for the first residual peak / "ghost peak" when determining
    the period and amplitude

  - You do not mention that part of the task is to set the amplitude of
    all the pulse trains to 1

  - You do not mention that part of the task is to vary the order and
    listen to the differences

## Results

  - You set the amplitude of the pulse trains to 1, not the amplitude of
    the actual segments

  - Are 9 parameters needed for the AR(8) model ?

# Matlab-code

  - Too long lines go outside the margin and are clipped

  - No reference to the code

# Overall comments

## Positive

  - Covered all the steps and tasks

  - Nice figures and layout of the report

## Negative

  - Would be nice with some more mathematical formulas where possible. No
    need for any derivations. Also you could reference to the course book
    for any derivation / theory and to the matlab code

  - In some cases an extra figure would have made it clearer what you mean.
    For example to show what you mean by a "knee" in the whistling part.

  - Make sure scaling and labeling of axes in figure is correct.
