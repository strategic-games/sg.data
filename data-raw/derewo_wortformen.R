DEREWO_Wortformen <- vroom::vroom(
  file = system.file("data-raw", "derewo-v-100000t-2009-04-30-0.1.txt", package="sg.data"),
  delim = " ",
  col_names = c("word", "rank"),
  col_types = "ci",
  comment = "#"
)
usethis::use_data(DEREWO_Wortformen, overwrite = T)
