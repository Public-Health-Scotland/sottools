
<!-- README.md is generated from README.Rmd. Please edit that file -->

# sottools

<!-- badges: start -->

<!-- badges: end -->

This package mostly contains functions to help retrieve data from the
national waiting times data mart for further analysis using R.

## Installation

Execute the below code in the console to install sottools:

``` r
remotes::install_git("https://phs-git.nhsnss.scot.nhs.uk/Resources/sottools.git")
```

## Example

This is a very basic example of retrieving data from the warehouse:

``` r
library(sottools)
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union

con <- wh_connection()

comp_m <- get_wh_tbl(con, "SSM", "completed")

comp_m |> 
  count() |> 
  collect()
#> # A tibble: 1 × 1
#>          n
#>    <int64>
#> 1 59065586
```

A more extensive guide to using sottools to query the warehouse can be
found in
