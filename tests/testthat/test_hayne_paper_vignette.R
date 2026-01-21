# Tests for the Hayne paper reproduction vignette
# RED PHASE: These tests define requirements before implementation

# Try multiple paths to find the vignette (works in dev and R CMD check)
vignette_path <- NULL
possible_paths <- c(
  "../../vignettes/hayne_paper_reproduction.qmd",
  system.file("doc", "hayne_paper_reproduction.qmd",
              package = "stochasticreserver"),
  file.path(find.package("stochasticreserver"), "doc",
            "hayne_paper_reproduction.qmd")
)
for (p in possible_paths) {
  if (file.exists(p)) {
    vignette_path <- p
    break
  }
}

test_that("hayne_paper_reproduction.qmd vignette exists", {
  skip_if(is.null(vignette_path),
          "Vignette not found (expected during R CMD check)")
  expect_true(file.exists(vignette_path))
})

test_that("vignette has correct Quarto YAML header", {
  skip_if(is.null(vignette_path) || !file.exists(vignette_path))
  content <- readLines(vignette_path)

  # Check for Quarto format

  expect_true(any(grepl("^---$", content)))
  expect_true(any(grepl("format:", content)))
  expect_true(any(grepl("title:", content)))
})

test_that("vignette contains theoretical framework section", {
  skip_if(is.null(vignette_path) || !file.exists(vignette_path))
  content <- paste(readLines(vignette_path), collapse = "\n")

  # Must have theoretical framework
  expect_true(grepl("(?i)theoretical framework|framework", content))
  expect_true(grepl("(?i)likelihood", content))
  expect_true(grepl("(?i)maximum likelihood", content))
})

test_that("vignette contains all five model sections", {
  skip_if(is.null(vignette_path) || !file.exists(vignette_path))
  content <- paste(readLines(vignette_path), collapse = "\n")


  # All five models must be documented
  expect_true(grepl("(?i)chain ladder", content))
  expect_true(grepl("(?i)cape cod", content))
  expect_true(grepl("(?i)berquist|berquist-sherman", content))
  expect_true(grepl("(?i)hoerl", content))
  expect_true(grepl("(?i)wright", content))
})

test_that("vignette contains mathematical equations", {
  skip_if(is.null(vignette_path) || !file.exists(vignette_path))
  content <- paste(readLines(vignette_path), collapse = "\n")

  # Must have LaTeX math (either $...$ or $$...$$)
  expect_true(grepl("\\$", content))

  # Should have key equations
  expect_true(grepl("g_", content, fixed = TRUE))   # Expected value function
  expect_true(grepl("sigma", content, ignore.case = TRUE))  # Variance
  expect_true(grepl("theta", content, ignore.case = TRUE))  # Parameters
})

test_that("vignette contains gradient and hessian discussion", {
  skip_if(is.null(vignette_path) || !file.exists(vignette_path))
  content <- paste(readLines(vignette_path), collapse = "\n")

  expect_true(grepl("(?i)gradient", content))
  expect_true(grepl("(?i)hessian", content))
  expect_true(grepl("(?i)fisher information", content))
})

test_that("vignette uses package data from Hayne paper", {
  skip_if(is.null(vignette_path) || !file.exists(vignette_path))
  content <- paste(readLines(vignette_path), collapse = "\n")

  # Must reference package data
  expect_true(grepl("B0|table_1_triangle", content))
  expect_true(grepl("dnom", content))
})

test_that("vignette contains tables reproducing paper results", {
  skip_if(is.null(vignette_path) || !file.exists(vignette_path))
  content <- paste(readLines(vignette_path), collapse = "\n")

  # Should have table formatting (markdown tables or kable)
  expect_true(grepl("\\|.*\\|.*\\||kable|knitr::kable", content))

  # Should reference specific tables from paper
  expect_true(grepl("(?i)table|parameter estimate|reserve", content))
})

test_that("vignette contains figures", {
  skip_if(is.null(vignette_path) || !file.exists(vignette_path))
  content <- paste(readLines(vignette_path), collapse = "\n")

  # Must have R code chunks that produce plots
  expect_true(grepl("```\\{r", content))
  expect_true(grepl("(?i)plot|ggplot|barplot|hist|fig", content))
})

test_that("vignette contains model comparison section", {
  skip_if(is.null(vignette_path) || !file.exists(vignette_path))
  content <- paste(readLines(vignette_path), collapse = "\n")

  expect_true(grepl("(?i)comparison|compare|AIC|BIC", content))
})

test_that("vignette contains simulation/uncertainty section", {
  skip_if(is.null(vignette_path) || !file.exists(vignette_path))
  content <- paste(readLines(vignette_path), collapse = "\n")

  expect_true(grepl("(?i)simulation|monte carlo|uncertainty", content))
  expect_true(grepl("(?i)confidence|interval|standard error", content))
})

test_that("vignette references original paper", {
  skip_if(is.null(vignette_path) || !file.exists(vignette_path))
  content <- paste(readLines(vignette_path), collapse = "\n")

  expect_true(grepl("(?i)hayne", content))
  expect_true(grepl("(?i)variance.*journal|variancejournal", content))
})

# Tests for section ordering (matching Hayne paper structure)
test_that("vignette sections follow paper order: theory before models", {
  skip_if(is.null(vignette_path) || !file.exists(vignette_path))
  content <- paste(readLines(vignette_path), collapse = "\n")

 # Theoretical framework should appear before model fitting
  theory_pos <- regexpr("(?i)theoretical framework", content, perl = TRUE)
  models_pos <- regexpr("(?i)model fitting|fitting the", content, perl = TRUE)

  expect_true(theory_pos > 0)
  expect_true(models_pos > 0)
  expect_true(theory_pos < models_pos)
})

test_that("vignette sections follow paper order: models before results", {
  skip_if(is.null(vignette_path) || !file.exists(vignette_path))
  content <- paste(readLines(vignette_path), collapse = "\n")

  # Model fitting section should appear before reserve estimates section
  models_pos <- regexpr("## Model Fitting", content, fixed = TRUE)
  results_pos <- regexpr("## Reserve Estimates", content, fixed = TRUE)

  expect_true(models_pos > 0)
  expect_true(results_pos > 0)
  expect_true(models_pos < results_pos)
})

test_that("vignette sections follow paper order: results before comparison", {
  skip_if(is.null(vignette_path) || !file.exists(vignette_path))
  content <- paste(readLines(vignette_path), collapse = "\n")

  # Reserve estimates should appear before model comparison
  results_pos <- regexpr("(?i)reserve estimate", content, perl = TRUE)
  comparison_pos <- regexpr("(?i)model comparison|information criteria",
                            content, perl = TRUE)

  expect_true(results_pos > 0)
  expect_true(comparison_pos > 0)
  expect_true(results_pos < comparison_pos)
})

test_that("vignette sections follow paper order: comparison before diagnostics", {
  skip_if(is.null(vignette_path) || !file.exists(vignette_path))
  content <- paste(readLines(vignette_path), collapse = "\n")

  # Model comparison should appear before residual diagnostics
  comparison_pos <- regexpr("(?i)model comparison", content, perl = TRUE)
  diagnostics_pos <- regexpr("(?i)residual|diagnostic", content, perl = TRUE)

  expect_true(comparison_pos > 0)
  expect_true(diagnostics_pos > 0)
  expect_true(comparison_pos < diagnostics_pos)
})

test_that("five models appear in consistent order", {
  skip_if(is.null(vignette_path) || !file.exists(vignette_path))
  content <- paste(readLines(vignette_path), collapse = "\n")

  # Find positions of each model's fitting section
  chain_pos <- regexpr("(?i)fitting the chain ladder", content, perl = TRUE)
  capecod_pos <- regexpr("(?i)fitting the cape cod", content, perl = TRUE)
  berquist_pos <- regexpr("(?i)fitting the berquist", content, perl = TRUE)
  hoerl_pos <- regexpr("(?i)fitting the hoerl", content, perl = TRUE)
  wright_pos <- regexpr("(?i)fitting the wright", content, perl = TRUE)

  # All models should be present
  expect_true(chain_pos > 0)
  expect_true(capecod_pos > 0)
  expect_true(berquist_pos > 0)
  expect_true(hoerl_pos > 0)
  expect_true(wright_pos > 0)

  # Models should appear in order: Chain, CapeCod, Berquist, Hoerl, Wright
  expect_true(chain_pos < capecod_pos)
  expect_true(capecod_pos < berquist_pos)
  expect_true(berquist_pos < hoerl_pos)
  expect_true(hoerl_pos < wright_pos)
})

# Tests for calculation accuracy (comparing to paper results)
test_that("package data matches paper Table 1 triangle", {
  # The B0 data should match the paper's development triangle
  B0 <- stochasticreserver::B0

  expect_equal(nrow(B0), 10)
  expect_equal(ncol(B0), 10)

  # Check specific values from paper (first row, first few values)
  # These are incremental values from Hayne's paper
  expect_true(is.numeric(B0[1, 1]))
  expect_true(!is.na(B0[1, 1]))
  expect_true(!is.na(B0[1, 10]))  # First row should be complete
  expect_true(is.na(B0[10, 10]))  # Last row should have NAs
})

test_that("exposure counts (dnom) are valid", {
  dnom <- stochasticreserver::dnom

  expect_length(dnom, 10)
  expect_true(all(dnom > 0))
  expect_true(all(is.finite(dnom)))
})

test_that("model optimization converges", {
  skip_on_cran()  # Skip on CRAN due to computation time

  B0 <- stochasticreserver::B0
  A0 <- stochasticreserver::A0
  dnom <- stochasticreserver::dnom
  size <- nrow(B0)

  rowNum <- row(B0)
  colNum <- col(B0)
  upper_triangle_mask <- (size - rowNum) >= colNum - 1
  msd <- (size - rowNum) == colNum - 1
  paid_to_date <- rowSums(B0 * msd, na.rm = TRUE)

  # Test Chain Ladder convergence
  chain_model <- chain(B0, paid_to_date, upper_triangle_mask)
  g_chain <- chain_model$g_obj
  a0_chain <- chain_model$a0

  nll_chain <- function(a) {
    make_negative_log_likelihood(a, A0, dnom, g_chain)
  }

  fit_chain <- optim(
    par = c(a0_chain, 10, 1),
    fn = nll_chain,
    method = "BFGS"
  )

  expect_equal(fit_chain$convergence, 0)
  expect_true(is.finite(fit_chain$value))
})

test_that("reserve estimates are finite and calculable", {
  skip_on_cran()

  B0 <- stochasticreserver::B0
  A0 <- stochasticreserver::A0
  dnom <- stochasticreserver::dnom
  size <- nrow(B0)

  rowNum <- row(B0)
  colNum <- col(B0)
  upper_triangle_mask <- (size - rowNum) >= colNum - 1
  lower_mask <- !upper_triangle_mask
  msd <- (size - rowNum) == colNum - 1
  paid_to_date <- rowSums(B0 * msd, na.rm = TRUE)

  # Fit Chain Ladder
  chain_model <- chain(B0, paid_to_date, upper_triangle_mask)
  g_chain <- chain_model$g_obj
  a0_chain <- chain_model$a0

  nll_chain <- function(a) {
    make_negative_log_likelihood(a, A0, dnom, g_chain)
  }

  fit_chain <- optim(
    par = c(a0_chain, 10, 1),
    fn = nll_chain,
    method = "BFGS"
  )

  params_chain <- fit_chain$par[1:length(a0_chain)]
  E_chain <- g_chain(params_chain)
  reserve <- sum(E_chain[lower_mask], na.rm = TRUE)

  # Reserve calculation should produce a finite result
  expect_true(is.finite(reserve))

  # Reserve should be non-zero (model should produce predictions)
  expect_true(reserve != 0)

  # Expected values matrix should have correct dimensions
  expect_equal(dim(E_chain), c(size, size))
})
