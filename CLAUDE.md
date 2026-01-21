# stochasticreserver

## Project Overview

**stochasticreserver** is an R package providing a flexible framework
for stochastic reserving models used in actuarial loss reserving. The
package implements maximum likelihood estimators for five common
reserving methods, allowing direct handling of non-linear models without
transformation.

Based on Roger Hayne’s paper “A Flexible Framework for Stochastic
Reserving Models” published in *Variance* journal.

### The Five Reserving Methods

| Method           | Description                                            |
|------------------|--------------------------------------------------------|
| Chain Ladder     | Development proportions with row/column constraints    |
| Cape Cod         | Bornhuetter-Ferguson variant with exposure weighting   |
| Berquist-Sherman | Incremental severity method with trend parameter       |
| Hoerl Curve      | Smooth curve with shared operational time parameters   |
| Wright           | Generalized Hoerl with individual accident year levels |

### Key Features

- Unified maximum likelihood estimation framework
- Fisher information matrix for uncertainty quantification
- Gradient and Hessian functions for optimization
- Support for Monte Carlo simulation

## Repository Structure

    stochasticreserver/
    ├── R/                          # Package source code
    │   ├── berquist.R              # Berquist-Sherman model
    │   ├── capecod.R               # Cape Cod model
    │   ├── chain.R                 # Chain Ladder model
    │   ├── hoerl.R                 # Hoerl curve model
    │   ├── wright.R                # Wright model
    │   ├── make_negative_log_likelihood.R
    │   ├── make_gradient_of_objective.R
    │   ├── make_log_hessian.R
    │   ├── get_incremental_avg_matrix.R
    │   ├── model_description.R
    │   └── data.R                  # Package data documentation
    ├── tests/testthat/             # Unit tests (93 tests, 98%+ coverage)
    ├── vignettes/                  # Package vignettes
    │   └── comprehensive_tutorial.Rmd
    ├── inst/extdata/               # External data and presentations
    │   └── presentations/
    ├── man/                        # Generated documentation
    ├── data/                       # Package datasets (B0, A0, dnom)
    ├── .github/workflows/          # CI/CD workflows
    │   ├── R-CMD-check.yaml
    │   ├── R-CMD-check-scheduled.yaml
    │   ├── test-coverage.yaml
    │   ├── pkgdown.yaml
    │   └── lint.yaml
    ├── DESCRIPTION                 # Package metadata
    ├── NAMESPACE                   # Export declarations
    ├── LICENSE                     # MIT License
    └── README.md                   # Package documentation

------------------------------------------------------------------------

## Development Process Contract

This project uses **Strict Test-Driven Development (TDD)**. Deviation is
a defect.

### TDD Rules:

- Write tests before implementation code
- Each feature branch should include tests
- Ensure both happy paths and all non-happy paths are tested
- Ensure potential edge cases are tested
- Maintain \>80% code coverage for new code
- Run full test suite before merging
- Tests should be fast, isolated, and deterministic

### TDD Phases

#### RED

- Write tests only
- Tests must fail
- No implementation code
- No production logic
- No refactoring

#### GREEN

- Write the minimum implementation required to pass tests
- No new functionality
- No refactoring
- No optimization

#### REFACTOR

- Improve structure and readability
- No behavior changes
- All tests must remain passing

### Enforcement Rules

- The assistant MUST declare the current phase at the top of every
  response.
- The assistant MUST refuse requests that violate the current phase.
- The assistant MUST ask permission before transitioning between phases.
- Skipping phases is forbidden.
- Writing implementation code during RED is a violation.
- Ensure potential edge cases are tested
- Maintain \>80% code coverage for new code
- Run full test suite before merging
- Tests must be fast, isolated, and deterministic

### Error Handling

If a response violates TDD: 1. The assistant must acknowledge the
violation. 2. The assistant must correct itself. 3. The assistant must
reissue a compliant response.

This file supersedes general coding instincts.
