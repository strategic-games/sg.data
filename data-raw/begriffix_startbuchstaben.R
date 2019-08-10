library(pipeR)

Begriffix_Startbuchstaben <- system.file(
  "data-raw", "begriffix_startbuchstaben.txt", package = "sg.data"
) %>>%
vroom::vroom(delim = " ", col_types = "cccc") %>>%
purrr::modify(stringr::str_to_lower, locale = "de_DE")
usethis::use_data(Begriffix_Startbuchstaben, overwrite=T)
