
test_that("make_negative_log_likelihood returns a numeric value", {
  B0 <- stochasticreserver::B0
  A0 <- stochasticreserver::A0
  dnom <- stochasticreserver::dnom
  size <- nrow(B0)
  rowNum <- row(B0)
  colNum <- col(B0)
  upper_triangle_mask <- (size - rowNum) >= colNum - 1
  msd <- (size - rowNum) == colNum - 1
  paid_to_date <- rowSums(B0 * msd, na.rm = TRUE)

  model_lst <- berquist(B0, paid_to_date, upper_triangle_mask)
  g_obj <- model_lst$g_obj
  a0 <- model_lst$a0
  a <- c(a0, 10, 1)

  result <- make_negative_log_likelihood(a, A0, dnom, g_obj)

  expect_type(result, "double")
  expect_length(result, 1)
  expect_true(is.finite(result))
})

test_that("make_negative_log_likelihood returns positive value", {
  B0 <- stochasticreserver::B0
  A0 <- stochasticreserver::A0
  dnom <- stochasticreserver::dnom
  size <- nrow(B0)
  rowNum <- row(B0)
  colNum <- col(B0)
  upper_triangle_mask <- (size - rowNum) >= colNum - 1
  msd <- (size - rowNum) == colNum - 1
  paid_to_date <- rowSums(B0 * msd, na.rm = TRUE)

  model_lst <- berquist(B0, paid_to_date, upper_triangle_mask)
  g_obj <- model_lst$g_obj
  a0 <- model_lst$a0
  a <- c(a0, 10, 1)

  result <- make_negative_log_likelihood(a, A0, dnom, g_obj)

  expect_true(result > 0)
})

test_that("make_negative_log_likelihood works with different models", {
  B0 <- stochasticreserver::B0
  A0 <- stochasticreserver::A0
  dnom <- stochasticreserver::dnom
  size <- nrow(B0)
  rowNum <- row(B0)
  colNum <- col(B0)
  upper_triangle_mask <- (size - rowNum) >= colNum - 1
  msd <- (size - rowNum) == colNum - 1
  paid_to_date <- rowSums(B0 * msd, na.rm = TRUE)

  model_lst <- hoerl(B0, paid_to_date, upper_triangle_mask)
  g_obj <- model_lst$g_obj
  a0 <- model_lst$a0
  a <- c(a0, 10, 1)

  result <- make_negative_log_likelihood(a, A0, dnom, g_obj)

  expect_type(result, "double")
  expect_true(is.finite(result))
})
