library(pipeR)

system.file(
  "data-raw", 
  c(
    "begriffix_startbuchstaben.r",
    "derechar.r"
  ),
  package = "sg.data"
) %>>%
purrr::walk(source)
start_letters <- do.call("paste0", Begriffix_Startbuchstaben)
derechar_internal <- dplyr::filter(DERECHAR, RF > .001, !is.na(G))
usethis::use_data(
  start_letters, derechar_internal, overwrite = T, internal = T
)
