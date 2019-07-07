condition_as_list <- function (c) {
  list(
    start_letters = c$start_letters,
    board_size = c$board_size,
    starter_size = c$starter$vocabulary$prefix,
    starter_strategy = c$starter$begriffixStrategy,
    opponent_size = c$opponent$vocabulary$prefix,
    opponent_strategy = c$opponent$begriffixStrategy,
    word_min_length_first = c$word_min_length$first,
    word_min_length_other = c$word_min_length$other,
    direction_restrictions_first = c$direction_restrictions$first,
    direction_restrictions_other = c$direction_restrictions$other
  )
}
