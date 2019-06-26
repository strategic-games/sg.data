library(RProtoBuf)
library(sg.simulate)
library(tidyverse)

wordlist <- serialize_wordlist()
vocabulary <- strategic_games.Vocabulary$new(
      path = wordlist
    )

condition <- strategic_games.Simulation.Condition$new(
  start_letters = generate_start_letters(),
  board_size = 8,
  starter = strategic_games.Simulation.Condition.Player$new(
    vocabulary = vocabulary
  ),
  opponent = strategic_games.Simulation.Condition.Player$new(
    vocabulary = vocabulary
  ),
  trials = 10,
  vocabulary = vocabulary
)

config <- strategic_games.Simulation$new(
  info = strategic_games.Simulation.Info$new(
    title = "Example Simulation"
  ),
  conditions = list(condition)
)

results <- run_simulation(config, save = "simulation_example.pb.gz")

simulation_thesis <- raw %>%
simulation2df() %>%
add_column(
  start_letters_origin = rep(
    map_chr(grid, "start_letters_origin"),
    each = 10),
  .after = 3
)

usethis::use_data(simulation_thesis, compress = "xz", overwrite=T)

