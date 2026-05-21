s_performance <- function(df) {

  df <- df |>
    summarise(waits = n(),
              over_12_weeks = sum(if_else(wait_days > 84, 1, 0), na.rm = TRUE),
              over_16_weeks = sum(if_else(wait_days > 112, 1, 0), na.rm = TRUE),
              median = quantile(wait_days, 0.5, na.rm = TRUE),
              p_90 = quantile(wait_days, 0.9, na.rm = TRUE))

}
