### create .duckdb file for test data

duckdb::duckdb(test_path("fixtures", "test_db.duckdb"))

con <- DBI::dbConnect(duckdb::duckdb(),
                      dbdir = test_path("fixtures", "test_db.duckdb"))

### f_borders_small_specs

f_borders_small_specs_df <- data.frame(
  in_out = c("out", "out", "in"),
  provider_name = c("Borders", "Borders", "Borders"),
  specialty_code = c("AD", "J4", "C1")
)

duckdb::dbWriteTable(con,
                     "f_borders_small_specs",
                     f_borders_small_specs_df,
                     overwrite = TRUE)

### fp_nop_small_specs_df
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

### fp_oph_excl
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

### fp_nop_wts
fp_nop_wts_df <- data.frame(
  in_out = c("in", "out"),
  date_of_wait_initial_start = c(as.Date("2019-09-01"), as.Date("2020-10-01")),
  waiting_time_standard_code = c("050", "050")
)

duckdb::dbWriteTable(con,
                     "fp_nop_wts",
                     fp_nop_wts_df,
                     overwrite = TRUE)

### fp_nop_completed_old_referral_sources
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

### fp_nop_completed_old_referral_sources
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

### fp_nop_completed_old_referral_sources
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


### fp_ongoing_ipdc
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

### fp_completed_ipdc
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

### fp_add_rem_nop
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

### fp_ongoing_nop
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

### fp_completed_nop
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

### f_lothian_small_specs
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
