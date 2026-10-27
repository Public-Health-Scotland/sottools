#' Create Performance Summary Table
#'
#' This function takes an ongoing or completed waits warehouse view and
#' calculates the following summary statistics:
#' - Number of waits
#' - Number of waits over 12 weeks
#' - Number of waits over 26 weeks
#' - Median wait
#' - 90th percentile wait
#'
#' @param wh_tbl A `lazy_tbl` object referring to either the ongoing
#' or completed warehouse view. This can be either grouped or ungrouped.
#'
#' @returns A lazy_tbl object containing the summary stats
#' @export
s_performance <- function(wh_tbl) {

  wh_tbl <- wh_tbl |>
    dplyr::summarise(waits = dplyr::n(),
                     over_12_weeks = sum(dplyr::if_else(wait_days > 84, 1, 0), na.rm = TRUE),
                     over_16_weeks = sum(dplyr::if_else(wait_days > 182, 1, 0), na.rm = TRUE),
                     median = stats::quantile(wait_days, 0.5, na.rm = TRUE),
                     p_90 = stats::quantile(wait_days, 0.9, na.rm = TRUE))

}
