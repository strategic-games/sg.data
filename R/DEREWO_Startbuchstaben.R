#' All german Begriffix start combinations with frequencies from DEREWO_Wortformen
#'
#' This data set contains all Begriffix start letter combinations based on 30 characters (26 lower-case letters, 3 german umlauts, and ß).
#' Each combination is augmented with the resulting horizontal and vertical letter pairs and the respective frequencies of these letter pairs found in DEREWO_letter_pairs.
#' The data can be used for weighted sampling of Begriffix start letters.
#'
#' @format A tibble with 810000 (30^4) rows and 16 variables:
#' \describe{
#'   \item{ul, ll, ur, lr}{The single letters; upper left, lower left, upper right, and lower right position.}
#'   \item{uh, lh, lv, rv}{The letter pairs: upper horizontal, lower horizontal, left vertical, and right vertical pair.}
#'   \item{n_uh, n_lh, n_lv, n_rv}{The absolute frequencies of the corresponding letter pairs found in DEREWO_letter_pairs.}
#'   \item{p_uh, p_lh, p_lv, p_rv}{The relative frequencies of the corresponding letter pairs found in DEREWO_letter_pairs.}
#' }
#' @family auxiliary data
"DEREWO_Startbuchstaben"
