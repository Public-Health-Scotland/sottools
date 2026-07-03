test_that("f_borders_small_specs filters the right records", {

  df <- dplyr::tbl(test_con, "f_borders_small_specs") |>
    f_borders_small_specs() |>
    dplyr::collect()

  expect_filter(df)
})

test_that("fp_nop_small_specs filters the right records", {

  df <- dplyr::tbl(test_con, "fp_nop_small_specs") |>
    dplyr::filter(!!fp_nop_small_specs()) |>
    dplyr::collect()

  expect_filter(df)
})

test_that("fp_oph_excl filters the right records", {

  df <- dplyr::tbl(test_con, "fp_oph_excl") |>
    dplyr::filter(!!fp_oph_excl()) |>
    dplyr::collect()

  expect_filter(df)
})

test_that("fp_nop_wts filters the right records", {

  df <- dplyr::tbl(test_con, "fp_nop_wts") |>
    dplyr::filter(!!fp_nop_wts()) |>
    dplyr::collect()

  expect_filter(df)
})

test_that("fp_nop_completed_old_referral_sources filters the right records", {

  df <- dplyr::tbl(test_con, "fp_nop_completed_old_referral_sources") |>
    dplyr::filter(!!fp_nop_completed_old_referral_sources()) |>
    dplyr::collect()

  expect_filter(df)
})

test_that("fp_nop_ongoing_old_referral_sources filters the right records", {

  df <- dplyr::tbl(test_con, "fp_nop_ongoing_old_referral_sources") |>
    dplyr::filter(!!fp_nop_ongoing_old_referral_sources()) |>
    dplyr::collect()

  expect_filter(df)
})

test_that("fp_ipdc_wts filters the right records", {

  df <- dplyr::tbl(test_con, "fp_ipdc_wts") |>
    dplyr::filter(!!fp_ipdc_wts()) |>
    dplyr::collect()

  expect_filter(df)
})

test_that("fp_ipdc_wts filters the right records", {

  df <- dplyr::tbl(test_con, "fp_ongoing_ipdc") |>
    dplyr::filter(!!fp_ongoing_ipdc()) |>
    dplyr::collect()

  expect_filter(df)
})

test_that("fp_completed_ipdc filters the right records", {

  df <- dplyr::tbl(test_con, "fp_completed_ipdc") |>
    dplyr::filter(!!fp_completed_ipdc()) |>
    dplyr::collect()

  expect_filter(df)
})

test_that("fp_add_rem_nop filters the right records", {

  df <- dplyr::tbl(test_con, "fp_add_rem_nop") |>
    dplyr::filter(!!fp_add_rem_nop()) |>
    dplyr::collect()

  expect_filter(df)
})

test_that("fp_ongoing_nop filters the right records", {

  df <- dplyr::tbl(test_con, "fp_ongoing_nop") |>
    dplyr::filter(!!fp_ongoing_nop()) |>
    dplyr::collect()

  expect_filter(df)
})

test_that("fp_completed_nop filters the right records", {

  df <- dplyr::tbl(test_con, "fp_completed_nop") |>
    dplyr::filter(!!fp_completed_nop()) |>
    dplyr::collect()

  expect_filter(df)
})

test_that("f_lothian_small_specs filters the right records", {

  df <- dplyr::tbl(test_con, "f_lothian_small_specs") |>
    f_lothian_small_specs() |>
    dplyr::collect()

  expect_filter(df)
})
