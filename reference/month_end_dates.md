# Get a vector of month-end dates

Get a vector of month-end dates

## Usage

``` r
month_end_dates(start_date, end_date, n_months = 25)
```

## Arguments

- start_date:

  First date of period

- end_date:

  Last date of period

- n_months:

  Number of months

## Value

A vector containing the date objects of the month ends in question

## Examples

``` r
month_end_dates(as.Date("2024-01-01"), as.Date("2025-01-01"))
#>  [1] "2024-01-01" "2024-02-01" "2024-03-01" "2024-04-01" "2024-05-01"
#>  [6] "2024-06-01" "2024-07-01" "2024-08-01" "2024-09-01" "2024-10-01"
#> [11] "2024-11-01" "2024-12-01" "2025-01-01"
month_end_dates(lubridate::dmy("31-03-2026"), n_months = 12)
#>  [1] "2026-03-31" "2026-04-30" "2026-05-31" "2026-06-30" "2026-07-31"
#>  [6] "2026-08-31" "2026-09-30" "2026-10-31" "2026-11-30" "2026-12-31"
#> [11] "2027-01-31" "2027-02-28"
```
