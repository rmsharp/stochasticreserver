# Make Negative Loglikelihood Function to be Minimized

Note that the general form of the model has parameters in addition to
those in the loss model, namely the power for the variance and the
constant of proprtionality that varies by column. So if the original
model has k parameters with size columns of data, the total objective
function has k + size + 1 parameters

## Usage

``` r
make_negative_log_likelihood(a, A, dnom, g_obj)
```

## Arguments

- a:

  do not know

- A:

  do not know

- dnom:

  numeric vector representing the exposures (claims) used in the
  denominator

- g_obj:

  objective function
