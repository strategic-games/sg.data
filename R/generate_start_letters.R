#' Generate a Begriffix start letter combination
#'
#' Get a Begriffix start letter combination ready for passing to a simulation configuration.
#'
#' The type parameter can take two different values:
#' \describe{
#'   \item{random}{
#'     Take a sample of size 4 from the 30 characters used to build
#'     german words (letters, ä, ö, ü, and ß),
#'     weighted by relative frequencies given in [`DeReChar`],
#'     and pastes them together as string.
#'   }
#'   \item{human}{
#'     Take a random entry from [`start_letters`].
#'   }
#' }
#' @param type The source type of the generated start letters (random or human).
#' @return A string containing four characters.
#' @export
generate_start_letters <- function(type = "random") {
  switch(type,
    "human" = sample(start_letters, size = 1),
    "random" = {
  g <- DeReChar$G[-31]
  rf <- DeReChar$RF[-31]
  paste0(sample(g, size = 4, prob = rf), collapse = "")
    }
  )
}
