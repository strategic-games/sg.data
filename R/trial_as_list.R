trial_as_list <- function(t) {
  stopifnot(requireNamespace("purrr", quietly = TRUE))
  moves <- purrr::map_dfr(t$moves, move_as_list, .id = "move")
  list(
    condition = t$condition,
    trial = t$trial,
    moves = list(moves)
  )
}
