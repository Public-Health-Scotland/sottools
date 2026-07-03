test_that("apply_publication_filters filters the right records", {

  df <- dplyr::tbl(test_con, "apply_publication_filters") |>
    apply_publication_filters(table = "completed") |>
    dplyr::collect()

  expect_filter(df)
})
