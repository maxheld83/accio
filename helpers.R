#' @title Convert markdown to html
#'
#' @param text A character vector to be converted to markdown.
#'
#' @param HTML A logical flag, indicating whether the result should additionally be wrapped in shiny::HTML().
#'
#' @noRd
md <- function(text, HTML = TRUE) {
  res <- markdown::renderMarkdown(
    file = NULL,
    output = NULL,
    text = text
  )
  if (HTML) {
    res <- shiny::HTML(text = res)
  }
  return(res)
}
