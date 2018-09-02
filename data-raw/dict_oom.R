dict_oom <- jsonlite::fromJSON(
  file.path("data-raw", "dict_oom.json")
)
dict_oom <- tibble::as_tibble(dict_oom)
usethis::use_data(dict_oom, overwrite = T)
