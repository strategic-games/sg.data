library(dplyr)

online <- "complete_wide_format.sav" %>%
file.path("data-raw", .) %>%
haven::read_spss() %>%
mutate_at("Testung", recode, !!! as.list(
  lubridate::dmy("11.12.2017", "12.12.2017", "14.12.2017", "18.12.2017", "19.12.2017")
)) %>%
mutate_at("ofb", as.logical) %>%
mutate_at(vars(a11:a35), as.integer) %>%
mutate_at("Geschlecht", recode, "m\U00E4nnlich", "weiblich") %>%
mutate_at("Hand", recode, "links", "rechts") %>%
mutate_at("SA_Leistung", funs(as.integer(.-2)))
usethis::use_data(online, overwrite = T)
