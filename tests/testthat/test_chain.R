
test_that("chain returns a list with correct components", {
  B0 <- stochasticreserver::B0
  size <- nrow(B0)
  rowNum <- row(B0)
  colNum <- col(B0)
  upper_triangle_mask <- (size - rowNum) >= colNum - 1
  msd <- (size - rowNum) == colNum - 1
  paid_to_date <- rowSums(B0 * msd, na.rm = TRUE)

  result <- chain(B0, paid_to_date, upper_triangle_mask)

  expect_type(result, "list")
  expect_named(result, c("g_obj", "g_grad", "g_hess", "a0"))
  expect_type(result$g_obj, "closure")
  expect_type(result$g_grad, "closure")
  expect_type(result$g_hess, "closure")
  expect_type(result$a0, "double")
})

test_that("chain g_obj returns correct dimensions for vector input", {
  B0 <- stochasticreserver::B0
  size <- nrow(B0)
  rowNum <- row(B0)
  colNum <- col(B0)
  upper_triangle_mask <- (size - rowNum) >= colNum - 1
  msd <- (size - rowNum) == colNum - 1
  paid_to_date <- rowSums(B0 * msd, na.rm = TRUE)

  result <- chain(B0, paid_to_date, upper_triangle_mask)
  g_result <- result$g_obj(result$a0)

  expect_equal(dim(g_result), c(size, size))
  expect_true(all(is.finite(g_result)))
})

test_that("chain g_obj returns correct dimensions for matrix input", {
  B0 <- stochasticreserver::B0
  size <- nrow(B0)
  rowNum <- row(B0)
  colNum <- col(B0)
  upper_triangle_mask <- (size - rowNum) >= colNum - 1
  msd <- (size - rowNum) == colNum - 1
  paid_to_date <- rowSums(B0 * msd, na.rm = TRUE)

  result <- chain(B0, paid_to_date, upper_triangle_mask)
  theta_matrix <- rbind(result$a0, result$a0 * 0.9)
  g_result <- result$g_obj(theta_matrix)

  expect_equal(dim(g_result), c(2, size, size))
})

test_that("chain g_grad returns correct dimensions", {
  B0 <- stochasticreserver::B0
  size <- nrow(B0)
  rowNum <- row(B0)
  colNum <- col(B0)
  upper_triangle_mask <- (size - rowNum) >= colNum - 1
  msd <- (size - rowNum) == colNum - 1
  paid_to_date <- rowSums(B0 * msd, na.rm = TRUE)

  result <- chain(B0, paid_to_date, upper_triangle_mask)
  npar <- length(result$a0)
  grad_result <- result$g_grad(result$a0)

  expect_equal(dim(grad_result), c(npar, size, size))
})

test_that("chain g_grad throws error for wrong theta length", {
  B0 <- stochasticreserver::B0
  size <- nrow(B0)
  rowNum <- row(B0)
  colNum <- col(B0)
  upper_triangle_mask <- (size - rowNum) >= colNum - 1
  msd <- (size - rowNum) == colNum - 1
  paid_to_date <- rowSums(B0 * msd, na.rm = TRUE)

  result <- chain(B0, paid_to_date, upper_triangle_mask)
  wrong_theta <- c(result$a0, 0.1)

  expect_error(result$g_grad(wrong_theta),
               "theta is not equal to \\(size - 1\\)")
})

test_that("chain g_hess returns correct dimensions", {
  B0 <- stochasticreserver::B0
  size <- nrow(B0)
  rowNum <- row(B0)
  colNum <- col(B0)
  upper_triangle_mask <- (size - rowNum) >= colNum - 1
  msd <- (size - rowNum) == colNum - 1
  paid_to_date <- rowSums(B0 * msd, na.rm = TRUE)

  result <- chain(B0, paid_to_date, upper_triangle_mask)
  npar <- length(result$a0)
  hess_result <- result$g_hess(result$a0)

  expect_equal(dim(hess_result), c(npar, npar, size, size))
})

test_that("chain g_hess throws error for wrong theta length", {
  B0 <- stochasticreserver::B0
  size <- nrow(B0)
  rowNum <- row(B0)
  colNum <- col(B0)
  upper_triangle_mask <- (size - rowNum) >= colNum - 1
  msd <- (size - rowNum) == colNum - 1
  paid_to_date <- rowSums(B0 * msd, na.rm = TRUE)

  result <- chain(B0, paid_to_date, upper_triangle_mask)
  wrong_theta <- c(result$a0, 0.1)

  expect_error(result$g_hess(wrong_theta),
               "theta is not equal to \\(size - 1\\)")
})

test_that("chain a0 has correct length", {
  B0 <- stochasticreserver::B0
  size <- nrow(B0)
  rowNum <- row(B0)
  colNum <- col(B0)
  upper_triangle_mask <- (size - rowNum) >= colNum - 1
  msd <- (size - rowNum) == colNum - 1
  paid_to_date <- rowSums(B0 * msd, na.rm = TRUE)


  result <- chain(B0, paid_to_date, upper_triangle_mask)
  expect_equal(length(result$a0), size - 1)
})

test_that("chain a0 values sum close to 1", {
  B0 <- stochasticreserver::B0
  size <- nrow(B0)
  rowNum <- row(B0)
  colNum <- col(B0)
  upper_triangle_mask <- (size - rowNum) >= colNum - 1
  msd <- (size - rowNum) == colNum - 1
  paid_to_date <- rowSums(B0 * msd, na.rm = TRUE)

  result <- chain(B0, paid_to_date, upper_triangle_mask)
  expect_true(sum(result$a0) < 1)
  expect_true(sum(result$a0) > 0)
})
