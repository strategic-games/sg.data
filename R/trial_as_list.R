trial_as_list <- function(t, direction_levels, direction_labels) {
  stopifnot(requireNamespace("purrr", quietly = TRUE))
  stopifnot(requireNamespace("tibble", quietly = TRUE))
  moves <- purrr::map_dfr(t$moves, move_as_list, direction_levels = direction_levels, direction_labels = direction_labels)
  moves <- purrr::modify_if(moves, is.double, as.integer)
  moves <- tibble::rowid_to_column(moves, var = "move_id")
  moves <- purrr::modify_at(
    moves, "direction",
    factor, levels = direction_levels, labels = direction_labels
  )
  list(
    condition = t$condition,
    trial = t$trial,
    moves = list(moves)
  )
}
