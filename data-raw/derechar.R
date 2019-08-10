DERECHAR <- vroom::vroom(
  file = system.file("data-raw", "DeReChar-v-uni-030-a-l-2018-02-28-1.0.csv", package="sg.data"),
  delim = "\t",
  col_names = c("RF", "AF", "G", "N"),
  col_types = "ddcc",
  n_max = 31
)
usethis::use_data(DERECHAR, overwrite = T)
