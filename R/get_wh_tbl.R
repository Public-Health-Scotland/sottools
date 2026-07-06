#' Get a lazy_tbl object from the warehouse
#'
#' @param con The dv_platform connection object
#' @param snapshot_live A character vector specifying "SSQ", "SSM" or "LIVE"
#' @param view One of "ongoing", "completed", "offers", "unavailability", "snapshot_details"
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
#' test <- get_wh_tbl(con, snapshot_live = "SSM", view = "ongoing")
get_wh_tbl <- function(con,
                       snapshot_live = "SSM",
                       view = "ongoing") {
  # Parameter Validation
  if (!(inherits(con, "PostgreSQL") & con@info[1]$dbname == "dv_platform") &
      !inherits(con, "SQLiteConnection")) {
    cli::cli_abort(
      "{.arg con} must be a warehouse database connection.",
      class = "wh_object_check"
    )
  }
  if (missing(snapshot_live) & view != "snapshot_details") {
    cli::cli_abort(
      "{.arg snapshot_live} is missing with no default.",
      class = "missing_arg"
    )
  }
  if (missing(view)) {
    cli::cli_abort(
      "{.arg view} is missing with no default.",
      class = "missing_arg"
    )
  }
  if (!(snapshot_live %in% c("SSM", "SSQ", "LIVE")) & view != "snapshot_details") {
    cli::cli_abort(
      "{.arg snapshot_live} must be one of \"SSM\", \"SSQ\" or \"LIVE\".",
      class = "invalid_arg"
    )
  }
  if (!(view %in% c("ongoing", "completed", "offers", "unavailability", "snapshot_details"))) {
    cli::cli_abort(
      "{.arg view} must be one of \"ongoing\", \"completed\", \"offers\", \"unavailability\" or \"snapshot_details\".",
      class = "invalid_arg"
    )
  }
  # warehouse table selection
  sql_table <- dplyr::case_when(
    view == "ongoing" ~ "waiting_times_at_report_date",
    view == "completed" ~ "waiting_times_list",
    view == "offers" ~ "waiting_times_appt_offer",
    view == "unavailability" ~ "waiting_times_unavailability",
    view == "snapshot_details" ~ "snapshot_details"
  )
  # assemble the query text
  sql_query <- dplyr::case_when(
    view == "ongoing" ~ paste0(
      "SELECT * FROM waiting_times.waiting_times_at_report_date WHERE datatype = '",
      snapshot_live,
      "' AND dataset = '",
      "SOT",
      "' AND date_of_report_start='1000-01-01' AND date_of_report_end='3000-01-01'"
    ),
    view %in% c(
      "completed",
      "offers",
      "unavailability"
    ) ~ paste0(
      "SELECT * FROM waiting_times.",
      sql_table,
      " WHERE datatype = '",
      snapshot_live,
      "' AND dataset = 'SOT'"
    ),
    view == "snapshot_details" ~ "SELECT * FROM waiting_times.snapshot_details"
  )
  # create lazy_tbl
  tbl <- dplyr::tbl(con, dbplyr::sql(sql_query))
}
