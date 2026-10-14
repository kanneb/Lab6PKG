
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Lab6PKG

<!-- badges: start -->

[![R-CMD-check](https://github.com/kanneb/Lab6PKG/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/kanneb/Lab6PKG/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

Lab6PKG solves the knapsack problem with three methods: brute force
search, dynamic programming and a greedy heuristic. The brute force
search can also run in C++ with Rcpp.

## Installation

Install from GitHub. Set the option first if you also want the vignette:

``` r
# install.packages("pak")
options(pkg.build_vignettes = TRUE)
pak::pak("kanneb/Lab6PKG")
```

## Examples

The data is generated as following. `x` needs a weight column `w` and a
value column `v`, and `W` is the size of the knapsack.

``` r
library(Lab6PKG)

suppressWarnings(RNGversion(min(as.character(getRversion()), "3.5.3")))
set.seed(42, kind = "Mersenne-Twister", normal.kind = "Inversion")
n <- 2000
knapsack_objects <- data.frame(
  w = sample(1:4000, size = n, replace = TRUE),
  v = runif(n = n, 0, 10000)
)
```

Brute force search goes through all combinations, so keep `n` small. Use
`fast = TRUE` to run the search in C++:

``` r
brute_force_knapsack(x = knapsack_objects[1:8, ], W = 3500)
#> $value
#> [1] 16770.38
#> 
#> $elements
#> [1] 5 8
brute_force_knapsack(x = knapsack_objects[1:8, ], W = 3500, fast = TRUE)
#> $value
#> [1] 16770.38
#> 
#> $elements
#> [1] 5 8
```

Dynamic programming gives the exact answer and works with larger `n`, as
long as the weights are integers:

``` r
knapsack_dynamic(x = knapsack_objects[1:500, ], W = 3500)
#> $value
#> [1] 164380
#> 
#> $elements
#>  [1]  35  37  43  55  77  80  92 110 117 229 234 243 255 282 288 290 300 303 314
#> [20] 332 342 345 346 400 401 436 472 500
```

The greedy heuristic is the fastest but only approximate:

``` r
greedy_knapsack(x = knapsack_objects[1:800, ], W = 3500)
#> $value
#> [1] 192647
#> 
#> $elements
#>  [1] 564 719 229  77  35 747  43 243 300 345 303 599 764 282 346 436 290  55 794
#> [20] 500 255 234 288 577 776  37 117 332 537 110  80 472 574  92
```

All functions return a list with the total `value` and the row numbers
in `elements`.

## More

The vignette contains the lab report with timings and answers to the
questions:

``` r
browseVignettes("Lab6PKG")
```
