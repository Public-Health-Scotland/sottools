#' @export
create_analysis_variables <- function(df, table) {
  df <- df |>
    c_month_end_date(wh_table = table) |>
    r_specialty_code() |>
    c_grouped_specialty() |>
    c_patient_type_cohort() |>
    r_nhs_board_of_treatment_name(table) |>
    r_waiting_time_standard_code() |>
    r_wait_days(wh_table = table)
}
