## ---- Seed rng
seed <- 5384
set.seed(seed)

## ---- Load packages
library("pipeR")
library(purrr)
library("RProtoBuf")

# Load proto schema
readProtoFiles2(
  files = system.file("proto/SimulationSchema.proto", package = "sg.data"),
  protoPath = Sys.getenv("PROTO_INCLUDE_PATH")
)

# Get some type descriptors
Vocabulary <- P("strategic_games.Vocabulary")
WordLists <- P("strategic_games.WordLists")
Simulation <- P("strategic_games.Simulation")
Results <- P("strategic_games.SimulationResults")

## ---- Get names and values of relevant enums
strategies <- as.list(Simulation$Condition$Player$BegriffixStrategy)
restrictions <- as.list(Simulation$Condition$DirectionRestrictions$Mode)
directions <- as.list(Results$Place$Direction)

## ---- Load word list data
data(DEREWO_Wortformen)
wl_key <- "derewo"
wordlists <- new(WordLists,
  entries = list(
    new(WordLists$Entry,
      key = wl_key, value = DEREWO_Wortformen$word
    )
  )
)

## ---- Build the simulation config
info <- new(Simulation$Info,
  title = "Thesis-Simulation-dir",
  supplement = "Begriffix-Ergebnisse abhängig von der Ausrichtungseinschränkung im ersten Zug",
  random_seed = seed
)

word_min_length <- new(
  Simulation$Condition$WordMinLength,
  first = 5, other = 4
)
player_vocabulary <- new(Vocabulary,
  key = wl_key, prefix = 50000
)

n <- 10000
conditions <- list(
  direction_restrictions = list(
    new(
      Simulation$Condition$DirectionRestrictions,
      first = "none", other = "none"
    ),
    new(
      Simulation$Condition$DirectionRestrictions,
      first = "starter", other = "none"
    ),
    new(
      Simulation$Condition$DirectionRestrictions,
      first = "fixed", other = "none"
    )
  ),
  player = list(
    new(Simulation$Condition$Player,
      vocabulary = player_vocabulary,
      begriffixStrategy = "random"
    ),
    new(Simulation$Condition$Player,
      vocabulary = player_vocabulary,
      begriffixStrategy = "min_places"
    )
  ),
  start_letters = sg.data::generate_start_letters(type = "pair", n = n)
) %>>%
cross() %>>%
map(~new(Simulation$Condition,
  trials = 1,
  start_letters = .[["start_letters"]],
  board_size = 8,
  word_min_length = word_min_length,
  direction_restrictions = .[["direction_restrictions"]],
  vocabulary = new(Vocabulary, key = wl_key),
  starter = .[["player"]],
  opponent = .[["player"]]
))

config <- new(Simulation,
  info = info,
  conditions = conditions,
  word_lists = wordlists
)

## ---- Save config tu temporary .pb file and Run hangman
files <- tempfile(pattern = c("config", "result"), fileext = ".pb")
serialize(config, files[1])
system2("HangmanCLI", c("simulation", "run", "-p", files[2], files[1]))
results <- Results$read(files[2])

# Extract relevant condition variables
df_cond <- map_dfr(results$config$conditions, condition_as_list) %>>%
# Add condition id and start letter origin
tibble::add_column(
  condition = seq_along(results$config$conditions) - 1,
  .before = 1
) %>>%
# Save some space by converting numerics to integers
modify_if(is_double, as.integer) %>>%
# Assign labels to factors
assign_labels(c("starter_strategy", "opponent_strategy"), strategies) %>>%
assign_labels(c("direction_restrictions_first", "direction_restrictions_other"), restrictions)

# Extract move data
df_res <- map_dfr(results$trials, trial_as_list, direction_levels = as.integer(directions), direction_labels = names(directions)) %>>%
modify_if(is.double, as.integer) %>>%
dplyr::select(-trial)

df <- dplyr::left_join(df_cond, df_res, by = "condition") %>>%
dplyr::mutate(
   duration = map_int(moves, nrow),
  turns = as.integer(ceiling(duration / 2)),
  winner = dplyr::recode_factor(duration %% 2, "1"="starter", "0"="opponent")
)

sim_dir_games <- df %>>%
dplyr::select(1:2, player_strategy = starter_strategy, 10, 13:15) %>>%
assign_info(results$config$info)

sim_dir_moves <- df %>>%
dplyr::select(condition, moves) %>>%
tidyr::unnest(moves) %>>%
dplyr::mutate(difficulty = map_int(hits, nrow)) %>>%
dplyr::select(-hits) %>>%
assign_info(results$config$info)

sim_dir_hits <- df %>>%
dplyr::select(condition, moves) %>>%
tidyr::unnest(moves) %>>%
dplyr::select(condition, move_id, hits) %>>%
tidyr::unnest(hits) %>>%
assign_info(results$config$info)

## ---- Save data to files
usethis::use_data(sim_dir_games, overwrite = T, compress = "xz")
usethis::use_data(sim_dir_moves, overwrite = T, compress = "xz")
usethis::use_data(sim_dir_hits, overwrite = T, compress = "xz")

## ---- Cleanup
unlink(files)
resetDescriptorPool()
