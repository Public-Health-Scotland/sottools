#' Get a lazy_tbl object from the warehouse
#'
#' @param con The dv_platform connection object
#' @param datatype A character vector specifying "SSQ", "SSM" or "LIVE"clasdfasdfasdf
#' @param wh_table One of "ongoing", "completed", "offers", "unavailability", "snapshot_details"
#'
#' @returns A lazy_tbl object representing the warehouse table
#' @export
#'
#' @examples
#' keyring::keyring_unlock(password = Sys.getenv("KEYRING_PASS"))
#'
#' con <- DBI::dbConnect(odbc::odbc(),
#'   dsn = "DVPREPROD",
#'   uid = "tunwdev01",
#'   pwd = keyring::key_get("tunwdev01_pass")
#' )
#' test <- get_wh_tbl(con, datatype = "SSM", wh_table = "ongoing")
get_wh_tbl <- function(con,
                       datatype = "SSM",
                       wh_table = "ongoing") {
  # Parameter Validation
  if (!(inherits(con, "PostgreSQL") & con@info[1]$dbname == "dv_platform") &
      !inherits(con, "SQLiteConnection")) {
    cli::cli_abort(
      "{.arg con} must be a warehouse database connection.",
      class = "wh_object_check"
    )
  }
  if (missing(datatype) & wh_table != "snapshot_details") {
    cli::cli_abort(
      "{.arg datatype} is missing with no default.",
      class = "missing_arg"
    )
  }
  if (missing(wh_table)) {
    cli::cli_abort(
      "{.arg wh_table} is missing with no default.",
      class = "missing_arg"
    )
  }
  if (!(datatype %in% c("SSM", "SSQ", "LIVE")) & wh_table != "snapshot_details") {
    cli::cli_abort(
      "{.arg datatype} must be one of \"SSM\", \"SSQ\" or \"LIVE\".",
      class = "invalid_arg"
    )
  }
  if (!(wh_table %in% c("ongoing", "completed", "offers", "unavailability", "snapshot_details"))) {
    cli::cli_abort(
      "{.arg wh_table} must be one of \"ongoing\", \"completed\", \"offers\", \"unavailability\" or \"snapshot_details\".",
      class = "invalid_arg"
    )
  }
  # warehouse table selection
  sql_table <- dplyr::case_when(
    wh_table == "ongoing" ~ "waiting_times_at_report_date",
    wh_table == "completed" ~ "waiting_times_list",
    wh_table == "offers" ~ "waiting_times_appt_offer",
    wh_table == "unavailability" ~ "waiting_times_unavailability",
    wh_table == "snapshot_details" ~ "snapshot_details"
  )
  # assemble the query text
  sql_query <- dplyr::case_when(
    wh_table == "ongoing" ~ paste0(
      "SELECT * FROM waiting_times.waiting_times_at_report_date WHERE datatype = '",
      datatype,
      "' AND dataset = '",
      "SOT",
      "' AND date_of_report_start='1000-01-01' AND date_of_report_end='3000-01-01'"
    ),
    wh_table %in% c(
      "completed",
      "offers",
      "unavailability"
    ) ~ paste0(
      "SELECT * FROM waiting_times.",
      sql_table,
      " WHERE datatype = '",
      datatype,
      "' AND dataset = 'SOT'"
    ),
    wh_table == "snapshot_details" ~ "SELECT * FROM waiting_times.snapshot_details"
  )
  # create lazy_tbl
  tbl <- dplyr::tbl(con, dplyr::sql(sql_query))
}
