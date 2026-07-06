# Parameter validation tests
test_that("create_analysis_variables() insists on a dv_platform connection", {
  fake_wh_tbl <- data.frame(non_lazy_data = c(1,2,3))
  expect_error(create_analysis_variables(fake_wh_tbl,
                                         pub_table = "completed"),
               class = "tbl_lazy_check")
})

test_that("argument names are validated", {
  fake_wh_tbl <- data.frame()
  class(fake_wh_tbl) <- "tbl_lazy"

  expect_error(create_analysis_variables(fake_wh_tbl,
                                         pub_table = "WRONG"),
               class = "invalid_arg")
})

test_that("missing arguments are caught", {
  fake_wh_tbl <- data.frame()
  class(fake_wh_tbl) <- "tbl_lazy"

  expect_error(create_analysis_variables(fake_wh_tbl),
               class = "missing_arg")
  expect_error(create_analysis_variables(fake_wh_tbl),
               class = "missing_arg")
})
