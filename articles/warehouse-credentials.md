# Store Warehouse Credentials

In order to be able to access the dv platform using sottools you need to
first securely save your LDAP credentials in a place where they can be
picked up by
[`wh_connection()`](https://public-health-scotland.github.io/sottools/reference/wh_connection.md).

## Saving LDAP username

The first thing you need to do is save your LDAP username as an
environment variable. Environment variables are kept in your .Renviron
file which can be opened by running `usethis::edit_r_environ()`. Open
this file and add the following line with your LDAP username:

``` r

LDAP_username = "<your-ldap-username>"
```

## Creating keyring

Install the keyring package using `pak::pak("keyring")` if you don’t
have it already and load it
([`library(keyring)`](https://keyring.r-lib.org/)).

``` r

# Create a keyring called warehouse. You will be promped to set a password.
# This password can be whatever so make it different to your LDAP.
# It doesn't need to be memorable as you are about to store it in your .Renviron
keyring_create("warehouse")

# Add a secret called "LDAP_password" to this keyring. When prompted enter your LDAP password.
key_set("LDAP_password", keyring = "warehouse")

# Lock keyring
keyring_lock(keyring = "warehouse")
```

## Add keyring password to .Renviron

Now add the password you just set for your warehouse keyring (i.e. not
your LDAP password) to your .Renviron file
(`usethis::edit_r_environ()`). This is stored in plain text but your
.Renviron file is unique to your and only available to you from within
your posit session.

``` r

WH_KEYRING_PASS = "<new-keyring-password>"
```

## Restart R

To allow the changes to take effect you need to restart R
(ctrl+shift+F10)
