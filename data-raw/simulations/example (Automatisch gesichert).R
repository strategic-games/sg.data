wordlist <- serialize_wordlist()
params <- list(
  starter_wordlist_path = wordlist,
  starter_wordlist_prefix = 10^(1:5),
  opponent_wordlist_prefix = 10^(1:5),
  trials = 5
)
config <- create_simulation(title = "vocabulary", params = params)
simulation_vocabulary <- run_simulation(config)
usethis::use_data(simulation_vocabulary, compress = "xz")
