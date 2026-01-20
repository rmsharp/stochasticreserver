
test_that("model_description returns correct description for Berquist", {
  result <- model_description("Berquist")
  expect_equal(result, "Berquist-Sherman Incremental Severity")
})

test_that("model_description returns correct description for CapeCod", {
  result <- model_description("CapeCod")
  expect_equal(result, "Cape Cod")
})

test_that("model_description returns correct description for Hoerl", {
  result <- model_description("Hoerl")
  expect_equal(result, "Generalized Hoerl Curve Model with Trend")
})

test_that("model_description returns correct description for Wright", {
  result <- model_description("Wright")
  expect_equal(result, "Generalized Hoerl Curve with Individual Accident Year Levels")
})

test_that("model_description returns NULL for unknown model", {
  result <- model_description("Unknown")
  expect_null(result)
})

test_that("model_description returns character type", {
  result <- model_description("Berquist")
  expect_type(result, "character")
})
