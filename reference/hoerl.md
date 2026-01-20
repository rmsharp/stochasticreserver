# Create list for Generalized Hoerl Curve Model with trend g itself Basic design is for g to be a function of a single parameter vector, however in the simulations it is necessary to work on a matrix of parameters, one row for each simulated parameter, so g_obj must be flexible enough to handle both. Here g_obj is Wright's operational time model with trend added

Create list for Generalized Hoerl Curve Model with trend g itself Basic
design is for g to be a function of a single parameter vector, however
in the simulations it is necessary to work on a matrix of parameters,
one row for each simulated parameter, so g_obj must be flexible enough
to handle both. Here g_obj is Wright's operational time model with trend
added

## Usage

``` r
hoerl(B0, paid_to_date, upper_triangle_mask)
```

## Arguments

- B0:

  development triangle

- paid_to_date:

  numeric vector of length `size`. It is the lower diagnal of the
  development triangle in row order. It represents the amount paid to
  date.

- upper_triangle_mask:

  is a mask matrix of allowable data, upper triangular assuming same
  development increments as exposure increments
