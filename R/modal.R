#' Statistical mode (central tendency measurement)
#'
#' This calculates the statistical mode of an at least nominal variable, the value with the highest frequency.
#' @param x An atomic vector.
#' @return A scalar value with the type of x.
#' @examples
#' # metric
#' modal(c(1, 1, 2, 2, 2, 3, 3)) # 2
#' # nominal
#' modal(c("a", "b", "b", "c")) # b
#' @export
modal <- function(x) {
  u <- unique(x)
  u[which.max(tabulate(match(x, u)))]
}
