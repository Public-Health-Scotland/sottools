### create .duckdb file for test data ----

duckdb::duckdb(test_path("fixtures", "test_db.duckdb"))

con <- DBI::dbConnect(duckdb::duckdb(),
                      dbdir = test_path("fixtures", "test_db.duckdb"))

### Views for filter testing ----

#### f_borders_small_specs ----

f_borders_small_specs_df <- data.frame(
  in_out = c("out", "out", "in"),
  provider_name = c("Borders", "Borders", "Borders"),
  specialty_code = c("AD", "J4", "C1")
)

duckdb::dbWriteTable(con,
                     "f_borders_small_specs",
                     f_borders_small_specs_df,
                     overwrite = TRUE)

#### fp_nop_small_specs_df ----
fp_nop_small_specs_df <- data.frame(
  in_out = c(rep("out",6), "in"),
  specialty_code = c("AC","AJ","RU5",
                     "RU6","RU7","RU8",
                     "C1")
)

duckdb::dbWriteTable(con,
                     "fp_nop_small_specs",
                     fp_nop_small_specs_df,
                     overwrite = TRUE)

#### fp_oph_excl ----
fp_oph_excl_df <- data.frame(
  in_out = c("out", "in"),
  date_of_report = c(as.Date("2023-11-01"), as.Date("2022-11-01")),
  specialty_code = c("C7", "C7"),
  transfer_flag = c("Y", "Y")
)

duckdb::dbWriteTable(con,
                     "fp_oph_excl",
                     fp_oph_excl_df,
                     overwrite = TRUE)

#### fp_nop_wts ----
fp_nop_wts_df <- data.frame(
  in_out = c("in", "out"),
  date_of_wait_initial_start = c(as.Date("2019-09-01"), as.Date("2020-10-01")),
  waiting_time_standard_code = c("050", "050")
)

duckdb::dbWriteTable(con,
                     "fp_nop_wts",
                     fp_nop_wts_df,
                     overwrite = TRUE)

#### fp_nop_completed_old_referral_sources ----
fp_nop_completed_old_referral_sources_df <- data.frame(
  in_out = c("out","out","out","in"),
  date_of_removal_from_list = c(as.Date("2012-09-01"),
                                as.Date("2012-09-01"),
                                as.Date("2012-09-01"),
                                as.Date("2012-09-01")),
  waiting_time_standard_code = c("021","030","021","030"),
  referral_source_code = c("1","D","1","0")
)

duckdb::dbWriteTable(con,
                     "fp_nop_completed_old_referral_sources",
                     fp_nop_completed_old_referral_sources_df,
                     overwrite = TRUE)

#### fp_nop_completed_old_referral_sources ----
fp_nop_ongoing_old_referral_sources_df <- data.frame(
  in_out = c("out","out","out","in"),
  date_of_report = c(as.Date("2012-09-01"),
                     as.Date("2012-09-01"),
                     as.Date("2012-09-01"),
                     as.Date("2012-09-01")),
  waiting_time_standard_code = c("021","030","021","030"),
  attended_admitted_flag = c("Y","Y","Y","N"),
  referral_source_code = c("1","D","1","0")
)

duckdb::dbWriteTable(con,
                     "fp_nop_ongoing_old_referral_sources",
                     fp_nop_ongoing_old_referral_sources_df,
                     overwrite = TRUE)

#### fp_nop_completed_old_referral_sources ----
fp_ipdc_wts_df <- data.frame(
  in_out = c("out","in","out","in"),
  date_of_wait_initial_start = c(as.Date("2015-10-01"),
                                 as.Date("2014-05-01"),
                                 as.Date("2012-09-01"),
                                 as.Date("2014-05-01")),
  waiting_time_standard_code = c("050","075","075","075")

)

duckdb::dbWriteTable(con,
                     "fp_ipdc_wts",
                     fp_ipdc_wts_df,
                     overwrite = TRUE)


#### fp_ongoing_ipdc ----
fp_ongoing_ipdc_df <- data.frame(
  in_out = c("out","out","out","out","in"),
  date_of_wait_initial_start = c(as.Date("2012-09-01"),
                                 as.Date("2022-10-01"),
                                 as.Date("2022-10-01"),
                                 as.Date("2022-10-01"),
                                 as.Date("2022-10-01")),
  patient_type_cohort = c("Inpatient/Day case",
                          "New Outpatient",
                          "Inpatient/Day case",
                          "Inpatient/Day case",
                          "Inpatient/Day case"),
  patient_category_code = c("1","1","8","1", "1"),
  waiting_time_standard_code = c("011","011","011","023","011")
)

duckdb::dbWriteTable(con,
                     "fp_ongoing_ipdc",
                     fp_ongoing_ipdc_df,
                     overwrite = TRUE)

#### fp_completed_ipdc ----
fp_completed_ipdc_df <- data.frame(
  in_out = c("out","out","out","in"),
  date_of_wait_initial_start = c(as.Date("2012-09-01"),
                                 as.Date("2022-10-01"),
                                 as.Date("2022-10-01"),
                                 as.Date("2022-10-01")),
  patient_type_cohort = c("Inpatient/Day case",
                          "New Outpatient",
                          "Inpatient/Day case",
                          "Inpatient/Day case"),
  patient_category_code = c("1","1","2", "1"),
  waiting_time_standard_code = c("011","011","011","011")
)

duckdb::dbWriteTable(con,
                     "fp_completed_ipdc",
                     fp_completed_ipdc_df,
                     overwrite = TRUE)

#### fp_add_rem_nop ----
fp_add_rem_nop_df <- data.frame(
  in_out = c("out","out","out","out","out","in"),
  date_of_referral_receipt = c(as.Date("2009-02-01"),
                               as.Date("2019-04-01"),
                               as.Date("2019-04-01"),
                               as.Date("2019-04-01"),
                               as.Date("2019-04-01"),
                               as.Date("2019-04-01")),
  patient_type_cohort = c("New Outpatient",
                          "Inpatient/Day case",
                          "New Outpatient",
                          "New Outpatient",
                          "New Outpatient",
                          "New Outpatient"),
  web_flag = c("Y","Y","N","Y","Y","Y"),
  scottish_resident_flag = c("Y","Y","Y","N","Y","Y"),
  waiting_time_standard_code = c("021","021","021","021","060","021"),
  specialty_code = c("C1","C1","C1","C1","C1","C1"),
  date_of_wait_initial_start = c(as.Date("2020-10-01"),
                                 as.Date("2020-10-01"),
                                 as.Date("2020-10-01"),
                                 as.Date("2020-10-01"),
                                 as.Date("2020-10-01"),
                                 as.Date("2020-10-01"))
)

duckdb::dbWriteTable(con,
                     "fp_add_rem_nop",
                     fp_add_rem_nop_df,
                     overwrite = TRUE)

#### fp_ongoing_nop ----
fp_ongoing_nop_df <- data.frame(
  in_out = c("out","out","out","out","out","in"),
  date_of_referral_receipt = c(as.Date("2009-02-01"),
                               as.Date("2019-04-01"),
                               as.Date("2019-04-01"),
                               as.Date("2019-04-01"),
                               as.Date("2019-04-01"),
                               as.Date("2019-04-01")),
  patient_type_cohort = c("New Outpatient",
                          "Inpatient/Day case",
                          "New Outpatient",
                          "New Outpatient",
                          "New Outpatient",
                          "New Outpatient"),
  web_flag = c("Y","Y","N","Y","Y","Y"),
  scottish_resident_flag = c("Y","Y","Y","N","Y","Y"),
  waiting_time_standard_code = c("021","021","021","021","060","021"),
  specialty_code = c("C1","C1","C1","C1","C1","C1"),
  date_of_report = c(as.Date("2019-04-01"),
                     as.Date("2019-04-01"),
                     as.Date("2019-04-01"),
                     as.Date("2019-04-01"),
                     as.Date("2019-04-01"),
                     as.Date("2019-04-01")),
  referral_source_code = c("1","1","1","1","1","1"),
  date_of_wait_initial_start = c(as.Date("2009-02-01"),
                                 as.Date("2019-04-01"),
                                 as.Date("2019-04-01"),
                                 as.Date("2019-04-01"),
                                 as.Date("2019-04-01"),
                                 as.Date("2019-04-01")),
  transfer_flag = c("Y","Y","Y","Y","Y","Y"),
  attended_admitted_flag = c("N","N","N","N","N","N")
)

duckdb::dbWriteTable(con,
                     "fp_ongoing_nop",
                     fp_ongoing_nop_df,
                     overwrite = TRUE)

#### fp_completed_nop ----
fp_completed_nop_df <- data.frame(
  in_out = c("out","out","out","out","out","out","in"),
  date_of_referral_receipt = c(as.Date("2009-02-01"),
                               as.Date("2019-04-01"),
                               as.Date("2019-04-01"),
                               as.Date("2019-04-01"),
                               as.Date("2019-04-01"),
                               as.Date("2019-04-01"),
                               as.Date("2019-04-01")),
  patient_type_cohort = c("New Outpatient",
                          "Inpatient/Day case",
                          "New Outpatient",
                          "New Outpatient",
                          "New Outpatient",
                          "New Outpatient",
                          "New Outpatient"),
  web_flag = c("Y","Y","N","Y","Y","Y","Y"),
  scottish_resident_flag = c("Y","Y","Y","N","Y","Y","Y"),
  waiting_time_standard_code = c("021","021","021","021","075","021","021"),
  removal_reason_code = c("01","01","01","01","01","51","01"),
  specialty_code = c("C1","C1","C1","C1","C1","C1","C1"),
  date_of_wait_initial_start = c(as.Date("2019-04-01"),
                                 as.Date("2019-04-01"),
                                 as.Date("2019-04-01"),
                                 as.Date("2019-04-01"),
                                 as.Date("2019-04-01"),
                                 as.Date("2019-04-01"),
                                 as.Date("2019-04-01")),
  referral_source_code = c("1","1","1","1","1","1","1"),
  date_of_removal_from_list = c(as.Date("2019-09-01"),
                                as.Date("2019-09-01"),
                                as.Date("2019-09-01"),
                                as.Date("2019-09-01"),
                                as.Date("2019-09-01"),
                                as.Date("2019-09-01"),
                                as.Date("2019-09-01"))
)

duckdb::dbWriteTable(con,
                     "fp_completed_nop",
                     fp_completed_nop_df,
                     overwrite = TRUE)

#### f_lothian_small_specs ----
f_lothian_small_specs_df <- data.frame(
  in_out = c("out","in","in"),
  nhs_board_of_sending_location_name = c("NHS LOTHIAN",
                                         "NHS LOTHIAN",
                                         "NHS FIFE"),
  specialty_code = c("D61","D61","D61"),
  date_lothian_small = c(as.Date("2019-11-01"),
                         as.Date("2019-11-01"),
                         as.Date("2019-04-01")),
  patient_type_code = c("21","01","21")
)

duckdb::dbWriteTable(con,
                     "f_lothian_small_specs",
                     f_lothian_small_specs_df,
                     overwrite = TRUE)

#### apply_publication_filters ----
apply_publication_filters_df <- data.frame(
  in_out = c("in"),

  active_deleted_record_status = c("D","A","A","A","A","A","A","A"),
  sending_location_code = c("F002A","S206H","F002A",
                            "F002A","F002A","F002A",
                            "F002A","F002A"),
  patient_type_code = c("01","01","21",
                        "01","01","01",
                        "01","01"),
  wait_error_flag_code = c(0,0,0,
                           3,0,0,
                           0,0),
  specialty_code = c("C1","C1","C1",
                     "C1","R4","C1",
                     "C1","C1"),
  waiting_time_standard_code = c("011","011","011",
                                 "011","011","072",
                                 "011","011"),
  attended_admitted_flag = c("N","N","N",
                             "N","N","N",
                             "Y","N"),

  provider_name = c("Fife","Fife","Fife",
                    "Fife","Fife","Fife",
                    "Fife","Fife"),
  nhs_board_of_sending_location_name = c("NHS FIFE","NHS FIFE","NHS FIFE",
                                         "NHS FIFE","NHS FIFE","NHS FIFE",
                                         "NHS FIFE","NHS FIFE"),
  date_of_wait_initial_start = c(as.Date("2022-10-01"),
                                 as.Date("2022-10-01"),
                                 as.Date("2022-10-01"),
                                 as.Date("2022-10-01"),
                                 as.Date("2022-10-01"),
                                 as.Date("2022-10-01"),
                                 as.Date("2022-10-01"),
                                 as.Date("2022-10-01")),
  patient_type_cohort = c("Inpatient/Day case",
                          "Inpatient/Day case",
                          "Inpatient/Day case",
                          "Inpatient/Day case",
                          "Inpatient/Day case",
                          "Inpatient/Day case",
                          "Inpatient/Day case",
                          "Inpatient/Day case"),
  patient_category_code = c("1","1","1","1","1","1","1","1"),


  date_of_referral_receipt = c(as.Date("2019-04-01"),
                               as.Date("2019-04-01"),
                               as.Date("2019-04-01"),
                               as.Date("2019-04-01"),
                               as.Date("2019-04-01"),
                               as.Date("2019-04-01"),
                               as.Date("2019-04-01"),
                               as.Date("2019-04-01")),
  web_flag = c("Y","Y","Y","Y","Y","Y","Y","Y"),
  scottish_resident_flag = c("Y","Y","Y","Y","Y","Y","Y","Y"),
  removal_reason_code = c("01","01","01","01","01","01","01","01"),
  referral_source_code = c("1","1","1","1","1","1","1","1"),
  date_of_removal_from_list = c(as.Date("2019-09-01"),
                                as.Date("2019-09-01"),
                                as.Date("2019-09-01"),
                                as.Date("2019-09-01"),
                                as.Date("2019-09-01"),
                                as.Date("2019-09-01"),
                                as.Date("2019-09-01"),
                                as.Date("2019-09-01"))

)

duckdb::dbWriteTable(con,
                     "apply_publication_filters",
                     apply_publication_filters_df,
                     overwrite = TRUE)

### Views for variable testing (r_, c_) ----

#### c_patient_type_cohort ----
c_patient_type_cohort_df <- data.frame(
  patient_type_code = c("01", "11", "21", "23")
)

duckdb::dbWriteTable(con,
                     "c_patient_type_cohort",
                     c_patient_type_cohort_df,
                     overwrite = TRUE)

#### c_patient_type_cohort ----
c_grouped_specialty_desc_df <- data.frame(
  specialty_code = c("A1","A8","C1",
                     "C3","C4","C5",
                     "E1","F3","G2",
                     "R1","T2","A2",
                     "AF","F1","G1",
                     "R8","RK","T1",
                     "T3","H1","C9"),
  specialty_desc = c(rep("other",21))
)

duckdb::dbWriteTable(con,
                     "c_grouped_specialty_desc",
                     c_grouped_specialty_desc_df,
                     overwrite = TRUE)

#### r_nhs_board_of_treatment_name ----
r_nhs_board_of_treatment_name_df <- data.frame(
  nhs_board_of_treatment_name = c("ENGLAND/WALES/NORTHERN IRELAND",
                                  "NATIONAL FACILITY",
                                  "NHS AYRSHIRE & ARRAN",
                                  "NHS BORDERS",
                                  "NHS DUMFRIES & GALLOWAY",
                                  "NHS FIFE",
                                  "NHS FORTH VALLEY",
                                  "NHS GRAMPIAN",
                                  "NHS GREATER GLASGOW & CLYDE",
                                  "NHS HIGHLAND",
                                  "NHS LANARKSHIRE",
                                  "NHS LOTHIAN",
                                  "NHS ORKNEY",
                                  "NHS SHETLAND",
                                  "NHS TAYSIDE",
                                  "NHS WESTERN ISLES",
                                  "NON-NHS PROVIDER",
                                  "NOT KNOWN"),
  specialty_code = c(rep("A7",18)),
  nhs_board_of_sending_location_name = c(rep("NHS LOTHIAN", 18))
)

duckdb::dbWriteTable(con,
                     "r_nhs_board_of_treatment_name",
                     r_nhs_board_of_treatment_name_df,
                     overwrite = TRUE)

#### r_specialty_code ----
r_specialty_code_df <- data.frame(
  specialty_code = c("C7",
                     NA)
)

duckdb::dbWriteTable(con,
                     "r_specialty_code",
                     r_specialty_code_df,
                     overwrite = TRUE)

#### r_waiting_time_standard_code ----
r_waiting_time_standard_code_df <- data.frame(
  waiting_time_standard_code = c("050",
                                 NA)
)

duckdb::dbWriteTable(con,
                     "r_waiting_time_standard_code",
                     r_waiting_time_standard_code_df,
                     overwrite = TRUE)

#### r_wait_days ----
r_wait_days_df_comp <- data.frame(
  wait_days = c(10, 20),
  patient_type_cohort = c("Inpatient/Day case",
                          "New Outpatient"),
  waiting_time_standard_code = c("023",
                                 "010")
)

duckdb::dbWriteTable(con,
                     "r_wait_days_comp",
                     r_wait_days_df_comp,
                     overwrite = TRUE)

r_wait_days_df_ongo <- data.frame(
  wait_days_at_report_date = c(10,20)
)

duckdb::dbWriteTable(con,
                     "r_wait_days_ongo",
                     r_wait_days_df_ongo,
                     overwrite = TRUE)


#### create_analysis_variables ----

create_analysis_variables_df <- data.frame(
  wait_days = c(10),
  patient_type_cohort = c("New Outpatient"),
  patient_type_code = c("01"),
  waiting_time_standard_code = c("010"),
  specialty_code = c("C7"),
  specialty_desc = c("OPHTHALMOLOGY"),
  nhs_board_of_sending_location_name = c("NHS FIFE"),
  nhs_board_of_treatment_name = c("NHS FIFE")
)

duckdb::dbWriteTable(con,
                     "create_analysis_variables",
                     create_analysis_variables_df,
                     overwrite = TRUE)

