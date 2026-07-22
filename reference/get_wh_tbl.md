# Get a lazy_tbl object from the warehouse

Once a connection to the waiting times warehouse has been established
using
[`wh_connection()`](https://public-health-scotland.github.io/sottools/reference/wh_connection.md)
this function can be used to create an object which represents a view
from the warehouse.

## Usage

``` r
get_wh_tbl(con, snapshot_live = "SSM", view = "ongoing")
```

## Arguments

- con:

  The dv_platform connection object

- snapshot_live:

  A character vector specifying "SSQ", "SSM" or "LIVE"

- view:

  One of "ongoing", "completed", "offers", "unavailability",
  "snapshot_details"

## Value

A lazy_tbl object representing the warehouse table

## Examples

``` r
con <- wh_connection()
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Error in default_backend()$keyring_unlock(keyring, password): attempt to apply non-function
test <- get_wh_tbl(con, snapshot_live = "SSM", view = "ongoing")
#> Error: object 'con' not found
```
