# packages
library(tidyverse)
library(magrittr)

set.seed(3825)
wordlist <- serialize_wordlist()
vocabulary <- new(strategic_games.Vocabulary,
  path = wordlist
)

# Unabhängige Variablen
# Wortschatzgrößen
vocabulary_size_stddev <- function() {
  m <- 50000
  s <- 15000
  seq(m-2*s, m+2*s, by = s)
}
vocabulary_size <- vocabulary_size_stddev()
# Spielerstrategien
strategies <- c("random", "min_places", "availability")
# Spielfeldgrößen
board_size <- as.integer(c(8, 10))
# Mindestwortlängen
word_min_lengths <- list(
  strategic_games.Simulation.Condition.WordMinLength$new(
    restricted = 5, liberal = 4
  ),
  strategic_games.Simulation.Condition.WordMinLength$new(
    restricted = 4, liberal = 3
  )
)
# Startbuchstaben
start_letters_origin <- c("human", "random")
sl_random <- function() {
  DeReChar %>%
  slice(-31) %$%
  sample(G, size = 4, prob = RF) %>%
  paste0(collapse = "")
}
sl <- function(x) {
  switch(x,
    "human" = sample(start_letters, size = 1, replace = T),
    "random" = sl_random()
  )
}

# Kombinieren
var_list <- list(
  start_letters_origin = start_letters_origin,
  starter_prefix = vocabulary_size,
  starter_strategy = strategies,
  opponent_prefix = vocabulary_size,
  opponent_strategy = strategies,
  board_size = board_size,
  word_min_length = word_min_lengths
)
start_letters_rep <- var_list %>%
cross_df() %$%
rep(start_letters_origin, each = 10)

conditions <- var_list %>%
cross() %>%
map(function(x) {
  new(strategic_games.Simulation.Condition,
    start_letters = sl(x$start_letters_origin),
    starter = new(strategic_games.Simulation.Condition.Player,
      vocabulary = new(strategic_games.Vocabulary,
        path = wordlist,
        prefix = x$starter_prefix
      ),
      begriffixStrategy = x$starter_strategy
    ),
    opponent = new(strategic_games.Simulation.Condition.Player,
      vocabulary = new(strategic_games.Vocabulary,
        path = wordlist,
        prefix = x$opponent_prefix
      ),
      begriffixStrategy = x$opponent_strategy
    ),
    trials = 10,
    vocabulary = vocabulary,
    board_size = x$board_size,
    word_min_length = x$word_min_length
  )
})

config <- new(strategic_games.Simulation,
  info = new(strategic_games.Simulation.Info,
    title = "Thesis-Simulation",
    supplement = "multifaktorielles Variablendesign"
  ),
  conditions = conditions
)

simulation_thesis <- run_simulation(config)
raw <- simulation_thesis

simulation_thesis %<>%
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
add_column(start_letters_origin = start_letters_rep, .after = 3)

usethis::use_data(simulation_thesis, compress = "xz", overwrite=T)
