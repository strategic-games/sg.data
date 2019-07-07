Scrabbledict_german <- readr::read_delim(
  file = system.file("data-raw", "Scrabbledict_german.txt", package="sg.simulate"),
  delim = " ",
  col_names = "word",
  col_types = "c"
)
usethis::use_data(Scrabbledict_german, overwrite = T, compress="xz")
