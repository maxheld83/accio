library(shiny)
library(shinyjqui)
library(readr)

shinyServer(function(input, output) {
  output$text1 <- shiny::renderText({
    paste("Ich bin in Zelle 0a links oben:", input$'0a_dropped')
  })

  # INTERACTIONS for items and cells
  jqui_draggable(selector = '.hexagon-item',
                 options = list(
                   snap = ".hexagon",
                   snapMode = "inner",
                   snapTolerance = 20,
                   opacity = 0.7,
                   scroll = TRUE,
                   cursorAt = list(left = 120)
                   )
                )
  jqui_droppable(selector = '.hexagon',
                 options = list(
                   tolerance = "pointer",
                   classes = list(`ui-droppable-hover` = "hover"),
                   shiny = list(
                     dropped = list(
                       drop = htmlwidgets::JS('function(event, ui) { return ui.draggable.attr("id");}'),
                       dropout = htmlwidgets::JS('function(event, ui) { return "NA";}')
                     )
                   )
                 )
  )
})
