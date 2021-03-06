#' Move data of 36000 simulated Begriffix games
#'
#' This dataset contains the moves of 36.000 simulated Begriffix games
#' in long format, where each row represents a single move.
#' @usage data(thesis_moves, package="sg.data")
#' @format A tibble with 262267 rows and 19 variables:
#' \describe{
#'   \item{start_letters}{The game's start letters. The letters in one string value are inserted rowwise in the game board.}
#'   \item{start_letters_origin}{The start letters generation method (human or random).}
#'   \item{board_size}{The sidelength of the game board (8 or 10).}
#'   \item{starter_size}{The number of words in the start player's vocabulary.}
#'   \item{starter_select}{The construction mode of the start player's vocabulary (prefix, suffix, or random; always prefix in this dataset).}
#'   \item{starter_begriffixStrategy}{The start player's Begriffix strategy.}
#'   \item{opponent_size}{The number of words in the opponent player's vocabulary.}
#'   \item{opponent_select}{The construction mode of the opponent player's vocabulary (prefix, suffix, or random; always prefix in this dataset).}
#'   \item{opponent_begriffixStrategy}{The opponent player's Begriffix strategy.}
#'   \item{word_min_length_first}{The minimum word length in the game's first move prescribed by game configuration.}
#'   \item{word_min_length_other}{The minimum word length after the game's first move prescribed by game configuration.}
#'   \item{direction_restrictions_first}{Direction restrictions in the game's first move prescribed by game configuration.}
#'   \item{direction_restrictions_other}{Direction restrictions after the game's first move prescribed by game configuration.}
#'   \item{game}{A game ID}
#'   \item{move}{A move ID}
#'   \item{row}{The place row of the move.}
#'   \item{column}{The place column of the move.}
#'   \item{direction}{The place direction of the move.}
#'   \item{word}{The word chosen for the move.}
#' }
#'
#' @section Word Lists:
#' Every vocabulary used in the simulated games is based on
#' the DeRewo Wortformenliste in [DEREWO_Wortformen].
#' Path variables are omitted from the dataset, because they never change.
#' The reference vocabulary is always the complete word list.
#' @source generated with [Hangman](https://github.com/strategic-games/hangman)
#' @family simulation data
#' Move hits data of 36000 simulated Begriffix games
#'
#' This dataset contains the hits corresponding to the moves of the 36000
#' simulated Begriffix games in [thesis_moves] in long format, where each
#' row represents a possible place for a certain move.
#' It is stored separately for quicker loading of the move data
#' which my thesis is mainly based on.
#' @usage data(thesis_hits, package="sg.data")
#' @format A tibble with 6661976 observations and 6 variables:
#' \describe{
#'   \item{game}{A game ID}
#'   \item{move}{A move ID}
#'   \item{row}{The place row.}
#'   \item{column}{The place column.}
#'   \item{direction}{The place direction.}
#'   \item{words}{The words that could be used with the place.}
#' }
#'
#' @section Word Lists:
#' Every vocabulary used in the simulated games is based on
#' the DeRewo Wortformenliste in [DEREWO_Wortformen].
#' Path variables are omitted from the dataset, because they never change.
#'
#' @docType package
#' @name sg.data
NULL
