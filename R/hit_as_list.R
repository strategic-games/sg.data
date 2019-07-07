hit_as_list <- function(h) {
  list(
    row = h$place$row,
    column = h$place$column,
    direction = h$place$direction,
    words = list(h$words)
  )
}
