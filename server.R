library(shiny)
library(shinyjqui)
library(readr)

shinyServer(function(input, output) {
  output$text1 <- shiny::renderText({
    paste("Item on dropzone:", input$dropzone_dropped)
  })
  output$text1 <- shiny::renderText({
    paste("Ich bin in Zelle 0a links oben:", input$'0a_dropped')
  })

  # INTERACTIONS for items and cells
  jqui_draggable(selector = '.hexagon-item')
  jqui_droppable(selector = '.hexagon',
                 options = list(
                   shiny = list(
                     dropped = list(
                       drop = htmlwidgets::JS('function(event, ui) { return ui.draggable.attr("id");}')
                     )
                   )
                 ))
})
