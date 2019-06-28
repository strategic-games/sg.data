# packages
library(tidyverse)
library(usethis)
library(sg.simulate)

set.seed(3825)

# Spielermerkmale
# Wortschatzgrößen
vocabulary_size <- -2:2*15000+50000
# Spielerstrategien
strategies <- c("random", "min_places", "availability")
wordlist <- serialize_wordlist()
grid <- list(
  start_letters_origin = c("random", "human"),
  board_size = as.integer(c(8, 10)),
  word_min_length = list(list(first=5, other=4), list(first=4, other=3)),
  direction_restrictions = list(
    list(first="starter", other="none"), list(first="fixed", other="none")
  ),
  starter_prefix = vocabulary_size,
  starter_strategy = strategies,
  opponent_prefix = vocabulary_size,
  opponent_strategy = strategies
) %>%
cross()

conditions <- grid %>%
lapply(function(x) {
  new(strategic_games.Simulation.Condition,
    start_letters = generate_start_letters(x[["start_letters_origin"]]),
    board_size = x[["board_size"]],
    word_min_length = do.call(
      strategic_games.Simulation.Condition.WordMinLength$new,
      x[["word_min_length"]]
    ),
    direction_restrictions = do.call(
      strategic_games.Simulation.Condition.DirectionRestrictions$new,
      x[["direction_restrictions"]]
    ),
    starter = new(strategic_games.Simulation.Condition.Player,
      vocabulary = new(strategic_games.Vocabulary,
        path = wordlist,
        prefix = x[["starter_prefix"]]
      ),
      begriffixStrategy = x[["starter_strategy"]]
    ),
    opponent = new(strategic_games.Simulation.Condition.Player,
      vocabulary = new(strategic_games.Vocabulary,
        path = wordlist,
        prefix = x[["opponent_prefix"]]
      ),
      begriffixStrategy = x[["opponent_strategy"]]
    ),
    trials = 10,
    vocabulary = new(strategic_games.Vocabulary,
      path = wordlist
    )
  )
})

config <- new(strategic_games.Simulation,
  info = new(strategic_games.Simulation.Info,
    title = "Thesis-Simulation",
    supplement = "multifaktorielles Variablendesign"
  ),
  conditions = conditions
)

raw <- run_simulation(config)

simulation_thesis <- raw %>%
extract_message() %>%
simulation2df() %>%
mutate_at(
  vars(starter_path, opponent_path, vocabulary_path),
  recode_factor, .default = "Derewo_Wortformen"
) %>%
rename(
  starter_wordlist_name = starter_path,
  opponent_wordlist_name = opponent_path,
  vocabulary_name = vocabulary_path
) %>%
add_column(
  start_letters_origin = rep(
    map_chr(grid, "start_letters_origin"),
    each = 10),
  .after = 3
)

# Save moves and hits separately for faster loading
thesis_moves <- simulation_thesis %>%
unnest(trials) %>%
select(-trial) %>%
unnest(moves, .id = "game") %>%
group_by(game) %>%
mutate(move = seq_len(n()))

thesis_hits <- thesis_moves %>%
select(game, move, hits) %>%
unnest(hits)

thesis_moves %<>% select(1:19, 25, 20:23)

use_data(simulation_thesis, overwrite = T, compress = "xz")
use_data(thesis_moves, overwrite = T, compress = "xz")
use_data(thesis_hits, overwrite = T, compress = "xz")
