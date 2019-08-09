move_as_list <- function(m, direction_levels, direction_labels) {
  stopifnot(requireNamespace("purrr", quietly = TRUE))
  hits <- purrr::map_dfr(m$hits, hit_as_list)
  hits <- purrr::modify_if(hits, is.double, as.integer)
  hits <- purrr::modify_at(
    hits, "direction",
    factor, levels = direction_levels, labels = direction_labels
  )
  list(
    row = m$place$row,
    column = m$place$column,
    direction = m$place$direction,
    word = m$word,
    hits = list(hits)
  )
}
