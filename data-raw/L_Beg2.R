begriffix <- readr::read_delim(
  file.path("data-raw", "L_Beg2.txt"),
  delim = " ",
  col_names = c("y", "id", "id2", "j", "sp"),
  col_types = "iccii"
)
usethis::use_data(begriffix, overwrite = T)
