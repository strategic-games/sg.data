c(
  "begriffix_startbuchstaben.r",
  "derechar.r"
) %>%
system.file("data-raw", ., package = "sg.simulate") %>%
purrr::walk(source)

start_letters <- stringr::str_to_lower(
  purrr::pmap_chr(Begriffix_Startbuchstaben, paste0)
)
derechar_internal <- DERECHAR[-31,]
usethis::use_data(start_letters, derechar_internal, overwrite = T, internal = T)
