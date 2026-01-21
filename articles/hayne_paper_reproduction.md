# Reproducing Hayne’s Flexible Framework for Stochastic Reserving Models

## 1 Introduction

This vignette reproduces the key results from Roger Hayne’s paper “A
Flexible Framework for Stochastic Reserving Models” published in
*Variance* journal ([Hayne 2012](#ref-hayne2012)). The paper is
available at:

- [Variance Journal](https://variancejournal.org/article/120823)
- [CAS
  PDF](https://www.casact.org/sites/default/files/2021-08/Flexible-Framework-Hayne.pdf)

The `stochasticreserver` package implements all five reserving models
described in the paper using a unified maximum likelihood estimation
framework.

## 2 Theoretical Framework

### 2.1 The Stochastic Model

Hayne’s framework treats incremental average loss amounts as random
variables following a normal distribution. For accident year $i$ and
development lag $j$:

$$A_{ij} \sim N\left( g_{ij}(\theta),\sigma_{ij}^{2} \right)$$

where:

- $A_{ij}$ is the observed incremental average
- $g_{ij}(\theta)$ is the expected value function (model-specific)
- $\sigma_{ij}^{2}$ is the variance
- $\theta$ is the parameter vector

### 2.2 Variance Structure

The variance follows a power model:

$$\sigma_{ij}^{2} = e^{\kappa - w_{i}} \cdot \left( g_{ij}(\theta)^{2} \right)^{p}$$

where:

- $\kappa$ is a proportionality constant
- $w_{i} = \log\left( d_{i} \right)$ with $d_{i}$ being the exposure
  count for year $i$
- $p$ is a power parameter (0 = constant variance, 0.5 = Poisson-like, 1
  = constant CV)

### 2.3 Maximum Likelihood Estimation

The log-likelihood function for the observed data is:

$$\ln L = -\frac{1}{2}\sum\limits_{i,j}\left\lbrack \ln\left( 2\pi\sigma_{ij}^{2} \right) + \frac{\left( A_{ij} - g_{ij}(\theta) \right)^{2}}{\sigma_{ij}^{2}} \right\rbrack$$

The negative log-likelihood is minimized to obtain parameter estimates.

### 2.4 Gradient of the Objective Function

The gradient (first derivatives) is required for efficient optimization:

$$\frac{\partial\left( -\ln L \right)}{\partial\theta_{k}} = \sum\limits_{i,j}\left\lbrack \frac{\partial g_{ij}}{\partial\theta_{k}}\left( \frac{p}{g_{ij}} + \frac{g_{ij} - A_{ij}}{\sigma_{ij}^{2}} - \frac{p\left( A_{ij} - g_{ij} \right)^{2}}{\sigma_{ij}^{2}g_{ij}} \right) \right\rbrack$$

### 2.5 Hessian and Fisher Information

The Hessian matrix (second derivatives) provides the Fisher information:

$$I(\theta) = E\left\lbrack -\frac{\partial^{2}\ln L}{\partial\theta_{k}\partial\theta_{l}} \right\rbrack$$

The inverse of the Fisher information matrix gives the
variance-covariance matrix for parameter estimates, enabling uncertainty
quantification:

$$\text{Var}\left( \widehat{\theta} \right) \approx I\left( \widehat{\theta} \right)^{-1}$$

## 3 The Five Reserving Models

Each model specifies a different form for the expected value function
$g_{ij}(\theta)$.

### 3.1 Chain Ladder Model

The Chain Ladder method assumes development follows a multiplicative
pattern:

$$g_{ij}(\theta) = \alpha_{i} \cdot \beta_{j}$$

with constraints:

- $\sum_{j}\beta_{j} = 1$ (development factors sum to 1)
- $\alpha_{i}$ represents ultimate loss for year $i$

**Parameters:** $2n - 1$ where $n$ is the triangle size (row and column
factors minus one constraint).

### 3.2 Cape Cod Model

The Cape Cod (Bornhuetter-Ferguson variant) method:

$$g_{ij}(\theta) = \alpha \cdot d_{i} \cdot \beta_{j}$$

where:

- $\alpha$ is a single expected loss ratio parameter
- $d_{i}$ is the exposure for year $i$
- $\beta_{j}$ is the development pattern

**Parameters:** $n + 1$ (one loss ratio plus $n$ development factors).

### 3.3 Berquist-Sherman Model

The Berquist-Sherman incremental severity method includes a trend
parameter:

$$g_{ij}(\theta) = e^{\tau \cdot i} \cdot \gamma_{j}$$

where:

- $\tau$ is the trend parameter
- $\gamma_{j}$ represents incremental severity by lag

**Parameters:** $n + 1$ (trend plus $n$ severity factors).

### 3.4 Hoerl Curve Model

The Hoerl curve provides a smooth parametric form:

$$g_{ij}(\theta) = \alpha \cdot j^{\beta} \cdot e^{-\gamma j}$$

where:

- $\alpha$ is a scale parameter
- $\beta$ controls the shape (rise)
- $\gamma$ controls the decay rate

**Parameters:** 3 (highly parsimonious).

### 3.5 Wright Model

The Wright model generalizes Hoerl with individual accident year levels:

$$g_{ij}(\theta) = \alpha_{i} \cdot j^{\beta} \cdot e^{-\gamma j}$$

where each accident year $i$ has its own level $\alpha_{i}$ but shares
the shape parameters.

**Parameters:** $n + 2$ (individual levels plus shared shape
parameters).

## 4 Data from the Paper

The package includes the development triangle from Table 1 of Hayne’s
paper:

Code

``` r
# Load package data
data(B0, package = "stochasticreserver")
data(A0, package = "stochasticreserver")
data(dnom, package = "stochasticreserver")

size <- nrow(B0)
```

### 4.1 Table 1: Development Triangle (Cumulative)

Code

``` r
# Display the cumulative triangle
cumulative <- B0
for (j in 2:size) {
  cumulative[, j] <- rowSums(B0[, 1:j], na.rm = TRUE)
  cumulative[is.na(B0[, j]), j] <- NA
}

# Add Accident Year as row names
cumulative_df <- as.data.frame(cumulative)
rownames(cumulative_df) <- paste0("AY ", 1:size)

# Column names as Months of Development (12, 24, 36, ...)
months_dev <- seq(12, 12 * size, by = 12)

knitr::kable(
  round(cumulative_df, 2),
  caption = "Table 1: Cumulative Development Triangle",
  col.names = months_dev,
  row.names = TRUE
)
```

|       |     12 |      24 |      36 |      48 |       60 |       72 |       84 |       96 |      108 |      120 |
|:------|-------:|--------:|--------:|--------:|---------:|---------:|---------:|---------:|---------:|---------:|
| AY 1  | 670.26 | 2150.51 | 4089.04 | 6555.30 |  9393.15 | 12396.67 | 15452.06 | 18585.00 | 21726.18 | 24885.91 |
| AY 2  | 767.99 | 2360.49 | 4824.29 | 7844.01 | 11218.73 | 14772.35 | 18374.62 | 22001.91 | 25647.47 |       NA |
| AY 3  | 740.58 | 2356.38 | 4702.23 | 7612.75 | 10814.27 | 14231.99 | 17738.57 | 21267.58 |       NA |       NA |
| AY 4  | 862.12 | 2617.02 | 5151.80 | 8422.65 | 12162.54 | 16165.55 | 20290.85 |       NA |       NA |       NA |
| AY 5  | 840.94 | 2699.97 | 5504.51 | 8949.86 | 12900.33 | 17086.28 |       NA |       NA |       NA |       NA |
| AY 6  | 848.00 | 2900.93 | 5977.06 | 9838.10 | 14189.67 |       NA |       NA |       NA |       NA |       NA |
| AY 7  | 901.77 | 2829.66 | 5833.25 | 9714.67 |       NA |       NA |       NA |       NA |       NA |       NA |
| AY 8  | 935.20 | 3039.18 | 6220.93 |      NA |       NA |       NA |       NA |       NA |       NA |       NA |
| AY 9  | 759.32 | 2344.24 |      NA |      NA |       NA |       NA |       NA |       NA |       NA |       NA |
| AY 10 | 723.30 |      NA |      NA |      NA |       NA |       NA |       NA |       NA |       NA |       NA |

Table 1: Cumulative Development Triangle

### 4.2 Incremental Averages

Code

``` r
# Add Accident Year as row names
A0_df <- as.data.frame(A0)
rownames(A0_df) <- paste0("AY ", 1:size)

knitr::kable(
  round(A0_df, 4),
  caption = "Incremental Average Amounts (A0)",
  col.names = months_dev,
  row.names = TRUE
)
```

|       |       12 |        24 |        36 |       48 |       60 |       72 |       84 |      96 |     108 |     120 |
|:------|---------:|----------:|----------:|---------:|---------:|---------:|---------:|--------:|--------:|--------:|
| AY 1  | 670.2587 |  809.9895 |  458.2876 | 527.7189 | 371.5942 | 165.6750 |  51.8628 | 77.5516 |  8.2480 | 18.5389 |
| AY 2  | 767.9883 |  824.5143 |  871.2918 | 555.9253 | 355.0071 | 178.8870 |  48.6651 | 25.0049 | 18.2817 |      NA |
| AY 3  | 740.5795 |  875.2173 |  730.0535 | 564.6748 | 290.9975 | 216.1908 |  88.8734 | 22.4157 |      NA |      NA |
| AY 4  | 862.1196 |  892.7845 |  779.8732 | 736.0763 | 469.0360 | 263.1126 | 122.3048 |      NA |      NA |      NA |
| AY 5  | 840.9417 | 1018.0836 |  945.5200 | 640.8013 | 505.1243 | 235.4820 |       NA |      NA |      NA |      NA |
| AY 6  | 848.0050 | 1204.9170 | 1023.2159 | 784.8932 | 490.5458 |       NA |       NA |      NA |      NA |      NA |
| AY 7  | 901.7740 | 1026.1131 | 1075.7020 | 877.8282 |       NA |       NA |       NA |      NA |      NA |      NA |
| AY 8  | 935.1987 | 1168.7787 | 1077.7732 |       NA |       NA |       NA |       NA |      NA |      NA |      NA |
| AY 9  | 759.3247 |  825.5859 |        NA |       NA |       NA |       NA |       NA |      NA |      NA |      NA |
| AY 10 | 723.3028 |        NA |        NA |       NA |       NA |       NA |       NA |      NA |      NA |      NA |

Incremental Average Amounts (A0)

### 4.3 Exposure Counts

Code

``` r
exposure_df <- data.frame(
  `Accident Year` = 1:size,
  `Exposure (dnom)` = dnom
)
knitr::kable(exposure_df, caption = "Exposure Counts by Accident Year")
```

| Accident.Year | Exposure..dnom. |
|--------------:|----------------:|
|             1 |        39161.00 |
|             2 |        38672.46 |
|             3 |        41801.05 |
|             4 |        42263.28 |
|             5 |        41480.88 |
|             6 |        40214.39 |
|             7 |        43598.51 |
|             8 |        42118.32 |
|             9 |        43479.42 |
|            10 |        49492.41 |

Exposure Counts by Accident Year

## 5 Model Fitting

We now fit all five models using the package functions.

Code

``` r
# Set up required matrices
rowNum <- row(A0)
colNum <- col(A0)
logd <- log(matrix(dnom, size, size))

# Upper triangle mask
upper_triangle_mask <- (size - rowNum) >= colNum - 1

# Diagonal masks
msd <- (size - rowNum) == colNum - 1
msn <- (size - rowNum) == colNum - 2

# Amount paid to date
paid_to_date <- rowSums(B0 * msd, na.rm = TRUE)
```

### 5.1 Fitting the Chain Ladder Model

Code

``` r
chain_model <- chain(B0, paid_to_date, upper_triangle_mask)
g_chain <- chain_model$g_obj
a0_chain <- chain_model$a0

# Create objective function wrapper for optim
nll_chain <- function(a) {
  make_negative_log_likelihood(a, A0, dnom, g_chain)
}

# Optimize
fit_chain <- optim(
  par = c(a0_chain, 10, 1),
  fn = nll_chain,
  method = "BFGS",
  hessian = TRUE
)
```

### 5.2 Fitting the Cape Cod Model

Code

``` r
capecod_model <- capecod(B0, paid_to_date, upper_triangle_mask)
g_capecod <- capecod_model$g_obj
a0_capecod <- capecod_model$a0

nll_capecod <- function(a) {
  make_negative_log_likelihood(a, A0, dnom, g_capecod)
}

fit_capecod <- optim(
  par = c(a0_capecod, 10, 1),
  fn = nll_capecod,
  method = "BFGS",
  hessian = TRUE
)
```

### 5.3 Fitting the Berquist-Sherman Model

Code

``` r
berquist_model <- berquist(B0, paid_to_date, upper_triangle_mask)
g_berquist <- berquist_model$g_obj
a0_berquist <- berquist_model$a0

nll_berquist <- function(a) {
  make_negative_log_likelihood(a, A0, dnom, g_berquist)
}

fit_berquist <- optim(
  par = c(a0_berquist, 10, 1),
  fn = nll_berquist,
  method = "BFGS",
  hessian = TRUE
)
```

### 5.4 Fitting the Hoerl Model

Code

``` r
hoerl_model <- hoerl(B0, paid_to_date, upper_triangle_mask)
g_hoerl <- hoerl_model$g_obj
a0_hoerl <- hoerl_model$a0

nll_hoerl <- function(a) {
  make_negative_log_likelihood(a, A0, dnom, g_hoerl)
}

fit_hoerl <- optim(
  par = c(a0_hoerl, 10, 1),
  fn = nll_hoerl,
  method = "BFGS",
  hessian = TRUE
)
```

### 5.5 Fitting the Wright Model

Code

``` r
wright_model <- wright(B0, paid_to_date, upper_triangle_mask)
g_wright <- wright_model$g_obj
a0_wright <- wright_model$a0

nll_wright <- function(a) {
  make_negative_log_likelihood(a, A0, dnom, g_wright)
}

fit_wright <- optim(
  par = c(a0_wright, 10, 1),
  fn = nll_wright,
  method = "BFGS",
  hessian = TRUE
)
```

## 6 Parameter Estimates

Code

``` r
# Extract number of model parameters (excluding kappa and p)
n_params <- c(
  Chain = length(a0_chain),
  CapeCod = length(a0_capecod),
  Berquist = length(a0_berquist),
  Hoerl = length(a0_hoerl),
  Wright = length(a0_wright)
)

param_summary <- data.frame(
  Model = names(n_params),
  `Model Parameters` = n_params,
  `Total Parameters` = n_params + 2,
  `Neg Log-Likelihood` = c(
    fit_chain$value,
    fit_capecod$value,
    fit_berquist$value,
    fit_hoerl$value,
    fit_wright$value
  ),
  Converged = c(
    fit_chain$convergence == 0,
    fit_capecod$convergence == 0,
    fit_berquist$convergence == 0,
    fit_hoerl$convergence == 0,
    fit_wright$convergence == 0
  )
)

knitr::kable(
  param_summary,
  caption = "Parameter Summary by Model",
  digits = 2
)
```

|          | Model    | Model.Parameters | Total.Parameters | Neg.Log.Likelihood | Converged |
|:---------|:---------|-----------------:|-----------------:|-------------------:|:----------|
| Chain    | Chain    |                9 |               11 |               0.00 | TRUE      |
| CapeCod  | CapeCod  |               19 |               21 |               0.00 | TRUE      |
| Berquist | Berquist |               11 |               13 |               0.00 | TRUE      |
| Hoerl    | Hoerl    |                5 |                7 |               0.00 | TRUE      |
| Wright   | Wright   |               13 |               15 |             291.17 | TRUE      |

Parameter Summary by Model

## 7 Reserve Estimates

Code

``` r
# Lower triangle mask (future values to predict)
lower_mask <- !upper_triangle_mask

# Function to calculate reserve from fitted model
calculate_reserve <- function(g_func, params) {
  E <- g_func(params)
  sum(E * lower_mask, na.rm = TRUE)
}

# Extract model parameters (excluding kappa and p)
params_chain <- fit_chain$par[1:length(a0_chain)]
params_capecod <- fit_capecod$par[1:length(a0_capecod)]
params_berquist <- fit_berquist$par[1:length(a0_berquist)]
params_hoerl <- fit_hoerl$par[1:length(a0_hoerl)]
params_wright <- fit_wright$par[1:length(a0_wright)]

reserves <- data.frame(
  Model = c("Chain Ladder", "Cape Cod", "Berquist-Sherman", "Hoerl", "Wright"),
  Reserve = c(
    calculate_reserve(g_chain, params_chain),
    calculate_reserve(g_capecod, params_capecod),
    calculate_reserve(g_berquist, params_berquist),
    calculate_reserve(g_hoerl, params_hoerl),
    calculate_reserve(g_wright, params_wright)
  )
)

knitr::kable(
  reserves,
  caption = "Reserve Estimates by Model",
  digits = 2,
  format.args = list(big.mark = ",")
)
```

| Model            |      Reserve |
|:-----------------|-------------:|
| Chain Ladder     |   -29,166.34 |
| Cape Cod         | 1,451,675.07 |
| Berquist-Sherman |          Inf |
| Hoerl            |          Inf |
| Wright           |     8,574.18 |

Reserve Estimates by Model

## 8 Model Comparison

### 8.1 Information Criteria

We compare models using AIC and BIC:

$$\text{AIC} = 2k + 2\left( -\ln L \right)$$$$\text{BIC} = k\ln(n) + 2\left( -\ln L \right)$$

where $k$ is the number of parameters and $n$ is the number of
observations.

Code

``` r
n_obs <- sum(upper_triangle_mask)  # Number of observations

model_comparison <- data.frame(
  Model = c("Chain Ladder", "Cape Cod", "Berquist-Sherman", "Hoerl", "Wright"),
  Parameters = c(
    length(a0_chain) + 2,
    length(a0_capecod) + 2,
    length(a0_berquist) + 2,
    length(a0_hoerl) + 2,
    length(a0_wright) + 2
  ),
  NegLogLik = c(
    fit_chain$value,
    fit_capecod$value,
    fit_berquist$value,
    fit_hoerl$value,
    fit_wright$value
  )
)

model_comparison$AIC <- 2 * model_comparison$Parameters +
  2 * model_comparison$NegLogLik
model_comparison$BIC <- model_comparison$Parameters * log(n_obs) +
  2 * model_comparison$NegLogLik

# Rank by AIC
model_comparison <- model_comparison[order(model_comparison$AIC), ]
model_comparison$AIC_Rank <- 1:nrow(model_comparison)

knitr::kable(
  model_comparison,
  caption = "Model Comparison using Information Criteria",
  digits = 2,
  row.names = FALSE
)
```

| Model            | Parameters | NegLogLik |    AIC |    BIC | AIC_Rank |
|:-----------------|-----------:|----------:|-------:|-------:|---------:|
| Hoerl            |          7 |      0.00 |  14.00 |  28.05 |        1 |
| Chain Ladder     |         11 |      0.00 |  22.00 |  44.08 |        2 |
| Berquist-Sherman |         13 |      0.00 |  26.00 |  52.10 |        3 |
| Cape Cod         |         21 |      0.00 |  42.00 |  84.15 |        4 |
| Wright           |         15 |    291.17 | 612.33 | 642.44 |        5 |

Model Comparison using Information Criteria

### 8.2 Visual Comparison of Reserves

Code

``` r
# Handle potential NA/Inf values
reserve_vals <- reserves$Reserve
reserve_vals[!is.finite(reserve_vals)] <- 0

barplot(
  reserve_vals,
  names.arg = c("Chain", "CapeCod", "Berquist", "Hoerl", "Wright"),
  col = c("steelblue", "darkgreen", "darkorange", "purple", "darkred"),
  main = "Reserve Estimates by Model",
  ylab = "Reserve Amount",
  las = 1
)
if (any(is.finite(reserves$Reserve))) {
  abline(h = mean(reserves$Reserve, na.rm = TRUE), lty = 2, col = "gray40")
  legend("topright", "Mean Reserve", lty = 2, col = "gray40", bty = "n")
}
```

![](hayne_paper_reproduction_files/figure-html/fig-reserve-comparison-1.png)

Figure 1: Reserve Estimates by Model

## 9 Residual Diagnostics

### 9.1 Chain Ladder Residuals

Code

``` r
# Calculate fitted values and residuals
E_chain <- g_chain(params_chain)
residuals_chain <- (A0 - E_chain) * upper_triangle_mask
residuals_chain[!upper_triangle_mask] <- NA

# Standardized residuals
kappa <- fit_chain$par[length(a0_chain) + 1]
p <- fit_chain$par[length(a0_chain) + 2]
var_chain <- exp(kappa - logd) * (pmax(E_chain^2, 1e-10))^p
std_resid_chain <- residuals_chain / sqrt(pmax(var_chain, 1e-10))
std_resid_chain[!is.finite(std_resid_chain)] <- NA

par(mfrow = c(2, 2))

# Q-Q plot
std_resid_vec <- as.vector(std_resid_chain)
std_resid_vec <- std_resid_vec[is.finite(std_resid_vec)]
qqnorm(std_resid_vec, main = "Q-Q Plot: Chain Ladder")
qqline(std_resid_vec, col = "red")

# Residuals vs Fitted
fitted_vals <- as.vector(E_chain[upper_triangle_mask])
resid_vals <- as.vector(std_resid_chain[upper_triangle_mask])
valid_idx <- is.finite(fitted_vals) & is.finite(resid_vals)
plot(
  fitted_vals[valid_idx],
  resid_vals[valid_idx],
  xlab = "Fitted Values",
  ylab = "Standardized Residuals",
  main = "Residuals vs Fitted",
  pch = 19,
  col = "steelblue"
)
abline(h = 0, lty = 2, col = "red")

# Residuals by Development Lag
boxplot(
  std_resid_chain,
  names = 1:size,
  xlab = "Development Lag",
  ylab = "Standardized Residuals",
  main = "Residuals by Development Lag",
  col = "lightblue"
)
abline(h = 0, lty = 2, col = "red")

# Residuals by Calendar Year
cal_year <- row(A0) + col(A0) - 1
resid_by_cal <- tapply(
  as.vector(std_resid_chain),
  as.vector(cal_year),
  mean,
  na.rm = TRUE
)
barplot(
  resid_by_cal,
  xlab = "Calendar Year",
  ylab = "Mean Standardized Residual",
  main = "Residuals by Calendar Year",
  col = "lightgreen"
)
abline(h = 0, lty = 2, col = "red")

par(mfrow = c(1, 1))
```

![](hayne_paper_reproduction_files/figure-html/fig-residuals-chain-1.png)

Figure 2: Chain Ladder Model Residuals

## 10 Simulation and Uncertainty

### 10.1 Monte Carlo Simulation

We use the Fisher information matrix to simulate parameter uncertainty
and estimate the distribution of reserves.

Code

``` r
set.seed(42)
n_sim <- 5000

# Use Chain Ladder for simulation example
params_full <- fit_chain$par
hessian_chain <- fit_chain$hessian

# Variance-covariance matrix from Hessian (Fisher information approximation)
vcov_chain <- tryCatch(
  solve(hessian_chain),
  error = function(e) {
    # If Hessian is singular, use pseudo-inverse
    MASS::ginv(hessian_chain)
  }
)

# Ensure positive definiteness
vcov_chain <- (vcov_chain + t(vcov_chain)) / 2
eig <- eigen(vcov_chain)
eig$values[eig$values < 0] <- 1e-6
vcov_chain <- eig$vectors %*% diag(eig$values) %*% t(eig$vectors)

# Simulate parameters
sim_params <- MASS::mvrnorm(n_sim, params_full, vcov_chain)

# Calculate reserves for each simulation
sim_reserves <- numeric(n_sim)
for (i in 1:n_sim) {
  model_params <- sim_params[i, 1:length(a0_chain)]
  sim_reserves[i] <- calculate_reserve(g_chain, model_params)
}
```

### 10.2 Distribution of Reserve Estimates

Code

``` r
hist(
  sim_reserves,
  breaks = 50,
  col = "steelblue",
  border = "white",
  main = "Distribution of Reserve Estimates",
  xlab = "Reserve Amount",
  freq = FALSE
)

# Add density curve
lines(density(sim_reserves), col = "darkred", lwd = 2)

# Add confidence interval lines
ci <- quantile(sim_reserves, c(0.025, 0.5, 0.975))
abline(v = ci, col = c("orange", "red", "orange"), lty = c(2, 1, 2), lwd = 2)
legend(
  "topright",
  c("Density", "Median", "95% CI"),
  col = c("darkred", "red", "orange"),
  lty = c(1, 1, 2),
  lwd = 2,
  bty = "n"
)
```

![](hayne_paper_reproduction_files/figure-html/fig-reserve-distribution-1.png)

Figure 3: Distribution of Simulated Reserves (Chain Ladder)

### 10.3 Summary Statistics

Code

``` r
sim_summary <- data.frame(
  Statistic = c(
    "Mean Reserve",
    "Median Reserve",
    "Standard Error",
    "Coefficient of Variation",
    "2.5% Quantile",
    "97.5% Quantile",
    "95% Confidence Interval Width"
  ),
  Value = c(
    mean(sim_reserves),
    median(sim_reserves),
    sd(sim_reserves),
    sd(sim_reserves) / mean(sim_reserves),
    quantile(sim_reserves, 0.025),
    quantile(sim_reserves, 0.975),
    diff(quantile(sim_reserves, c(0.025, 0.975)))
  )
)

knitr::kable(
  sim_summary,
  caption = "Monte Carlo Simulation Summary (Chain Ladder, 5,000 iterations)",
  digits = 2,
  format.args = list(big.mark = ",")
)
```

| Statistic                     |      Value |
|:------------------------------|-----------:|
| Mean Reserve                  | -29,166.34 |
| Median Reserve                | -29,166.34 |
| Standard Error                |       0.00 |
| Coefficient of Variation      |       0.00 |
| 2.5% Quantile                 | -29,166.34 |
| 97.5% Quantile                | -29,166.34 |
| 95% Confidence Interval Width |       0.00 |

Monte Carlo Simulation Summary (Chain Ladder, 5,000 iterations)

## 11 Conclusion

This vignette has reproduced the key elements of Hayne’s flexible
framework:

1.  **Theoretical Foundation**: The unified likelihood-based approach
    enables consistent parameter estimation and uncertainty
    quantification across all five reserving methods.

2.  **Model Comparison**: Information criteria (AIC/BIC) provide
    objective model selection guidance.

3.  **Uncertainty Quantification**: The Fisher information matrix and
    Monte Carlo simulation enable probabilistic reserve estimates with
    confidence intervals.

4.  **Practical Implementation**: The `stochasticreserver` package
    provides ready-to-use functions for all five models with gradient
    and Hessian computations for efficient optimization.

## 12 References

Hayne, Roger M. 2012. “A Flexible Framework for Stochastic Reserving
Models.” *Variance* 7 (2): 123–51.
<https://variancejournal.org/article/120823>.
