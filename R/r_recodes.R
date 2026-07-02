r_nhs_board_of_treatment_name <- function(df, wh_table) {

  df <- df |>
    dplyr::mutate(nhs_board_of_treatment_name = dplyr::case_when(
      nhs_board_of_treatment_name == "ENGLAND/WALES/NORTHERN IRELAND" ~ "Outside Scotland",
      nhs_board_of_treatment_name == "NATIONAL FACILITY" ~ "NHS Golden Jubilee",
      nhs_board_of_treatment_name == "NHS AYRSHIRE & ARRAN" ~ "NHS Ayrshire & Arran",
      nhs_board_of_treatment_name == "NHS BORDERS" ~ "NHS Borders",
      nhs_board_of_treatment_name == "NHS DUMFRIES & GALLOWAY" ~ "NHS Dumfries & Galloway",
      nhs_board_of_treatment_name == "NHS FIFE" ~ "NHS Fife",
      nhs_board_of_treatment_name == "NHS FORTH VALLEY" ~ "NHS Forth Valley",
      nhs_board_of_treatment_name == "NHS GRAMPIAN" ~ "NHS Grampian",
      nhs_board_of_treatment_name == "NHS GREATER GLASGOW & CLYDE" ~ "NHS Greater Glasgow & Clyde",
      nhs_board_of_treatment_name == "NHS HIGHLAND" ~ "NHS Highland",
      nhs_board_of_treatment_name == "NHS LANARKSHIRE" ~ "NHS Lanarkshire",
      nhs_board_of_treatment_name == "NHS LOTHIAN" ~ "NHS Lothian",
      nhs_board_of_treatment_name == "NHS ORKNEY" ~ "NHS Orkney",
      nhs_board_of_treatment_name == "NHS SHETLAND" ~ "NHS Shetland",
      nhs_board_of_treatment_name == "NHS TAYSIDE" ~ "NHS Tayside",
      nhs_board_of_treatment_name == "NHS WESTERN ISLES" ~ "NHS Western Isles",
      nhs_board_of_treatment_name == "NON-NHS PROVIDER" ~ "Non-NHS Provider",
      nhs_board_of_treatment_name == "NOT KNOWN" ~ "Not known",
      TRUE ~ "Not known"
    ))

  if (wh_table == "ongoing") {
    df <- df |>
      dplyr::mutate(nhs_board_of_treatment_name = dplyr::case_when(
        nhs_board_of_treatment_name == "NHS Forth Valley" &
          specialty_code == "A7" &
          nhs_board_of_sending_location_name == "NHS LOTHIAN" ~ "NHS Lothian",
        TRUE ~ nhs_board_of_treatment_name
      ))
  }

  df
}

r_specialty_code <- function(df) {

  df <- df |>
    dplyr::mutate(
      specialty_code = dplyr::if_else(is.na(specialty_code),
                                      "BLANK",
                                      specialty_code))

}

r_waiting_time_standard_code <- function(df) {

  df <- df |>
    dplyr::mutate(waiting_time_standard_code = dplyr::if_else(is.na(waiting_time_standard_code),
                                                       "000",
                                                       waiting_time_standard_code))

  df

}

r_wait_days <- function(df, wh_table) {

  if (wh_table == "ongoing") {
    df <- df |>
      dplyr::rename(wait_days = wait_days_at_report_date)
  }

  df <- df |>
    dplyr::mutate(wait_days = dplyr::if_else(wh_table == "completed" &
                                        patient_type_cohort == "Inpatient/Day case" &
                                        waiting_time_standard_code == "023",
                                      0, wait_days))

}
