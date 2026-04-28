#' Get a lazy tbl object from the warehouse
#'
#' @param con The database connection object
#' @param datatype A character vector specifying "SSQ", "SSM" or "LIVE"
#' @param wh_table
#'
#' @returns A lazy tbl
#' @export
#'
#' @examples
#' test <- get_wh_tbl(con, datatype = "SSM", wh_table = "ongoing")
get_wh_tbl <- function(con, datatype, wh_table) {

  sql_table <- dplyr::case_when(
    wh_table == "ongoing" ~ "waiting_times_at_report_date",
    wh_table == "completed" ~ "waiting_times_list",
    wh_table == "offers" ~ "waiting_times_appt_offer",
    wh_table == "unavailability" ~ "waiting_times_unavailability",
    wh_table == "snapshot_details" ~ "snapshot_details"
  )

  sql_query <- dplyr::case_when(

    wh_table == "ongoing" ~ paste0("SELECT * FROM waiting_times.waiting_times_at_report_date WHERE datatype = '",
                                   datatype,
                                   "' AND dataset = '",
                                   "SOT",
                                   "' AND date_of_report_start='1000-01-01' AND date_of_report_end='2130-01-01'"),

    wh_table %in% c("completed",
                    "offers",
                    "unavailability") ~ paste0("SELECT * FROM waiting_times.",
                                               sql_table,
                                               " WHERE datatype = '",
                                               datatype,
                                               "' AND dataset = 'SOT'"),

    wh_table == "snapshot_details" ~ "SELECT * FROM waiting_times.snapshot_details"

  )

  tbl <- dplyr::tbl(con, dplyr::sql(sql_query))

  tbl

}
