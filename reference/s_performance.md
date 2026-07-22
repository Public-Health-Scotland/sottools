# Create Performance Summary Table

This function takes an ongoing or completed waits warehouse view and
calculates the following summary statistics:

- Number of waits

- Number of waits over 12 weeks

- Number of waits over 16 weeks

- Median wait

- 90th percentile wait

## Usage

``` r
s_performance(wh_tbl)
```

## Arguments

- wh_tbl:

  A `lazy_tbl` object referring to either the ongoing or completed
  warehouse view. This can be either grouped or ungrouped.

## Value

A lazy_tbl object containing the summary stats
