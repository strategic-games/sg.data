#' Creates a simulation config from data
#'
#' A convenience helper for creating simulations with multiple conditions.
#'
#' The params list can contain the following variables:
#' \describe{
#'   \item{start_letters <chr>}{A character vector of four-letter combinations. If omitted, the dataset Begriffix_Startbuchstaben from this package is used.}
#'   \item{trials <int>}{Indicates how many games should be played per condition.}
#'   \item{starter_wordlist_path <chr>}{The file which contains the serialized word list for the start player.}
#'   \item{starter_wordlist_(prefix|suffix|sample) <int>}{Indicates how many words should be taken from the starter's word list. If omitted, the complete list is used. You can supply exactly one of the three variants.}
#'   \item{opponent_wordlist_path <chr>}{The file which contains the serialized word list for the opponent player. If omitted, starter_wordlist_path is inherited.}
#'   \item{opponent_wordlist_(prefix|suffix|sample) <int>}{Indicates how many words should be taken from the opponent's word list. If omitted, starter_wordlist_... is used. You can supply exactly one of the three variants.}
#' }
#'
#' @param title A character scalar, a short title for the simulation.
#' @param supplement A character scalar, more optional explanations.
#' @param params A list of vectors. Each combination of these vectors becomes a simulation condition.
#' @return A RProtoBuf Message of type strategic_games.Simulation.
#' @importFrom purrr cross %||%
#' @importFrom RProtoBuf P
#' @export
create_simulation <- function(title, supplement = NULL, params) {
  if (is.null(params[["start_letters"]])) {
    params[["start_letters"]] <- start_letters
  }
  if (is.null(params[["trials"]])) {
    params[["trials"]] <- 1
  }
  new(P("strategic_games.Simulation"),
    info = new(P("strategic_games.Simulation.Info"),
      title = title,
      supplement = supplement
    ),
    conditions = lapply(cross(params), FUN = create_condition)
  )
}

create_condition <- function(x) {
  condition <- new(P("strategic_games.Simulation.Condition"),
    start_letters = x$start_letters,
    trials = x$trials,
    starter = new(P("strategic_games.Simulation.Condition.Player"),
      vocabulary = new(P("strategic_games.Vocabulary"),
        path = x$starter_wordlist_path,
        prefix = x$starter_wordlist_prefix,
        suffix = x$starter_wordlist_suffix,
        sample = x$starter_wordlist_sample
      )
    ),
    opponent = new(P("strategic_games.Simulation.Condition.Player"),
      vocabulary = new(P("strategic_games.Vocabulary"),
        path = x$opponent_wordlist_path %||% x$starter_wordlist_path,
        prefix = x$opponent_wordlist_prefix,
        suffix = x$opponent_wordlist_suffix,
        sample = x$opponent_wordlist_sample
      )
      )
    )
}
