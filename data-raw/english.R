english <- readr::read_delim(
  file = system.file("data-raw", "english.txt", package="sg.simulate"),
  delim = " ",
  col_names = "word",
  col_types = "c"
)
usethis::use_data(english, overwrite = T, compress="xz")
