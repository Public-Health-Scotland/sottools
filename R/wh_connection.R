#' Connect to the warehouse
#'
#' `wh_connection()` extablishes a database connection object for the
#' national waiting times data mart.
#'
#' @returns A DVPROD connection object
#' @export
#'
#' @examples
#' con <- wh_connection()
wh_connection <- function() {
  keyring::keyring_unlock(keyring = "warehouse",
                          password = Sys.getenv("WH_KEYRING_PASS"))
  con <- DBI::dbConnect(odbc::odbc(),
                        dsn="DVPROD",
                        uid=Sys.getenv("LDAP_username"),
                        pwd=keyring::key_get("LDAP_password",
                                             keyring = "warehouse"))
  keyring::keyring_lock(keyring = "warehouse")
  con
}
