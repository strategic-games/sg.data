## ---- Seed rng
seed <- 4726
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
  title = "Thesis-Simulation-sl",
  supplement = "Begriffix-Ergebnisse abhängig von der Erzeugungsmethode der Startbuchstaben",
  random_seed = seed
)

word_min_length <- new(
  Simulation$Condition$WordMinLength,
  first = 5, other = 4
)
direction_restrictions <- new(
  Simulation$Condition$DirectionRestrictions,
  first = "starter", other = "none"
)
player <- new(Simulation$Condition$Player,
  vocabulary = new(Vocabulary,
    key = wl_key, prefix = 50000
  ),
  begriffixStrategy = "random"
)

n <- 10000
sl_method_levels <- c("human", "char", "pair")
sl_method <- forcats::as_factor(rep(sl_method_levels, each = n))
conditions <- sl_method_levels %>>%
map(~generate_start_letters(type = .x, n = n)) %>>%
flatten_chr() %>>%
map(~new(Simulation$Condition,
  trials = 1,
  start_letters = .,
  board_size = 8,
  word_min_length = word_min_length,
  direction_restrictions = direction_restrictions,
  vocabulary = new(Vocabulary, key = wl_key),
  starter = player,
  opponent = player
))

config <- new(Simulation,
  info = info,
  conditions = conditions,
  word_lists = wordlists
)

## ---- Save config tu temporary .pb file and Run hangman
files <- tempfile(pattern = c("input", "output"), fileext = ".pb")
serialize(config, files[1])
system2("HangmanCLI", c("simulation", "run", "-p", files[2], files[1]))
results <- Results$read(files[2])

# Extract relevant condition variables
df_cond <- map_dfr(results$config$conditions, condition_as_list) %>>%
# Add condition id and start letter origin
tibble::add_column(
  condition = seq_along(results$config$conditions) - 1,
  start_letters_method = sl_method,
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

sim_sl_games <- df %>>%
dplyr::select(-4:-12, -moves) %>>%
assign_info(results$config$info)

sim_sl_moves <- df %>>%
dplyr::select(condition, moves) %>>%
tidyr::unnest(moves) %>>%
dplyr::mutate(complexity = map_int(hits, nrow)) %>>%
dplyr::select(-hits) %>>%
assign_info(results$config$info)

sim_sl_hits <- df %>>%
dplyr::select(condition, moves) %>>%
tidyr::unnest(moves) %>>%
dplyr::select(condition, move_id, hits) %>>%
tidyr::unnest(hits) %>>%
assign_info(results$config$info)

## ---- Save data to files
usethis::use_data(sim_sl_games, compress = "xz", overwrite = T)
usethis::use_data(sim_sl_moves, compress = "xz", overwrite = T)
usethis::use_data(sim_sl_hits, compress = "xz", overwrite = T)

## ---- Cleanup
unlink(files)
resetDescriptorPool()
