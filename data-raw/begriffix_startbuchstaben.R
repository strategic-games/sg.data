Begriffix_Startbuchstaben <- readr::read_delim(
  file = file.path("data-raw", "begriffix_startbuchstaben.txt"),
  delim = " ",
  col_types = "cccc",
  col_names = c("44", "45", "54", "55")
)
usethis::use_data(Begriffix_Startbuchstaben, overwrite=T)
