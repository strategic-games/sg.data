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
#' @source generated with [Hangman](https://github.com/strategic-games/hangman)
#' @family simulation data
"thesis_hits"
