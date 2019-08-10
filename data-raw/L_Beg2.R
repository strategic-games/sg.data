begriffix <- vroom::vroom(
  system.file("data-raw", "L_Beg2.txt", package = "sg.data"),
  delim = " ",
  col_names = c("y", "id", "id2", "j", "sp"),
  col_types = "iccii"
)
usethis::use_data(begriffix, overwrite = T)
