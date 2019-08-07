#' Generate Begriffix start letter combinations
#'
#' Get Begriffix start letter combinations ready for passing to a simulation configuration.
#'
#' The type parameter can take the following different values:
#' \describe{
#'   \item{random}{
#'     Take a sample of size 4 from the 30 characters used to build
#'     german words (letters, ä, ö, ü, and ß),
#'     weighted by relative frequencies given in [`DERECHAR`],
#'     and pastes them together as string.
#'   }
#'   \item{pair}{
#'     Take the first n entries from [`DEREWO_Startbuchstaben`].
#'   }
#'   \item{human}{
#'     Take n random entries from [`Begriffix_Startbuchstaben`].
#'   }
#' }
#' @param type The source type of the generated start letters (char, pair, or human).
#' @param n The number of generated combinations.
#' @return A character vector where each entry consists of four letters.
#' @examples
#' generate_start_letters(type = "human", n = 5)
#' @export
generate_start_letters <- function(type = "char", n = 1) {
  switch(type,
    "human" = sample(start_letters, size = n, replace = T),
    "char" = {
      s <- replicate(n, {
        sample(derechar_internal[["G"]], size = 4, prob = derechar_internal[["RF"]])
      })
      paste0(s[1,], s[2,], s[3,], s[4,])
    },
    "pair" = {
      slice <- DEREWO_Startbuchstaben[seq_len(n), ]
      paste0(slice[["uh"]], slice[["lh"]])
    }
  )
}
