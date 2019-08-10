library(pipeR)

online <- system.file(
  "data-raw",
  "complete_wide_format.sav",
  package = "sg.data"
) %>>%
haven::read_spss() %>>%
dplyr::mutate_at("Testung", dplyr::recode, !!! as.list(
  lubridate::dmy("11.12.2017", "12.12.2017", "14.12.2017", "18.12.2017", "19.12.2017")
)) %>>%
dplyr::mutate_at("ofb", as.logical) %>%
dplyr::mutate_at(dplyr::vars(a11:a35), as.integer) %>%
dplyr::mutate_at("Geschlecht", dplyr::recode, "m\U00E4nnlich", "weiblich") %>%
dplyr::mutate_at("Hand", dplyr::recode, "links", "rechts") %>%
dplyr::mutate_at("SA_Leistung", ~as.integer(.-2))

usethis::use_data(online, overwrite = T)
