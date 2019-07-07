# Load packages
library("pipeR")
library(purrr)
library("RProtoBuf")

# Load auxiliary data
data(DEREWO_Wortformen)

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

# Get names and values of relevant enums
strategies <- as.list(Simulation$Condition$Player$BegriffixStrategy)
restrictions <- as.list(Simulation$Condition$DirectionRestrictions$Mode)
directions <- as.list(Results$Place$Direction)

# Seed rng
seed <- 3825
set.seed(seed)

# Build the simulation config
info <- new(Simulation$Info,
  title = "Thesis-Simulation",
  supplement = "multifaktorielles Variablendesign"
)

vocabulary_size <- -2:2 * 15000L + 50000L
player_strategies <- c("random", "min_places", "availability")
grid <- list(
  start_letters_origin = c("random", "human"),
  board_size = c(8L, 10L),
  word_min_length = list(
    list(first = 5L, other = 4L),
    list(first = 4L, other = 3L)
  ),
  direction_restrictions = list(
    list(first = "starter", other = "none"),
    list(first = "fixed", other = "none")
  ),
  starter_prefix = vocabulary_size,
  starter_strategy = player_strategies,
  opponent_prefix = vocabulary_size,
  opponent_strategy = player_strategies
) %>>%
cross()

wl_key <- "derewo"
wordlists <- new(WordLists,
  entries = list(
    new(WordLists$Entry,
      key = wl_key, value = DEREWO_Wortformen$word
    )
  )
)

conditions <- map(grid, ~new(Simulation$Condition,
  trials = 10,
  start_letters = generate_start_letters(.[["start_letters_origin"]]),
  board_size = .[["board_size"]],
  word_min_length = do.call(
    Simulation$Condition$WordMinLength$new,
    .[["word_min_length"]]
  ),
  direction_restrictions = do.call(
    Simulation$Condition$DirectionRestrictions$new,
    .[["direction_restrictions"]]
  ),
  starter = new(Simulation$Condition$Player,
    vocabulary = new(Vocabulary,
      key = wl_key, prefix = .[["starter_prefix"]]
    ),
    begriffixStrategy = .[["starter_strategy"]]
  ),
  opponent = new(Simulation$Condition$Player,
    vocabulary = new(Vocabulary,
      key = wl_key, prefix = .[["opponent_prefix"]]
    ),
    begriffixStrategy = .[["opponent_strategy"]]
  ),
  vocabulary = new(Vocabulary, key = wl_key)
))

config <- new(Simulation,
  info = info,
  conditions = conditions,
  word_lists = wordlists
)

# Save config tu temporary .pb file and Run hangman with the created file
files <- tempfile(pattern = c("input", "output"), fileext = ".pb")
serialize(config, files[1])
system2("HangmanCLI", c("simulation", "run", "-p", files[2], files[1]))
results <- Results$read(files[2])

# Extract relevant condition variables
df_cond <- map_dfr(results$config$conditions, condition_as_list) %>>%
# Add condition id and start letter origin
tibble::add_column(
  condition = seq_along(results$config$conditions) - 1,
  start_letters_origin = map_chr(grid, "start_letters_origin"),
  .before = 1
) %>>%
# Save some space by converting numerics to integers
modify_if(is_double, as.integer) %>>%
# Assign labels to factors
assign_labels(c("starter_strategy", "opponent_strategy"), strategies) %>>%
assign_labels(c("direction_restrictions_first", "direction_restrictions_other"), restrictions)

# Extract move data
df_res <- map_dfr(results$trials, trial_as_list)

# Join results into conditions
df <- dplyr::nest_join(df_cond, df_res, by = "condition", name = "trials") %>>%
# reshape dataset
tidyr::unnest(trials) %>>%
tidyr::unnest(moves) %>>%
modify_if(is_double, as.integer) %>>%
modify_at("move", as.integer) %>>%
assign_labels("direction", directions)

thesis_moves <- df %>>%
dplyr::select(condition, trial, dplyr::everything(), -hits)
thesis_hits <- df %>>%
dplyr::select(condition, trial, move, hits) %>>%
tidyr::unnest(hits) %>>%
modify_if(is_double, as.integer) %>>%
assign_labels("direction", directions)

thesis_info <- list(
  title = results$config$info$title,
  supplement = results$config$info$supplement,
  version = as.list(results$config$info$version),
  date = as.POSIXct(results$config$info$date$seconds, origin = "1970-01-01", tz = "gmt"),
  random_seed = results$config$info$random_seed
)

# Save data to files
usethis::use_data(
  thesis_info, thesis_moves, thesis_hits, compress = "xz", overwrite = T
)

# Cleanup
unlink(files)
resetDescriptorPool()
