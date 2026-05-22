c_patient_type_cohort <- function(df) {

  df <- df |>
    dplyr::mutate(patient_type_cohort = dplyr::case_when(
      patient_type_code == "21" ~ "New Outpatient",
      patient_type_code %in% c("01", "11") ~ "Inpatient/Day case",
      patient_type_code == "23" ~ "Return outpatient",
      TRUE ~ NA
    ))

  df

}

c_grouped_specialty <- function(df) {

  df <- df |>
    dplyr::mutate(
      specialty_code = dplyr::if_else(is.na(specialty_code),
                               "BLANK",
                               specialty_code),
      specialty = dplyr::case_when(
        substr(specialty_code,1,2) == "A1" ~ "GENERAL MEDICINE",
        substr(specialty_code,1,2) == "A8" ~ "ENDOCRINOLOGY & DIABETES",
        substr(specialty_code,1,2) == "C1" ~ "GENERAL SURGERY",
        substr(specialty_code,1,2) == "C3" ~ "ANAESTHETICS",
        substr(specialty_code,1,2) == "C4" ~ "CARDIOTHORACIC SURGERY",
        substr(specialty_code,1,2) == "C5" ~ "EAR, NOSE & THROAT",
        substr(specialty_code,1,2) == "E1" ~ "GP",
        substr(specialty_code,1,2) == "F3" ~ "OBSTETRICS",
        substr(specialty_code,1,2) == "G2" ~ "CHILD & ADOLESCENT PSYCHIATRY",
        substr(specialty_code,1,2) == "R1" ~ "SURGICAL PODIATRY",
        substr(specialty_code,1,2) == "T2" ~ "MIDWIFERY",
        substr(specialty_code,1,2) == "A2" ~ "CARDIOLOGY",
        substr(specialty_code,1,2) == "AF" ~ "PAEDIATRICS",
        substr(specialty_code,1,2) == "F1" ~ "OBSTETRICS & GYNAECOLOGY",
        substr(specialty_code,1,2) == "G1" ~ "GENERAL PSYCHIATRY (MENTAL ILLNESS)",
        substr(specialty_code,1,2) == "R8" ~ "AUDIOLOGICAL SCIENCE",
        substr(specialty_code,1,2) == "RK" ~ "DIAGNOSTIC RADIOGRAPHY",
        substr(specialty_code,1,2) == "T1" ~ "GENERAL NURSING",
        substr(specialty_code,1,2) == "T3" ~ "MENTAL HEALTH NURSING",
        substr(specialty_code,1,2) == "H1" ~ "CLINICAL RADIOLOGY",
        substr(specialty_code,1,2) == "C9" ~ "PLASTIC SURGERY",
        TRUE ~ specialty_desc
      ))

  df

}

c_month_end_date <- function(df, wh_table) {

  if (wh_table == "ongoing") {
    df <- df |>
      dplyr::mutate(month_end_date = date_of_report)
  } else if (wh_table == "completed" | wh_table == "removals") {
    df <- df |>
      dplyr::mutate(month_end_date = substr(date_of_removal_from_list,1,7))
  } else if (wh_table == "additions") {
    df <- df |>
      dplyr::mutate(month_end_date = substr(date_of_wait_initial_start,1,7))
  }
}
