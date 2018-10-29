#' Serializes a word list to a file
#'
#' @param words A character vector.
#' @param source A character scalar indicating the origin of the word list.
#' @param path The file path where to store the serialized data.
#' @return The path that was used (a temp file if omitted).
#' @examples
#' library(sg.data)
#' words <- c("abc", "def", "xyz")
#' source <- "an example list"
#' path <- serialize_wordlist(words, source)
#' path
#' @export
serialize_wordlist <- function(words = NULL, source = NULL, path = NULL) {
  if (is.null(words)) words <- sg.data::Derewo_Wortformen$word
  if (is.null(source)) source <- "Derewo Wortformen"
  if (is.null(path)) path <- tempfile(pattern = "wortlist", fileext = ".pb")
  word_list <- new(P("strategic_games.WordList"),
    source = source,
    words = words
  )
  word_list$serialize(path)
  path
}
