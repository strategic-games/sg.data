Begriffix_Startbuchstaben <- readr::read_delim(
  file = system.file("data-raw", "begriffix_startbuchstaben.txt", package = "sg.data"),
  delim = " ",
  col_types = "cccc",
  col_names = c("44", "45", "54", "55")
)
usethis::use_data(Begriffix_Startbuchstaben, overwrite=T)
start_letters <- stringr::str_to_lower(
  purrr::pmap_chr(Begriffix_Startbuchstaben, paste0)
)
usethis::use_data(start_letters, internal = T, overwrite = T)
