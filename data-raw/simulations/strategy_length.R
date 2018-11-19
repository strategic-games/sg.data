library(tidyverse)

wordlist <- serialize_wordlist()
vocabulary <- new(strategic_games.Vocabulary,
  path = wordlist
)
strategies <- c("short", "long")

conditions <- list(
  start_letters = start_letters,
  starter_strategy = strategies,
  opponent_strategy = strategies
) %>%
cross() %>%
map(function(x) {
  condition = new(strategic_games.Simulation.Condition,
    start_letters = x$start_letters,
    starter = new(strategic_games.Simulation.Condition.Player,
      vocabulary = vocabulary,
      begriffixStrategy = x$starter_strategy
    ),
    opponent = new(strategic_games.Simulation.Condition.Player,
      vocabulary = vocabulary,
      begriffixStrategy = x$opponent_strategy
    ),
    trials = 5,
    vocabulary = vocabulary
  )
})

config <- new(strategic_games.Simulation,
  info = new(strategic_games.Simulation.Info,
    title = "Strategies (long and short)",
    supplement = "Compare players with same vocabulary sizes and different strategies"
  ),
  conditions = conditions
)

simulation_strategy <- run_simulation(config)

simulation_strategy %<>%
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
)

usethis::use_data(simulation_strategy, compress = "xz", overwrite=T)

# Example
simulation_strategy %>%
mutate(move_count = map_int(moves, nrow)) %>%
group_by(starter_begriffixStrategy, opponent_begriffixStrategy) %>%
summarize_at("move_count", funs(min, median, max))
