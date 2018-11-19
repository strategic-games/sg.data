library(purrr)

wordlist <- serialize_wordlist()
vocabulary_size <- rnorm(100, 50000, 15000)
conditions <- cross_df(list(
  starter_prefix = vocabulary_size,
  opponent_prefix = vocabulary_size
)) %>%
add_column(
  start_letters = sample(start_letters, size=10000, replace = T)
) %>%
transpose() %>%
map(function(x) {
  condition = new(strategic_games.Simulation.Condition,
    start_letters = x$start_letters,
    starter = new(strategic_games.Simulation.Condition.Player,
      vocabulary = new(strategic_games.Vocabulary,
        path = wordlist,
        prefix = x$starter_prefix
      )
    ),
    opponent = new(strategic_games.Simulation.Condition.Player,
      vocabulary = new(strategic_games.Vocabulary,
        path = wordlist,
        prefix = x$opponent_prefix
      )
    ),
    trials = 1,
      vocabulary = new(strategic_games.Vocabulary,
        path = wordlist
      )
  )
})

config <- new(strategic_games.Simulation,
  info = new(strategic_games.Simulation.Info,
    title = "vocabulary (normal)",
    supplement = "Compare players with different vocabulary sizes, drawn from normally distributed population"
  ),
  conditions = conditions
)

simulation_vocabulary_normal <- run_simulation(config)

simulation_vocabulary_normal %<>%
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

usethis::use_data(simulation_vocabulary_normal, compress = "xz", overwrite=T)
