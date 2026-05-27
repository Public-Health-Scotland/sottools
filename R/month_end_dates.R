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
#' month_end_dates(lubridate::dmy("31-03-2026"), n_months = 12)
month_end_dates <- function(start_date,
                            end_date,
                            n_months = 25) {
  # Parameter validation
  if (!missing(start_date)) {
    if (!inherits(start_date, "Date")) {
    cli::cli_abort(
      "{.arg start_date} must be of type \"Date\"",
      class = "invalid_arg"
    )
    }
  }
  if (!missing(end_date)) {
    if (!inherits(end_date, "Date")) {
      cli::cli_abort(
        "{.arg end_date} must be of type \"Date\"",
        class = "invalid_arg"
      )
    }
  }
  if (!missing(n_months)) {
    if (!inherits(n_months, "numeric")) {
      cli::cli_abort(
        "{.arg n_months} must be of type \"numeric\"",
        class = "invalid_arg"
      )
    }
  }
  if (missing(start_date) & missing(end_date)) {
    cli::cli_abort(
      "Please provide two of {.arg start_date}, {.arg end_date} and {.arg n_months}",
      class = "missing_args"
    )
  }
  if (!missing(start_date) & !missing(end_date) & !missing(n_months)) {
    if (length(seq(from = start_date+1, to = end_date+1, by="months")-1) != n_months) {
    cli::cli_abort(
      "{.arg n_months} is not consistent with the number of time
      points between {.arg start_date} and {.arg end_date}.",
      class = "inconsistent_args"
    )
    }
  }
  #
  if (missing(start_date)) {
    dates <- seq(to = end_date+1, length=n_months, by="months")-1
  } else if (missing(end_date)) {
    dates <- seq(from = start_date+1, length=n_months, by="months")-1
  } else {
    dates <- seq(from = start_date+1, to = end_date+1, by="months")-1
  }

  dates
}
