f_borders_small_specs <- function(df) {

  df <- df |>
    dplyr::filter(provider_name != "Borders" |
                    (provider_name == "Borders" &
                       !(specialty_code %in% c("AD","J4","H2"))))

}

f_lothian_small_specs <- function(df) {

  df <- df |>
    dplyr::filter((nhs_board_of_sending_location_name == "NHS LOTHIAN" &
                     !(specialty_code %in% c("D1","D2","D3",
                                             "D4","D5","D6",
                                             "D61","D62","D63",
                                             "D7","D8","D9",
                                             "DA","DB","DC",
                                             "DD","DE")) &
                     patient_type_code == "21" &
                     date_lothian_small >= as.Date("2019-10-01") &
                     date_lothian_small <= as.Date("2020-03-31")) |

                    (nhs_board_of_sending_location_name == "NHS LOTHIAN" &
                       (patient_type_code %in% c("01","11")  |
                          date_lothian_small < as.Date("2019-10-01") |
                          date_lothian_small > as.Date("2020-03-31"))) |

                    nhs_board_of_sending_location_name != "NHS LOTHIAN")

}

fp_completed_nop <- function() {
  rlang::expr(
    patient_type_cohort == "New Outpatient" &
      date_of_referral_receipt >= as.Date("2009-04-01") &
      web_flag == "Y" &
      scottish_resident_flag == "Y" &
      !(removal_reason_code %in% c("50","51","59")) &
      !(waiting_time_standard_code %in% c("074","075","060")) &
      !!fp_nop_small_specs() &
      !!fp_nop_wts() &
      !!fp_nop_completed_old_referral_sources()
  )
}

fp_ongoing_nop <- function() {
  rlang::expr(
    patient_type_cohort == "New Outpatient" &
      !!fp_oph_excl() &
      web_flag == "Y" &
      date_of_referral_receipt >= as.Date("2009-04-01") &
      scottish_resident_flag == "Y" &
      !(waiting_time_standard_code %in% c("074","075","060")) &
      !!fp_nop_small_specs() &
      !!fp_nop_wts() &
      !!fp_nop_ongoing_old_referral_sources()
  )
}

fp_add_rem_nop <- function() {
  rlang::expr(
    patient_type_cohort == "New Outpatient" &
      date_of_referral_receipt >= as.Date("2009-04-01") &
      web_flag == "Y" &
      scottish_resident_flag == "Y" &
      !(waiting_time_standard_code %in% c("074","075","060")) &
      !!fp_nop_small_specs() &
      !!fp_nop_wts()
  )
}

#' @export
fp_completed_ipdc <- function() {
  rlang::expr(
    patient_type_cohort == "Inpatient/Day case" &
      date_of_wait_initial_start >= as.Date("2012-10-01") &
      !(patient_category_code %in% c("2","7","8")) &
      !!fp_ipdc_wts()
  )

}

fp_ongoing_ipdc <- function() {
  rlang::expr(
    patient_type_cohort == "Inpatient/Day case" &
      date_of_wait_initial_start >= as.Date("2012-10-01") &
      !(patient_category_code %in% c("2","7","8")) &
      waiting_time_standard_code != "023" &
      !!fp_ipdc_wts()
  )
}

fp_add_rem_ipdc <- function() {
  fp_completed_ipdc()
}

fp_nop_small_specs <- function() {
  rlang::expr(
    !(specialty_code %in% c("AC","AJ","RU5",
                            "RU6","RU7","RU8"))
  )
}

fp_nop_wts <- function() {
  rlang::expr(
    ((waiting_time_standard_code != "050" &
        date_of_wait_initial_start >= as.Date("2019-10-01")) |
       date_of_wait_initial_start < as.Date("2019-10-01"))
  )
}

fp_ipdc_wts <- function() {
  rlang::expr(
    ((!(waiting_time_standard_code %in% c("050","051","052")) &
       date_of_wait_initial_start >= as.Date("2014-10-01")) |

       (!(waiting_time_standard_code %in% c("050","051","052","074")) &
          date_of_wait_initial_start <= as.Date("2014-09-30") &
          date_of_wait_initial_start >= as.Date("2014-04-01")) |

       (!(waiting_time_standard_code %in% c("050","051","052","074","075")) &
          date_of_wait_initial_start < as.Date("2014-04-01")))
  )
}

fp_nop_completed_old_referral_sources <- function() {
  rlang::expr(
    ((date_of_removal_from_list < as.Date("2012-10-01") &
        (waiting_time_standard_code != "021" |
           !(referral_source_code %in% c("1","D","0"))) &
        (waiting_time_standard_code != "030" |
           !(referral_source_code %in% c("1","D")))) |
       date_of_removal_from_list >= as.Date("2012-10-01"))
  )
}

fp_oph_excl <- function() {
  rlang::expr(
    !(date_of_report >= as.Date("2023-10-01") &
        specialty_code == "C7" &
        transfer_flag == "Y")
  )
}

fp_nop_ongoing_old_referral_sources <- function() {
  rlang::expr(
    ((date_of_report < as.Date("2012-10-01") &
        (waiting_time_standard_code != "021" |
           !(referral_source_code %in% c("1","D","0"))) &
        (waiting_time_standard_code != "030" |
           !(referral_source_code %in% c("1","D")) |
           attended_admitted_flag != "Y")) |
       date_of_report >= as.Date("2012-10-01"))
  )
}
