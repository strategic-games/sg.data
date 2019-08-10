library("pipeR")
library(purrr)
library(stringr)
data(DEREWO_Wortformen, package = "sg.data")

DEREWO_letter_pairs <- DEREWO_Wortformen$word %>>%
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

usethis::use_data(DEREWO_letter_pairs)
