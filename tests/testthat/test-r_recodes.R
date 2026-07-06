test_that("r_nhs_board_of_treatment_name creates the required variable", {

  df_comp <- dplyr::tbl(test_con, "r_nhs_board_of_treatment_name") |>
    r_nhs_board_of_treatment_name(pub_table = "completed") |>
    dplyr::collect()

  expect_true("nhs_board_of_treatment_name" %in% names(df_comp))
  expect_equal(dplyr::pull(df_comp["nhs_board_of_treatment_name"]),
               c("Outside Scotland",
                 "NHS Golden Jubilee",
                 "NHS Ayrshire & Arran",
                 "NHS Borders",
                 "NHS Dumfries & Galloway",
                 "NHS Fife",
                 "NHS Forth Valley",
                 "NHS Grampian",
                 "NHS Greater Glasgow & Clyde",
                 "NHS Highland",
                 "NHS Lanarkshire",
                 "NHS Lothian",
                 "NHS Orkney",
                 "NHS Shetland",
                 "NHS Tayside",
                 "NHS Western Isles",
                 "Non-NHS Provider",
                 "Not known"))

  df_ongo <- dplyr::tbl(test_con, "r_nhs_board_of_treatment_name") |>
    r_nhs_board_of_treatment_name(pub_table = "ongoing") |>
    dplyr::collect()

  expect_equal(dplyr::pull(df_ongo["nhs_board_of_treatment_name"]),
               c("Outside Scotland",
                 "NHS Golden Jubilee",
                 "NHS Ayrshire & Arran",
                 "NHS Borders",
                 "NHS Dumfries & Galloway",
                 "NHS Fife",
                 "NHS Lothian",
                 "NHS Grampian",
                 "NHS Greater Glasgow & Clyde",
                 "NHS Highland",
                 "NHS Lanarkshire",
                 "NHS Lothian",
                 "NHS Orkney",
                 "NHS Shetland",
                 "NHS Tayside",
                 "NHS Western Isles",
                 "Non-NHS Provider",
                 "Not known"))

})

test_that("r_specialty_code creates the required variable", {

  df <- dplyr::tbl(test_con, "r_specialty_code") |>
    r_specialty_code() |>
    dplyr::collect()

  expect_true("specialty_code" %in% names(df))
  expect_equal(dplyr::pull(df["specialty_code"]),
               c("C7",
                 "BLANK"))

})

test_that("r_waiting_time_standard_code creates the required variable", {

  df <- dplyr::tbl(test_con, "r_waiting_time_standard_code") |>
    r_waiting_time_standard_code() |>
    dplyr::collect()

  expect_true("waiting_time_standard_code" %in% names(df))
  expect_equal(dplyr::pull(df["waiting_time_standard_code"]),
               c("050",
                 "000"))

})

test_that("r_wait_days creates the required variable", {

  df_comp <- dplyr::tbl(test_con, "r_wait_days_comp") |>
    r_wait_days(pub_table = "completed") |>
    dplyr::collect()

  df_ongo <- dplyr::tbl(test_con, "r_wait_days_ongo") |>
    r_wait_days(pub_table = "ongoing") |>
    dplyr::collect()

  expect_true("wait_days" %in% names(df_comp))
  expect_equal(dplyr::pull(df_comp["wait_days"]),
               c(0,
                 20))

  expect_true("wait_days" %in% names(df_ongo))
  expect_equal(dplyr::pull(df_ongo["wait_days"]),
               c(10,
                 20))

})
