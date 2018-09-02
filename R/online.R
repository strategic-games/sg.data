#' Online-Fragebogen
#'
#' Online und an Testungsterminen abgefragte Personendaten, Konstrukte und aggregierte Spiele-Scores.
#'
#' @usage data(online)
#'
#' @format Data frame mit 91 Zeilen (Teilnehmer) und 76 Variablen:
#' \describe{
#'   \item{Testung <date>}{TestungsTermin. Die Teilnehmer wurden in 5 Gruppen zu 16—21 Personen aufgeteilt und jede Gruppe führte die Testung an einem eigenen Termin von 09:00—12:00 durch.}
#'   \item{ofb <lgl>}{Onlineteil bearbeitet. Drei Teilnehmer haben ihren Online-Fragebogen nicht bearbeitet.}
#'   \item{p1:p4 <dbl>}{Puls. Im Laufe der Testung wurde mehrmals der Puls abgefragt (gezählte Schläge in 10s).}
#'   \item{axy <int>}{Akzeptanz (x=Spiel, y=Fragennummer), sechsstufige Likertskala}
#' \item{Geschlecht <chr>}{Geschlecht (m oder w)}
#' \item{Hand <chr>}{Händigkeit (links oder rechts)}
#' \item{SA_Leistung <int>}{Selbsteinschätzung der Leistungsfähigkeit (fünfstufige Likertskala).}
#'   \item{get_... <dbl>}{Gkkt (2—9=verbal, 10—11=numerisch, 12—13=figural)}
#'   \item{BIP_LM <dbl>}{Leistungsmotivation}
#'   \item{BFI}{Big 5 <dbl>}
#'   \item{CM <dbl>}{Competition Motivation}
#'   \item{TAI <dbl>}{Testängstlichkeit}
#'   \item{addifix <dbl>}{Numerisches Spiel (Mittlerer Score)}
#'   \item{addifix <dbl>}{Numerisches Spiel (Mittlerer Score)}
#'   \item{snetris <dbl>}{Figurales Spiel (Mittlerer Score)}
#'   \item{begriffix <dbl>}{Verbales Spiel (Mittlerer Score)}
#' }
#' @references{
#'   \insertRef{Rammstedt:2005aa}{sg.data}
#'   \insertRef{Hossiep:2003aa}{sg.data}
#'   \insertRef{Wacker:2008aa}{sg.data}
#'   \insertRef{Franken:1995aa}{sg.data}
#'   \insertRef{Kersting:2008aa}{sg.data}
#'   \insertRef{Moosbrugger:2011aa}{sg.data}
#'   \insertRef{Ulfert:2017aa}{sg.data}
#' }
#' @importFrom Rdpack reprompt
#' @family empirical data
"online"
