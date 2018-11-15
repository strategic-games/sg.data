#' Returns initial Begriffix boards from start letters
#'
#' @param start_letters A character vector where each element contains four letters.
#' @return A list of 8*8 matrices with the input start letters inserted at the middle position.
#' @examples
#'   sl <- c("laer", "jaul")
#'.  initial_boards(sl)
#' @export
initial_boards <- function(start_letters) {
  board <- matrix("?", nrow = 8, ncol = 8)
  lapply(
    stringr::str_split(start_letters, ""),
    FUN = function(x) {
      l <- matrix(x, nrow = 2, byrow = T)
      board[4:5, 4:5] <- l
      return(board)
    }
  )
}
