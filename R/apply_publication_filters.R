#' Filter out records not reported on in the SoT publication
#'
#' Records are filtered out of the SoT publication cohort for a variety of
#' reasons. These filters are defined in various functions within sottools
#' and this wrapper applies all the ones needed to define the publicaiton
#' cohort.
#'
#' Full documentation of the SoT publication filters can be found WHERE
#'
#' @param wh_tbl A lazy_tbl object represenging a warehouse table. This object
#' needs to come from running the function `get_wh_tbl()` and then
#' `create_analysis_variables()` on the resulting object.
#' @param pub_table One of "completed", "ongoing", "additions", "removals" to
#' tell the function what data is being looked at and therefore what filters
#' to apply.
#'
#' @returns A lazy_tbl object with the publication filters applied.
#'
#' @export
apply_publication_filters <- function(wh_tbl, pub_table) {

  wh_tbl <- wh_tbl |>
    dplyr::filter(active_deleted_record_status == "A",
           sending_location_code != "S206H",
           patient_type_code %in% c("21","11","01"),
           wait_error_flag_code %in% c(0,1),
           !(specialty_code %in% c("R5","R4","R1","RF2","RF","RB")),
           !(waiting_time_standard_code %in% c("071","072","073",
                                               "080","081","090"))) |>
    f_borders_small_specs()

  if (pub_table == "completed") {
    wh_tbl <- wh_tbl |>
      dplyr::filter(attended_admitted_flag == "Y") |>
      dplyr::mutate(date_lothian_small = date_of_wait_initial_start) |>
      f_lothian_small_specs() |>
      dplyr::filter(!!fp_completed_nop() |
               !!fp_completed_ipdc())
  } else if (pub_table == "ongoing") {
    wh_tbl <- wh_tbl |>
      dplyr::mutate(date_lothian_small = date_of_report) |>
      f_lothian_small_specs() |>
      dplyr::filter(!!fp_ongoing_nop() |
               !!fp_ongoing_ipdc())
  } else if (pub_table == "additions") {
    wh_tbl <- wh_tbl |>
      dplyr::mutate(date_lothian_small = date_of_wait_initial_start) |>
      f_lothian_small_specs() |>
      dplyr::filter(!!fp_add_rem_nop() |
               !!fp_add_rem_ipdc())
  } else if (pub_table == "removals") {
    wh_tbl <- wh_tbl |>
      dplyr::mutate(date_lothian_small = date_of_removal_from_list) |>
      f_lothian_small_specs() |>
      dplyr::filter(!!fp_add_rem_nop() |
               !!fp_add_rem_ipdc())
  }

  wh_tbl
}
