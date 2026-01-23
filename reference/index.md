# Package index

## Reserving Models

Five stochastic reserving model implementations

- [`berquist()`](https://rmsharp.github.io/stochasticreserver/reference/berquist.md)
  : Create list for Berquist-Sherman incremental severity model
- [`capecod()`](https://rmsharp.github.io/stochasticreserver/reference/capecod.md)
  : Create list for Kramer Chain Ladder parmaterization model g -
  Assumed loss emergence model, a function of the parameters a. Note g
  must be matrix-valued with size rows and size columns g itself Basic
  design is for g to be a function of a single parameter vector, however
  in the simulations it is necessary to work on a matrix of parameters,
  one row for each simulated parameter, so g_obj must be flexible enough
  to handle both. Here g_obj is nonlinear and based on the Kramer Chain
  Ladder parmaterization
- [`chain()`](https://rmsharp.github.io/stochasticreserver/reference/chain.md)
  : Create list for Cape Cod model
- [`hoerl()`](https://rmsharp.github.io/stochasticreserver/reference/hoerl.md)
  : Create list for Generalized Hoerl Curve Model with trend g itself
  Basic design is for g to be a function of a single parameter vector,
  however in the simulations it is necessary to work on a matrix of
  parameters, one row for each simulated parameter, so g_obj must be
  flexible enough to handle both. Here g_obj is Wright's operational
  time model with trend added
- [`wright()`](https://rmsharp.github.io/stochasticreserver/reference/wright.md)
  : Create list for Generalized Hoerl Curve with individual accident
  year levels (Wright's)

## Optimization Functions

Maximum likelihood estimation framework

- [`make_negative_log_likelihood()`](https://rmsharp.github.io/stochasticreserver/reference/make_negative_log_likelihood.md)
  : Make Negative Loglikelihood Function to be Minimized
- [`make_gradient_of_objective()`](https://rmsharp.github.io/stochasticreserver/reference/make_gradient_of_objective.md)
  : Make Gradient of the objective function
- [`make_log_hessian()`](https://rmsharp.github.io/stochasticreserver/reference/make_log_hessian.md)
  : Make Hessian of the objective function

## Utility Functions

Helper functions and data

- [`get_incremental_avg_matrix()`](https://rmsharp.github.io/stochasticreserver/reference/get_incremental_avg_matrix.md)
  : Calculate incremental average matrix
- [`model_description()`](https://rmsharp.github.io/stochasticreserver/reference/model_description.md)
  : Get the long description of a model

## Data

Example datasets

- [`B0`](https://rmsharp.github.io/stochasticreserver/reference/B0.md) :
  B0 is a 10 x 10 matrix representing the upper triangle of a actuarial
  development triangle used by Roger Hayne to illustrate the stochastic
  loss reserving software in

- [`A0`](https://rmsharp.github.io/stochasticreserver/reference/A0.md) :
  A0 is a 10 x 10 matrix representing the upper triangle of a actuarial
  development triangle used by Roger Hayne to illustrate the stochastic
  loss reserving software in

- [`dnom`](https://rmsharp.github.io/stochasticreserver/reference/dnom.md)
  :

  dnom is count forcast for the B0 development triangle; the exposures
  (claims) used in the denominator \#' @format integer vector of length
  10

  B0

  :   count forcast for the B0 development triangle.

- [`table_1_triangle`](https://rmsharp.github.io/stochasticreserver/reference/table_1_triangle.md)
  : table_1_triangle is the development triangle from the reference
  article

- [`RAA_incremental`](https://rmsharp.github.io/stochasticreserver/reference/RAA_incremental.md)
  : RAA Incremental Claims Triangle

- [`RAA_cumulative`](https://rmsharp.github.io/stochasticreserver/reference/RAA_cumulative.md)
  : RAA Cumulative Claims Triangle
