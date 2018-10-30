#' Creates a simulation config from data
#'
#' @param title A character scalar, a short title for the simulation.
#' @param supplement A character scalar, more optional explanations.
#' @param params A list of vectors.
#' @return A RProtoBuf Message of type strategic_games.Simulation.
#' @importFrom purrr cross map map_chr
#' @import RProtoBuf
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
    conditions = map(cross(params), create_condition)
  )
}

create_condition <- function(x) {
  condition <- new(P("strategic_games.Simulation.Condition"),
    start_letters = params$start_letters,
    trials = params$trials,
    starter = new(P("strategic_games.Simulation.Condition.Player"),
      vocabulary = new(P("strategic_games.Vocabulary"),
        path = params$starter_wordlist_path
      )
      )
    )
}
