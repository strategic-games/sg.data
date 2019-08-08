#' Simulation comparing start letters generation methods
#'
#' This simulation contains 30,000 Begriffix games where 3 methods to generate start letter combinations are compared (10,000 games per method).
#' Except for start letters, the game configuration is kept constant and conforms to original Begriffix rules.
#' Players use the random strategy and their vocabulary contains the first 50,000 words in DEREWO_Wortformen.
#' @usage
#' # Move data
#' data(sim_sl_moves, package = "sg.data")
#' # Hits data
#' data(sim_sl_hits, package = "sg.data")
#' @source generated with [Hangman](https://github.com/strategic-games/hangman)
#' @aliases sim_sl sim_sl_hits
#' @family simulation data
"sim_sl_moves"
