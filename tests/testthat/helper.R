test_con <- DBI::dbConnect(duckdb::duckdb(),
                           dbdir = test_path("fixtures", "test_db.duckdb"))

expect_filter <- function(df) {
  expect_equal(dplyr::pull(dplyr::distinct(df["in_out"])), "in")
}
