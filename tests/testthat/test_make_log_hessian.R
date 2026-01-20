
test_that("make_log_hessian returns correct dimension matrix", {
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
  g_hess <- model_lst$g_hess
  a0 <- model_lst$a0
  a <- c(a0, 10, 1)

  result <- make_log_hessian(a, A0, dnom, g_obj, g_grad, g_hess)

  expect_type(result, "double")
  expect_equal(dim(result), c(length(a), length(a)))
})

test_that("make_log_hessian returns symmetric matrix", {
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
  g_hess <- model_lst$g_hess
  a0 <- model_lst$a0
  a <- c(a0, 10, 1)

  result <- make_log_hessian(a, A0, dnom, g_obj, g_grad, g_hess)

  expect_equal(
    as.vector(result),
    as.vector(t(result)),
    tolerance = 1e-10
  )
})

test_that("make_log_hessian returns finite values", {
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
  g_hess <- model_lst$g_hess
  a0 <- model_lst$a0
  a <- c(a0, 10, 1)

  result <- make_log_hessian(a, A0, dnom, g_obj, g_grad, g_hess)

  expect_true(all(is.finite(result)))
})

test_that("make_log_hessian works with hoerl model", {
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
  g_hess <- model_lst$g_hess
  a0 <- model_lst$a0
  a <- c(a0, 10, 1)

  result <- make_log_hessian(a, A0, dnom, g_obj, g_grad, g_hess)

  expect_equal(dim(result), c(length(a), length(a)))
})

test_that("make_log_hessian works with wright model", {
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
  g_hess <- model_lst$g_hess
  a0 <- model_lst$a0
  a <- c(a0, 10, 1)

  result <- make_log_hessian(a, A0, dnom, g_obj, g_grad, g_hess)

  expect_equal(dim(result), c(length(a), length(a)))
})

test_that("make_log_hessian works with chain model", {
  B0 <- stochasticreserver::B0
  A0 <- stochasticreserver::A0
  dnom <- stochasticreserver::dnom
  size <- nrow(B0)
  rowNum <- row(B0)
  colNum <- col(B0)
  upper_triangle_mask <- (size - rowNum) >= colNum - 1
  msd <- (size - rowNum) == colNum - 1
  paid_to_date <- rowSums(B0 * msd, na.rm = TRUE)

  model_lst <- chain(B0, paid_to_date, upper_triangle_mask)
  g_obj <- model_lst$g_obj
  g_grad <- model_lst$g_grad
  g_hess <- model_lst$g_hess
  a0 <- model_lst$a0
  a <- c(a0, 10, 1)

  result <- make_log_hessian(a, A0, dnom, g_obj, g_grad, g_hess)

  expect_equal(dim(result), c(length(a), length(a)))
})
