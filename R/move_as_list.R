move_as_list <- function(m) {
  stopifnot(requireNamespace("purrr", quietly = TRUE))
  hits <- purrr::map_dfr(m$hits, hit_as_list)
  list(
    row = m$place$row,
    column = m$place$column,
    direction = m$place$direction,
    word = m$word,
    hits = list(hits)
  )
}
