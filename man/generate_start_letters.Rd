% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/generate_start_letters.R
\name{generate_start_letters}
\alias{generate_start_letters}
\title{Generate Begriffix start letter combinations}
\usage{
generate_start_letters(type = "char", n = 1)
}
\arguments{
\item{type}{The source type of the generated start letters (char, pair, or human).}

\item{n}{The number of generated combinations.}
}
\value{
A character vector where each entry consists of four letters.
}
\description{
Get Begriffix start letter combinations ready for passing to a simulation configuration.
}
\details{
The type parameter can take the following different values:
\describe{
\item{random}{
Take a sample of size 4 from the 30 characters used to build
german words (letters, ä, ö, ü, and ß),
weighted by relative frequencies given in \code{\link{DERECHAR}},
and pastes them together as string.
}
\item{pair}{
Take the first n entries from \code{\link{DEREWO_Startbuchstaben}}.
}
\item{human}{
Take n random entries from \code{\link{Begriffix_Startbuchstaben}}.
}
}
}
\examples{
generate_start_letters(type = "human", n = 5)
}
