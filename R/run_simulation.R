#' Run a simulation config
#'
#' This serializes the config into a .pb file, runs hangman with that file,
#' and reads the results produced by hangman.
#'
#' @param x A RProtoBuf Message of type strategic_games.Simulation.
#' @param path The directory path where the generated .pb files are written to.
#' @param clean If true, the generated files are deleted after processing.
#' @param command The path to the hangman executable which must be installed on the local system. If omitted, ~/bin/hangman is tried.
#' @return The simulation results as list tree structure.
#' @importFrom RProtoBuf read
#' @export
run_simulation <- function(x, path = NULL, clean = T, command = NULL) {
  if (is.null(path)) path <- tempdir()
  if (is.null(command)) {
    command <- normalizePath(file.path("~", "bin", "hangman"))
  }
  stopifnot(file.exists(command))
  files <- tempfile(
    c("simulation_config", "simulation_results"),
    tmpdir = path,
    fileext = ".pb"
  )
  x$serialize(files[1])
  processx::run(command, c("simulation", "run", "-p", files[2], files[1]))
  simulation <- read(P("strategic_games.SimulationResults"), files[2])
  if (clean == T) unlink(files)
  return(simulation)
}
