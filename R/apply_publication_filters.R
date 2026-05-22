#' @export
apply_publication_filters <- function(df, table) {

  df <- df |>
    dplyr::filter(active_deleted_record_status == "A",
           sending_location_code != "S206H",
           patient_type_code %in% c("21","11","01"),
           wait_error_flag_code %in% c(0,1),
           !(specialty_code %in% c("R5","R4","R1","RF2","RF","RB")),
           !(waiting_time_standard_code %in% c("071","072","073",
                                               "080","081","090"))) |>
    f_borders_small_specs()

  if (table == "completed") {
    df <- df |>
      dplyr::filter(attended_admitted_flag == "Y") |>
      dplyr::mutate(date_lothian_small = date_of_wait_initial_start) |>
      f_lothian_small_specs() |>
      dplyr::filter(!!fp_completed_nop() |
               !!fp_completed_ipdc())
  } else if (table == "ongoing") {
    df <- df |>
      dplyr::mutate(date_lothian_small = date_of_report) |>
      f_lothian_small_specs() |>
      dplyr::filter(!!fp_ongoing_nop() |
               !!fp_ongoing_ipdc())
  } else if (table == "additions") {
    df <- df |>
      dplyr::mutate(date_lothian_small = date_of_wait_initial_start) |>
      f_lothian_small_specs() |>
      dplyr::filter(!!fp_add_rem_nop() |
               !!fp_add_rem_ipdc())
  } else if (table == "removals") {
    df <- df |>
      dplyr::mutate(date_lothian_small = date_of_removal_from_list) |>
      f_lothian_small_specs() |>
      dplyr::filter(!!fp_add_rem_nop() |
               !!fp_add_rem_ipdc())
  }

  df
}
