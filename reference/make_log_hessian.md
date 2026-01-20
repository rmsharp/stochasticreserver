# Make Hessian of the objective function

\- m_expected_value is the expectated value matrix - m_variance is the
matrix of variances - A, m_expected_value, m_variance all have shape
c(size, size) - The variables \_v are copies of the originals to shape
c(npar,size,size), paralleling the gradient of g. - The variables \_m
are copies of the originals to shape c(npar,npar,size,size), paralleling
the hessian of g hessian-of-objective-function

## Usage

``` r
make_log_hessian(a, A, dnom, g_obj, g_grad, g_hess)
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

- g_grad:

  gradient function

- g_hess:

  hessian function
