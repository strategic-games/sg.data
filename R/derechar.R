#' @title German character frequencies
#' @description This dataset contains the corpus-based list of german character frequencies (DERECHAR) reported by the Institut für deutsche Sprache in Mannheim. Each row represents one character.
#' @usage data(DERECHAR)
#' @format A data frame with 31 rows and 4 variables:
#' \describe{
#'   \item{\code{RF}}{double relative frequency of the respective character in the corpus}
#'   \item{\code{AF}}{double absolute frequency of the respective character in the corpus}
#'   \item{\code{G}}{character glyph of the respective character}
#'   \item{\code{N}}{character name of the respective character} 
#'}
#' @source <http://www1.ids-mannheim.de/fileadmin/kl/derewo/DeReChar-v-uni-030-a-l-2018-02-28-1.0.csv>
#' @references
#' Korpusbasierte Zeichenhäufigkeitslisten
#' DERECHAR v-uni-XXX-2018-02-28-1.0,
#' Institut für Deutsche Sprache, Mannheim,
#' Februar 2018
#' @family auxiliary data
"DERECHAR"
