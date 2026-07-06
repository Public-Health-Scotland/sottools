test_that("get_wh_tbl() insists on a dv_platform connection", {
  withr::local_package("odbc")
  fake_con <- new("PostgreSQL", info = list(dbname = "wrong_name"))
  expect_error(get_wh_tbl(fake_con, snapshot_live = "SSM", view = "ongoing"),
               class = "wh_object_check")
})

test_that("argument names are validated", {
  withr::local_package("odbc")
  fake_con <- new("PostgreSQL", info = list(dbname = "dv_platform"))

  expect_error(get_wh_tbl(fake_con, snapshot_live = "WRONG", view = "ongoing"),
               class = "invalid_arg")
  expect_error(get_wh_tbl(fake_con, snapshot_live = "SSM", view = "WRONG"),
               class = "invalid_arg")
})

test_that("missing arguments are caught", {
  withr::local_package("odbc")
  fake_con <- new("PostgreSQL", info = list(dbname = "dv_platform"))

  expect_error(get_wh_tbl(fake_con, view = "ongoing"),
               class = "missing_arg")
  expect_error(get_wh_tbl(fake_con, snapshot_live = "SSM"),
               class = "missing_arg")
})
