DeReChar <- readr::read_tsv(
  file = system.file("data-raw", "wordlists", "DeReChar-v-uni-030-a-l-2018-02-28-1.0.csv", package="sg.data"),
  col_names = c("RF", "AF", "G", "N"),
  col_types = "ddcc",
  comment = "#"
)
usethis::use_data(DeReChar, overwrite = T)
