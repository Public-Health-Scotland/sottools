# Connect to the warehouse

`wh_connection()` extablishes a database connection object for the
national waiting times data mart.

## Usage

``` r
wh_connection()
```

## Value

A DVPROD connection object

## Examples

``` r
con <- wh_connection()
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Error in default_backend()$keyring_unlock(keyring, password): attempt to apply non-function
```
