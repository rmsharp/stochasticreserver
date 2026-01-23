# RAA Cumulative Claims Triangle

Cumulative claims data from the Reinsurance Association of America
(RAA), obtained from the ChainLadder package. This is a classic 10x10
development triangle commonly used in actuarial reserving literature.

## Usage

``` r
RAA_cumulative
```

## Format

A 10 x 10 numeric matrix with:

- rows:

  Accident years 1981-1990

- columns:

  Development periods 1-10

- values:

  Cumulative paid claims (thousands of dollars)

## Source

Originally from the Reinsurance Association of America. Obtained from
the ChainLadder R package (Gesmann et al., 2025).
<https://mages.github.io/ChainLadder/>

## Details

The data represents historical general liability claims from 1981-1990
with 10 development periods. Values are in thousands of dollars.

## References

Gesmann M, Murphy D, Zhang Y, Carrato A, Wuthrich M, Concina F, Dal Moro
E (2025). ChainLadder: Statistical Methods and Models for Claims
Reserving in General Insurance. R package version 0.2.20.

## See also

[`RAA_incremental`](https://rmsharp.github.io/stochasticreserver/reference/RAA_incremental.md)
for the incremental version

## Examples

``` r
data(RAA_cumulative)
# View the triangle
print(RAA_cumulative)
#>       dev
#> origin    1     2     3     4     5     6     7     8     9    10
#>   1981 5012  8269 10907 11805 13539 16181 18009 18608 18662 18834
#>   1982  106  4285  5396 10666 13782 15599 15496 16169 16704    NA
#>   1983 3410  8992 13873 16141 18735 22214 22863 23466    NA    NA
#>   1984 5655 11555 15766 21266 23425 26083 27067    NA    NA    NA
#>   1985 1092  9565 15836 22169 25955 26180    NA    NA    NA    NA
#>   1986 1513  6445 11702 12935 15852    NA    NA    NA    NA    NA
#>   1987  557  4020 10946 12314    NA    NA    NA    NA    NA    NA
#>   1988 1351  6947 13112    NA    NA    NA    NA    NA    NA    NA
#>   1989 3133  5395    NA    NA    NA    NA    NA    NA    NA    NA
#>   1990 2063    NA    NA    NA    NA    NA    NA    NA    NA    NA

# Convert to incremental
RAA_incr <- cbind(RAA_cumulative[,1],
                  t(apply(RAA_cumulative, 1, diff)))
```
