# RAA Incremental Claims Triangle

Incremental claims data from the Reinsurance Association of America
(RAA), converted from the cumulative triangle in the ChainLadder
package. This is a classic 10x10 development triangle commonly used in
actuarial reserving literature.

## Usage

``` r
RAA_incremental
```

## Format

A 10 x 10 numeric matrix with:

- rows:

  Accident years 1981-1990

- columns:

  Development periods 1-10

- values:

  Incremental paid claims (thousands of dollars)

## Source

Originally from the Reinsurance Association of America. Obtained from
the ChainLadder R package (Gesmann et al., 2025).
<https://mages.github.io/ChainLadder/>

## Details

The data represents historical general liability claims from 1981-1990
with 10 development periods. Values are in thousands of dollars.

## Note

This data was converted from cumulative to incremental format. Negative
values (e.g., in 1982, period 7) represent payment recoveries or
adjustments.

## References

Gesmann M, Murphy D, Zhang Y, Carrato A, Wuthrich M, Concina F, Dal Moro
E (2025). ChainLadder: Statistical Methods and Models for Claims
Reserving in General Insurance. R package version 0.2.20.

## See also

[`RAA_cumulative`](https://rmsharp.github.io/stochasticreserver/reference/RAA_cumulative.md)
for the cumulative version

## Examples

``` r
data(RAA_incremental)
# View the triangle
print(RAA_incremental)
#>       dev
#> origin    1    2    3    4    5    6    7   8   9  10
#>   1981 5012 3257 2638  898 1734 2642 1828 599  54 172
#>   1982  106 4179 1111 5270 3116 1817 -103 673 535  NA
#>   1983 3410 5582 4881 2268 2594 3479  649 603  NA  NA
#>   1984 5655 5900 4211 5500 2159 2658  984  NA  NA  NA
#>   1985 1092 8473 6271 6333 3786  225   NA  NA  NA  NA
#>   1986 1513 4932 5257 1233 2917   NA   NA  NA  NA  NA
#>   1987  557 3463 6926 1368   NA   NA   NA  NA  NA  NA
#>   1988 1351 5596 6165   NA   NA   NA   NA  NA  NA  NA
#>   1989 3133 2262   NA   NA   NA   NA   NA  NA  NA  NA
#>   1990 2063   NA   NA   NA   NA   NA   NA  NA  NA  NA

# Convert back to cumulative
RAA_cum <- t(apply(RAA_incremental, 1, cumsum))
```
