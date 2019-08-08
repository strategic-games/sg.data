#' Return object with simulation infos as attributes
#'
#' @param df Object to augment, generally a simulation data frame.
#' @param info A ProtoBuf message of type `strategic_games.Simulation.Info`.
#' @return df with info attributes added.
assign_info <- function(df, info) {
  attr(df, "title") <- info$title
  attr(df, "description") <- info$supplement
  attr(df, "date_created") <- as.POSIXct(info$date$seconds, origin = "1970-01-01", tz = "gmt")
  attr(df, "hangman_version") <- as.list(info$version)
  attr(df, "random_seed") <- info$random_seed
  df
}
