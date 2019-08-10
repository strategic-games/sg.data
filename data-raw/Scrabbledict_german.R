Scrabbledict_german <- vroom::vroom(
  file = system.file("data-raw", "Scrabbledict_german.txt", package="sg.data"),
  delim = " ",
  col_names = "word",
  col_types = "c",
  na = character()
)
usethis::use_data(Scrabbledict_german, overwrite = T, compress="xz")
