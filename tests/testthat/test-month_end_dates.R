test_that("month_end_date() validates arguments", {
  expect_error(month_end_dates(end_date = "character", n_months = 4),
               class = "invalid_arg")
  expect_error(month_end_dates(start_date = "character", n_months = 4),
               class = "invalid_arg")
  expect_error(month_end_dates(start_date = as.Date("2025-03-31"), n_months = "character"),
               class = "invalid_arg")
  expect_error(month_end_dates(n_months = 3),
               class = "missing_args")
  expect_error(month_end_dates(start_date = as.Date("2025-03-31"),
                               end_date = as.Date("2026-03-31"),
                               n_months = 100),
               class = "inconsistent_args")
})

test_that("month_end_date() returns an object of class Date", {
  expect_s3_class(month_end_dates(end_date = lubridate::dmy("31-03-2026"), n_months = 4), "Date")
})

test_that("simple uses of month_end_date() return expected values", {
  expect_equal(month_end_dates(start_date = lubridate::dmy("31-03-2026"),
                               end_date = lubridate::dmy("30-04-2026")),
               lubridate::ymd(c("2026-03-31", "2026-04-30")))
  expect_equal(month_end_dates(start_date = lubridate::dmy("31-03-2026"),
                               n_months = 3),
               lubridate::ymd(c("2026-03-31",
                                "2026-04-30",
                                "2026-05-31")))
  expect_equal(month_end_dates(end_date = lubridate::dmy("31-03-2026"), n_months = 4),
               lubridate::ymd(c("2025-12-31",
                                "2026-01-31",
                                "2026-02-28",
                                "2026-03-31")))

})
