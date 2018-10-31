wordlist <- serialize_wordlist()
config <- create_simulation(
  title = "vocabulary",
  supplement = "Compare players with different vocabulary sizes",
  params = list(
    starter_wordlist_path = wordlist,
    starter_wordlist_prefix = 10^(1:5),
    opponent_wordlist_prefix = 10^(1:5),
    trials = 10
  )
)
simulation_vocabulary <- run_simulation(config)
usethis::use_data(simulation_vocabulary, compress = "xz", overwrite=T)
