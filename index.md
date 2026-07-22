# sottools

This package mostly contains functions to help retrieve data from the
national waiting times data mart for further analysis using R.

## Installation

Execute the below code in the console to install sottools:

``` r

pak::pak("Public-Health-Scotland/sottools")
```

## Registering Credentials

To connect with the waiting times warehouse using this package you will
need to set up a keyring to store your LDAP password. Instructions for
doing so can be found by running `vignette("wh_credentials")` after
you’ve installed the package.

## Example

This is a very basic example of retrieving data from the warehouse:

``` r

library(sottools)
library(dplyr)

con <- wh_connection()

comp_m <- get_wh_tbl(con, "SSM", "completed")

comp_m |> 
  count() |> 
  collect()
```

A more extensive guide to using sottools to query the warehouse can be
found by running
[`vignette("sottools")`](https://public-health-scotland.github.io/sottools/articles/sottools.md)
in the console.
