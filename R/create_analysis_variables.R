#' Create derived variables
#'
#' There are some variables beyond those in the warehouse views which are
#' required for analysis. This function derives the variables required for
#' further analysis.
#'
#' @param df A lazy_tbl object representing a warehouse table. This should
#' be the output of `get_wh_tbl()`
#' @param table One of "completed", "ongoing", "additions", "removals" to
#' tell the function what data is being looked at and therefore what variables
#' to derive.
#'
#' @returns lazy_tbl object with the derived variables added.
#' @export
create_analysis_variables <- function(df, table) {
  # pararmeter validation
  if (missing(df)) {
    cli::cli_abort(
      "Please pass a lazy_tbl pointing to a warehouse view as the
      {.arg df} argument.",
      class = "missing_arg"
    )
  }
  if (!(inherits(df, "tbl_lazy"))) {
    cli::cli_abort(
      "{.arg df} must be a lazy_tbl pointing to a warehouse view which
      you can get as the output of `get_wh_tbl()`.",
      class = "wh_object_check"
    )
  }
  if (missing(table)) {
    cli::cli_abort(
      "{.arg table} is missing with no default.",
      class = "missing_arg"
    )
  }
  if (!(table %in% c("completed", "ongoing", "additions", "removals"))) {
    cli::cli_abort(
      "{.arg datatype} must be one of \"completed\", \"ongoing\"
      \"additions\" or \"removals\".",
      class = "invalid_arg"
    )
  }
  df <- df |>
    c_month_end_date(wh_table = table) |>
    r_specialty_code() |>
    c_grouped_specialty_desc() |>
    c_patient_type_cohort() |>
    r_nhs_board_of_treatment_name(table) |>
    r_waiting_time_standard_code() |>
    r_wait_days(wh_table = table)
}
