assign_labels <- function(df, vars, values) {
  stopifnot(requireNamespace("purrr", quietly = TRUE))
  purrr::modify_at(
    df, vars,
    factor, levels = as.integer(values), labels = names(values)
  )
}
