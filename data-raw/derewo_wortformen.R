Derewo_Wortformen <- readr::read_delim(
  file = file.path("data-raw", "derewo-v-100000t-2009-04-30-0.1"),
  delim = " ",
  col_names = c("word", "rank"),
  col_types = "ci",
  comment = "#"
)
usethis::use_data(Derewo_Wortformen, overwrite = T)
