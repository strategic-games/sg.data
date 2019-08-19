#' Simulation comparing direction restrictions and strategies
#'
#' This simulation contains 60,000 Begriffix games under 6 (3 first move direction restrictions x 2 common player strategies) conditions, 10,000 games per condition.
#' @usage
#' # Game data
#' data(sim_dir_games, package = "sg.data")
#' # Move data
#' data(sim_dir_moves, package = "sg.data")
#' # Hits data
#' data(sim_dir_hits, package = "sg.data")
#' @details
#' Except for direction restrictions, the game configuration is kept constant and conforms to original Begriffix rules.
#' Under each condition, the start letters are the first 10,000 entries in [`DEREWO_Startbuchstaben`].
#' In each game, both players have the same strategy in common (random or min_places) and their vocabulary contains the first 50,000 words in DEREWO_Wortformen.
#' @source generated with [Hangman](https://github.com/strategic-games/hangman)
#' @aliases sim_dir_moves sim_dir_hits
#' @family simulation data
"sim_dir_games"
