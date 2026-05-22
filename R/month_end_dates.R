#' Get a vector of month-end dates
#'
#' @param start_date First date of period
#' @param end_date Last date of period
#' @param n_months Number of months
#'
#' @returns A vector containing the date objects of the month ends in question
#' @export
#'
#' @examples
#' month_end_dates(as.Date("2024-01-01"), as.Date("2025-01-01"))
month_end_dates <- function(start_date,
                            end_date,
                            n_months = 25) {

  if (missing(start_date)) {
    dates <- seq(to = end_date+1, length=n_months, by="months")-1
  } else if (missing(end_date)) {
    dates <- seq(from = start_date+1, length=n_months, by="months")-1
  } else {
    dates <- seq(from = start_date+1, to = end_date+1, by="months")-1
  }

  dates
}
