# Create list for Cape Cod model

g itself Basic design is for g to be a function of a single parameter
vector, however in the simulations it is necessary to work on a matrix
of parameters, one row for each simulated parameter, so g_obj must be
flexible enough to handle both. Here g_obj is a version of the Cape Cod
model but with the restriction that the expected cumulative averge
payments to date equal the actual average paid to date. Because of this
restriction the incremental averages are expressed as a percentage times
the expected ultimate by row. Formulae all assume a full, square
development triangle.

## Usage

``` r
chain(B0, paid_to_date, upper_triangle_mask)
```

## Arguments

- B0:

  development triangle

- paid_to_date:

  numeric vector of length `size`. It is the lower diagonal of the
  development triangle in row order. It represents the amount paid to
  date.

- upper_triangle_mask:

  is a mask matrix of allowable data, upper triangular assuming same
  development increments as exposure increments
