#' wh_connection
#'
#' @returns A DVPROD connection object
#' @export
#'
#' @examples
#' con <- wh_connection()
wh_connection <- function() {
  keyring::keyring_unlock(password = Sys.getenv("KEYRING_PASS"))
  con <- DBI::dbConnect(odbc::odbc(),
                        dsn="DVPROD",
                        uid=Sys.getenv("LDAP_username"),
                        pwd=keyring::key_get("LDAP_password"))
  keyring::keyring_lock()
  con
}
