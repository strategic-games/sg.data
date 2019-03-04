library(dplyr)

wordlist <- serialize_wordlist()
config <- create_simulation(
  title = "vocabulary",
  supplement = "Compare players with different vocabulary sizes",
  params = list(
    starter_wordlist_path = wordlist,
    starter_wordlist_prefix = 10^(1:5),
    opponent_wordlist_prefix = 10^(1:5),
    trials = 10,
    vocabulary_path = wordlist
  )
)
simulation_vocabulary <- run_simulation(config)

simulation_vocabulary %<>%
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

usethis::use_data(simulation_vocabulary, compress = "xz", overwrite=T)
