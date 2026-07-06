#' Create derived variables
#'
#' There are some variables beyond those in the warehouse views which are
#' required for analysis. This function derives the variables required for
#' further analysis.
#'
#' @param wh_tbl A lazy_tbl object representing a warehouse table. This should
#' be the output of `get_wh_tbl()`
#' @param pub_table One of "completed", "ongoing", "additions", "removals" to
#' tell the function what data is being looked at and therefore what variables
#' to derive.
#'
#' @returns lazy_tbl object with the derived variables added.
#' @export
create_analysis_variables <- function(wh_tbl, pub_table) {
  # pararmeter validation
  if (missing(wh_tbl)) {
    cli::cli_abort(
      "Please pass a lazy_tbl pointing to a warehouse view as the
      {.arg wh_tbl} argument.",
      class = "missing_arg"
    )
  }
  if (!(inherits(wh_tbl, "tbl_lazy"))) {
    cli::cli_abort(
      "{.arg wh_tbl} must be a lazy_tbl pointing to a warehouse view which
      you can get as the output of `get_wh_tbl()`.",
      class = "tbl_lazy_check"
    )
  }
  if (missing(pub_table)) {
    cli::cli_abort(
      "{.arg pub_table} is missing with no default.",
      class = "missing_arg"
    )
  }
  if (!(pub_table %in% c("completed", "ongoing", "additions", "removals"))) {
    cli::cli_abort(
      "{.arg pub_table} must be one of \"completed\", \"ongoing\"
      \"additions\" or \"removals\".",
      class = "invalid_arg"
    )
  }
  wh_tbl <- wh_tbl |>
    c_month_end_date(pub_table = pub_table) |>
    r_specialty_code() |>
    c_grouped_specialty_desc() |>
    c_patient_type_cohort() |>
    r_nhs_board_of_treatment_name(pub_table = pub_table) |>
    r_waiting_time_standard_code() |>
    r_wait_days(pub_table = pub_table)
}
