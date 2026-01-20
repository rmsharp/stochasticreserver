
test_that("make_gradient_of_objective returns correct length vector", {
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
  g_grad <- model_lst$g_grad
  a0 <- model_lst$a0
  a <- c(a0, 10, 1)

  result <- make_gradient_of_objective(a, A0, dnom, g_obj, g_grad)

  expect_type(result, "double")
  expect_length(result, length(a))
})

test_that("make_gradient_of_objective returns finite values", {
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
  g_grad <- model_lst$g_grad
  a0 <- model_lst$a0
  a <- c(a0, 10, 1)

  result <- make_gradient_of_objective(a, A0, dnom, g_obj, g_grad)

  expect_true(all(is.finite(result)))
})

test_that("make_gradient_of_objective works with hoerl model", {
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
  g_grad <- model_lst$g_grad
  a0 <- model_lst$a0
  a <- c(a0, 10, 1)

  result <- make_gradient_of_objective(a, A0, dnom, g_obj, g_grad)

  expect_type(result, "double")
  expect_length(result, length(a))
})

test_that("make_gradient_of_objective works with wright model", {
  B0 <- stochasticreserver::B0
  A0 <- stochasticreserver::A0
  dnom <- stochasticreserver::dnom
  size <- nrow(B0)
  rowNum <- row(B0)
  colNum <- col(B0)
  upper_triangle_mask <- (size - rowNum) >= colNum - 1
  msd <- (size - rowNum) == colNum - 1
  paid_to_date <- rowSums(B0 * msd, na.rm = TRUE)

  model_lst <- wright(B0, paid_to_date, upper_triangle_mask)
  g_obj <- model_lst$g_obj
  g_grad <- model_lst$g_grad
  a0 <- model_lst$a0
  a <- c(a0, 10, 1)

  result <- make_gradient_of_objective(a, A0, dnom, g_obj, g_grad)

  expect_type(result, "double")
  expect_length(result, length(a))
})
