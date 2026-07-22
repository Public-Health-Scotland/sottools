# Create derived variables

There are some variables beyond those in the warehouse views which are
required for analysis. This function derives the variables required for
further analysis.

## Usage

``` r
create_analysis_variables(wh_tbl, pub_table)
```

## Arguments

- wh_tbl:

  A lazy_tbl object representing a warehouse table. This should be the
  output of
  [`get_wh_tbl()`](https://public-health-scotland.github.io/sottools/reference/get_wh_tbl.md)

- pub_table:

  One of "completed", "ongoing", "additions", "removals" to tell the
  function what data is being looked at and therefore what variables to
  derive.

## Value

lazy_tbl object with the derived variables added.
