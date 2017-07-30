#' @title Run boilerplate app
#'
#' @description Run boilerplate app
#'
#' @export
run_boilerplate <- function() {
  shiny::runApp(appDir = system.file('shiny/boilerplate', package = 'accio'))
}
