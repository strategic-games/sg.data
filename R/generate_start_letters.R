#' Generate a Begriffix start letter combination
#'
#' Get a Begriffix start letter combination ready for passing to a simulation configuration.
#'
#' The type parameter can take two different values:
#' \describe{
#'   \item{random}{
#'     Take a sample of size 4 from the 30 characters used to build
#'     german words (letters, ä, ö, ü, and ß),
#'     weighted by relative frequencies given in [`DERECHAR`],
#'     and pastes them together as string.
#'   }
#'   \item{human}{
#'     Take a random entry from [`Begriffix_Startbuchstaben`].
#'   }
#' }
#' @param type The source type of the generated start letters (random or human).
#' @return A string containing four characters.
#' @examples
#' generate_start_letters(type = "human")
#' @export
generate_start_letters <- function(type = "random") {
  switch(type,
    "human" = sample(start_letters, size = 1),
    "random" = {
  g <- derechar_internal$G
  rf <- derechar_internal$RF
  paste0(sample(g, size = 4, prob = rf), collapse = "")
    }
  )
}
