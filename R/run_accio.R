#' @title Run boilerplate app
#'
#' @description Run boilerplate app
#'
#' @export
run_accio <- function() {
  shiny::runApp(appDir = system.file('shiny/accio', package = 'accio'))
}
