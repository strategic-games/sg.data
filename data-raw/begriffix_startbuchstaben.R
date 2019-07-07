Begriffix_Startbuchstaben <- readr::read_delim(
  file = system.file("data-raw", "begriffix_startbuchstaben.txt", package = "sg.simulate"),
  delim = " ",
  col_types = "cccc",
  col_names = c("44", "45", "54", "55")
)
usethis::use_data(Begriffix_Startbuchstaben, overwrite=T)
