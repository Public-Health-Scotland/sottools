# Filter out records not reported on in the SoT publication

Records are filtered out of the SoT publication cohort for a variety of
reasons. These filters are defined in various functions within sottools
and this wrapper applies all the ones needed to define the publicaiton
cohort.

## Usage

``` r
apply_publication_filters(wh_tbl, pub_table)
```

## Arguments

- wh_tbl:

  A lazy_tbl object represenging a warehouse table. This object needs to
  come from running the function
  [`get_wh_tbl()`](https://public-health-scotland.github.io/sottools/reference/get_wh_tbl.md)
  and then
  [`create_analysis_variables()`](https://public-health-scotland.github.io/sottools/reference/create_analysis_variables.md)
  on the resulting object.

- pub_table:

  One of "completed", "ongoing", "additions", "removals" to tell the
  function what data is being looked at and therefore what filters to
  apply.

## Value

A lazy_tbl object with the publication filters applied.

## Details

Full documentation of the SoT publication filters can be found WHERE
