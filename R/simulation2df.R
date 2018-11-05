#' Transform a simulation to a data frame
#'
#' Takes a list structure according to a SimulationResults message and transforms it to a tibble with nested tibbles if appropriate.
#'
#' @param x A list or message of type SimulationResults.
#' @return A tibble
#' @importFrom rlang .data
#' @export
simulation2df <- function(x) {
  if (class(x) == "Message") {
    tmp <- extract_message(x)
    simulation2df(tmp)
  }
  conditions <- x$config$conditions %>%
  purrr::transpose() %>%
  purrr::modify_at(
    c("starter", "opponent", "vocabulary"),
    ~lapply(., FUN = purrr::flatten_dfc)
  ) %>%
  tibble::as_tibble() %>%
  tidyr::unnest(.sep = "_") %>%
  purrr::modify_at("start_letters", factor) %>%
  purrr::modify_if(is.double, as.integer)

  df <- x$trials %>%
  purrr::transpose() %>%
  purrr::modify_at(
    c("condition", "trial"), ~purrr::map_int(., ~as.integer(. + 1))
  ) %>%
  purrr::modify_at("condition", ~purrr::map(., ~conditions[., ])) %>%
  purrr::modify_at("moves", ~lapply(., FUN = moves2df)) %>%
  tibble::as_tibble() %>%
  tidyr::unnest(.data$condition)
  info <- x$config$info
  structure(df,
    title = info$title,
    supplement = info$supplement,
    date = format(info$date, usetz = T)
  )
}

moves2df <- function(x) {
  if (is.atomic(x)) return(x)
  tmp <- lapply(x, FUN = function(m) {
    c(m[["place"]], m[c("word", "hits")])
  })
  tmp <- purrr::transpose(tmp)
  tmp <- purrr::modify_at(
    tmp, c("row", "column", "direction", "word"), purrr::simplify
  )
  tmp <- purrr::modify_at(tmp, c("row", "column"), ~as.integer(. + 1))
  tmp <- purrr::modify_at(
    tmp, "direction",
    factor, levels = 0:1, labels = c("horizontal", "vertical")
  )
  tmp$hits <- lapply(tmp$hits, FUN = hits2df)
  tibble::as_tibble(tmp)
}

hits2df <- function(x) {
  tmp <- lapply(x, FUN = function(h) {
    c(h[["place"]], h["words"])
  })
  tmp <- purrr::transpose(tmp)
  tmp <- purrr::modify_at(
    tmp, c("row", "column", "direction"), purrr::simplify
  )
  tmp <- purrr::modify_at(tmp, c("row", "column"), ~as.integer(. + 1))
  tmp <- purrr::modify_at(
    tmp, "direction",
    factor, levels = 0:1, labels = c("horizontal", "vertical")
  )
  tibble::as_tibble(tmp)
}
