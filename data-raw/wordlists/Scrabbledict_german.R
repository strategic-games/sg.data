Scrabbledict_german <- readr::read_delim(
  file = system.file("data-raw", "wordlists", "Scrabbledict_german.txt", package="sg.data"),
  delim = " ",
  col_names = "word",
  col_types = "c"
)
usethis::use_data(Scrabbledict_german, overwrite = T, compress="xz")
