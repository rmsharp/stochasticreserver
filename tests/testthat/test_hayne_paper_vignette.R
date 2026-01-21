# Tests for the Hayne paper reproduction vignette
# RED PHASE: These tests define requirements before implementation

vignette_path <- "../../vignettes/hayne_paper_reproduction.qmd"

test_that("hayne_paper_reproduction.qmd vignette exists", {
  expect_true(file.exists(vignette_path))
})

test_that("vignette has correct Quarto YAML header", {
  skip_if_not(file.exists(vignette_path))
  content <- readLines(vignette_path)

  # Check for Quarto format

  expect_true(any(grepl("^---$", content)))
  expect_true(any(grepl("format:", content)))
  expect_true(any(grepl("title:", content)))
})

test_that("vignette contains theoretical framework section", {
  skip_if_not(file.exists(vignette_path))
  content <- paste(readLines(vignette_path), collapse = "\n")

  # Must have theoretical framework
  expect_true(grepl("(?i)theoretical framework|framework", content))
  expect_true(grepl("(?i)likelihood", content))
  expect_true(grepl("(?i)maximum likelihood", content))
})

test_that("vignette contains all five model sections", {
  skip_if_not(file.exists(vignette_path))
  content <- paste(readLines(vignette_path), collapse = "\n")


  # All five models must be documented
  expect_true(grepl("(?i)chain ladder", content))
  expect_true(grepl("(?i)cape cod", content))
  expect_true(grepl("(?i)berquist|berquist-sherman", content))
  expect_true(grepl("(?i)hoerl", content))
  expect_true(grepl("(?i)wright", content))
})

test_that("vignette contains mathematical equations", {
  skip_if_not(file.exists(vignette_path))
  content <- paste(readLines(vignette_path), collapse = "\n")

  # Must have LaTeX math (either $...$ or $$...$$)
  expect_true(grepl("\\$", content))

  # Should have key equations
  expect_true(grepl("g_", content, fixed = TRUE))   # Expected value function
  expect_true(grepl("sigma", content, ignore.case = TRUE))  # Variance
  expect_true(grepl("theta", content, ignore.case = TRUE))  # Parameters
})

test_that("vignette contains gradient and hessian discussion", {
  skip_if_not(file.exists(vignette_path))
  content <- paste(readLines(vignette_path), collapse = "\n")

  expect_true(grepl("(?i)gradient", content))
  expect_true(grepl("(?i)hessian", content))
  expect_true(grepl("(?i)fisher information", content))
})

test_that("vignette uses package data from Hayne paper", {
  skip_if_not(file.exists(vignette_path))
  content <- paste(readLines(vignette_path), collapse = "\n")

  # Must reference package data
  expect_true(grepl("B0|table_1_triangle", content))
  expect_true(grepl("dnom", content))
})

test_that("vignette contains tables reproducing paper results", {
  skip_if_not(file.exists(vignette_path))
  content <- paste(readLines(vignette_path), collapse = "\n")

  # Should have table formatting (markdown tables or kable)
  expect_true(grepl("\\|.*\\|.*\\||kable|knitr::kable", content))

  # Should reference specific tables from paper
  expect_true(grepl("(?i)table|parameter estimate|reserve", content))
})

test_that("vignette contains figures", {
  skip_if_not(file.exists(vignette_path))
  content <- paste(readLines(vignette_path), collapse = "\n")

  # Must have R code chunks that produce plots
  expect_true(grepl("```\\{r", content))
  expect_true(grepl("(?i)plot|ggplot|barplot|hist|fig", content))
})

test_that("vignette contains model comparison section", {
  skip_if_not(file.exists(vignette_path))
  content <- paste(readLines(vignette_path), collapse = "\n")

  expect_true(grepl("(?i)comparison|compare|AIC|BIC", content))
})

test_that("vignette contains simulation/uncertainty section", {
  skip_if_not(file.exists(vignette_path))
  content <- paste(readLines(vignette_path), collapse = "\n")

  expect_true(grepl("(?i)simulation|monte carlo|uncertainty", content))
  expect_true(grepl("(?i)confidence|interval|standard error", content))
})

test_that("vignette references original paper", {
  skip_if_not(file.exists(vignette_path))
  content <- paste(readLines(vignette_path), collapse = "\n")

  expect_true(grepl("(?i)hayne", content))
  expect_true(grepl("(?i)variance.*journal|variancejournal", content))
})
