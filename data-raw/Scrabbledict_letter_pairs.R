library("pipeR")
library(purrr)
library(stringr)
data(Scrabbledict_german, package = "sg.data")

Scrabbledict_letter_pairs <- Scrabbledict_german$word %>>%
map(function(x) {
  n <- str_length(x) - 1
  if (n < 1) return(NA)
  if (n == 1) return(str_to_lower(x))
  start <- 1:n
  end <- start + 1
  str_sub(str_to_lower(x), start, end)
}) %>>%
flatten_chr() %>>%
table()

usethis::use_data(Scrabbledict_letter_pairs, overwrite = T)
