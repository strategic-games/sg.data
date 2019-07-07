#' @title A german corpus-based ranked word list
#' @description A dataset containing „Wortformenliste Derewo“. Please see source and reference for more informations.
#' @usage data(DEREWO_Wortformen)
#' @format A data frame with 100000 rows and 2 variables:
#' \describe{
#'   \item{\code{word}}{character german word}
#'   \item{\code{rank}}{integer rank in the corpus. Words with lowest rank have been found most frequently.} 
#'}
#' @details The dataset is ordered by descending word frequency, starting with the words of highest frequency.
#' @source <http://www1.ids-mannheim.de/kl/projekte/methoden/derewo.html>
#' @references
#' Korpusbasierte Wortformenliste DEREWO, v-100000t-2009-04-30-0.1, 
#' mit Benutzerdokumentation,
#' <http://www.ids-mannheim.de/kl/derewo/>,
#' © Institut für Deutsche Sprache, Programmbereich Korpuslinguistik,
#' Mannheim,  Deutschland, 2009.
#' @family word lists
"DEREWO_Wortformen"
