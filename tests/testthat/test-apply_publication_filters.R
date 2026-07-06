test_that("apply_publication_filters filters the right records", {

  df <- dplyr::tbl(test_con, "apply_publication_filters") |>
    apply_publication_filters(pub_table = "completed") |>
    dplyr::collect()

  expect_filter(df)
})

# Parameter validation tests
test_that("apply_publication_filters() insists on a dv_platform connection", {
  fake_wh_tbl <- data.frame(non_lazy_data = c(1,2,3))
  expect_error(apply_publication_filters(fake_wh_tbl,
                                         pub_table = "completed"),
               class = "tbl_lazy_check")
})

test_that("argument names are validated", {
  fake_wh_tbl <- data.frame()
  class(fake_wh_tbl) <- "tbl_lazy"

  expect_error(apply_publication_filters(fake_wh_tbl,
                                         pub_table = "WRONG"),
               class = "invalid_arg")
})

test_that("missing arguments are caught", {
  fake_wh_tbl <- data.frame()
  class(fake_wh_tbl) <- "tbl_lazy"

  expect_error(apply_publication_filters(fake_wh_tbl),
               class = "missing_arg")
  expect_error(apply_publication_filters(fake_wh_tbl),
               class = "missing_arg")
})
