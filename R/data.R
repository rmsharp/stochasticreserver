#' B0 is a 10 x 10 matrix representing the upper triangle of a actuarial
#' development triangle used by Roger Hayne to illustrate the stochastic
#' loss reserving software in
#'
#'
#' @format A 10 x 10 numeric matrix
#' \describe{
#' \item{B0}{Development triangle.}
#' }
#' @source "A Flexible Framework for Stochastic Reserving Models" found at
#' \url{https://variancejournal.org/article/120823}
"B0"
#' A0 is a 10 x 10 matrix representing the upper triangle of a actuarial
#' development triangle used by Roger Hayne to illustrate the stochastic
#' loss reserving software in
#'
#'
#' @format A 10 x 10 numeric matrix
#' \describe{
#' \item{A0}{Development triangle.}
#' }
#' @source "A Flexible Framework for Stochastic Reserving Models" found at
#' \url{https://variancejournal.org/article/120823}
"A0"
#' dnom is count forcast for the B0 development triangle; the exposures
#' (claims) used in the denominator
#' #' @format integer vector of length 10
#' \describe{
#' \item{B0}{count forcast for the B0 development triangle.}
#' }
#' @source "A Flexible Framework for Stochastic Reserving Models" found at
#' \url{https://variancejournal.org/article/120823}
"dnom"
#' table_1_triangle is the development triangle from the reference article
#'
#'
#'
#' @format A 10 x 10 numeric matrix
#' \describe{
#' \item{table_1_triangle}{Development triangle.}
#' }
#' @source "A Flexible Framework for Stochastic Reserving Models" found at
#' \url{https://variancejournal.org/article/120823}
"table_1_triangle"

#' RAA Incremental Claims Triangle
#'
#' Incremental claims data from the Reinsurance Association of America (RAA),
#' converted from the cumulative triangle in the ChainLadder package. This is
#' a classic 10x10 development triangle commonly used in actuarial reserving
#' literature.
#'
#' The data represents historical general liability claims from 1981-1990 with
#' 10 development periods. Values are in thousands of dollars.
#'
#' @format A 10 x 10 numeric matrix with:
#' \describe{
#'   \item{rows}{Accident years 1981-1990}
#'   \item{columns}{Development periods 1-10}
#'   \item{values}{Incremental paid claims (thousands of dollars)}
#' }
#'
#' @note This data was converted from cumulative to incremental format.
#'   Negative values (e.g., in 1982, period 7) represent payment recoveries
#'   or adjustments.
#'
#' @source Originally from the Reinsurance Association of America.
#'   Obtained from the ChainLadder R package (Gesmann et al., 2025).
#'   \url{https://mages.github.io/ChainLadder/}
#'
#' @references
#' Gesmann M, Murphy D, Zhang Y, Carrato A, Wuthrich M, Concina F, Dal Moro E
#' (2025). ChainLadder: Statistical Methods and Models for Claims Reserving
#' in General Insurance. R package version 0.2.20.
#'
#' @seealso \code{\link{RAA_cumulative}} for the cumulative version
#'
#' @examples
#' data(RAA_incremental)
#' # View the triangle
#' print(RAA_incremental)
#'
#' # Convert back to cumulative
#' RAA_cum <- t(apply(RAA_incremental, 1, cumsum))
"RAA_incremental"

#' RAA Cumulative Claims Triangle
#'
#' Cumulative claims data from the Reinsurance Association of America (RAA),
#' obtained from the ChainLadder package. This is a classic 10x10 development
#' triangle commonly used in actuarial reserving literature.
#'
#' The data represents historical general liability claims from 1981-1990 with
#' 10 development periods. Values are in thousands of dollars.
#'
#' @format A 10 x 10 numeric matrix with:
#' \describe{
#'   \item{rows}{Accident years 1981-1990}
#'   \item{columns}{Development periods 1-10}
#'   \item{values}{Cumulative paid claims (thousands of dollars)}
#' }
#'
#' @source Originally from the Reinsurance Association of America.
#'   Obtained from the ChainLadder R package (Gesmann et al., 2025).
#'   \url{https://mages.github.io/ChainLadder/}
#'
#' @references
#' Gesmann M, Murphy D, Zhang Y, Carrato A, Wuthrich M, Concina F, Dal Moro E
#' (2025). ChainLadder: Statistical Methods and Models for Claims Reserving
#' in General Insurance. R package version 0.2.20.
#'
#' @seealso \code{\link{RAA_incremental}} for the incremental version
#'
#' @examples
#' data(RAA_cumulative)
#' # View the triangle
#' print(RAA_cumulative)
#'
#' # Convert to incremental
#' RAA_incr <- cbind(RAA_cumulative[,1],
#'                   t(apply(RAA_cumulative, 1, diff)))
"RAA_cumulative"
