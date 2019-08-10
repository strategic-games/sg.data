library(pipeR)
data(DEREWO_letter_pairs, package = "sg.data")

DEREWO_letter_pairs_prop <- prop.table(DEREWO_letter_pairs)
letters_german <- c(letters, "ä", "ö", "ü", "ß")
DEREWO_Startbuchstaben <- list(
  ul = letters_german,
  ur = letters_german,
  ll = letters_german,
  lr = letters_german
) %>>%
expand.grid(stringsAsFactors = F) %>>%
tibble::as_tibble() %>>%
dplyr::mutate(
  uh = paste0(ul, ur),
  lh = paste0(ll, lr),
  lv = paste0(ul, ll),
  rv = paste0(ur, lr),
  n_uh = DEREWO_letter_pairs[uh],
  n_lh = DEREWO_letter_pairs[lh],
  n_lv = DEREWO_letter_pairs[lv],
  n_rv = DEREWO_letter_pairs[rv],
  p_uh = DEREWO_letter_pairs_prop[uh],
  p_lh = DEREWO_letter_pairs_prop[lh],
  p_lv = DEREWO_letter_pairs_prop[lv],
  p_rv = DEREWO_letter_pairs_prop[rv]
) %>>%
dplyr::mutate_at(9:12, as.integer) %>>%
dplyr::mutate_at(13:16, as.numeric) %>>%
dplyr::mutate_at(9:16, tidyr::replace_na, 0) %>>%
dplyr::mutate(score_min = pmin(p_uh, p_lh, p_lv, p_rv)) %>>%
dplyr::arrange(dplyr::desc(score_min))

usethis::use_data(DEREWO_Startbuchstaben, overwrite = T)
