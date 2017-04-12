library(shiny)
library(shinyjqui)
library(readr)

shinyServer(function(input, output) {
  output$text1 <- shiny::renderText({
    paste("Item on dropzone:", input$dropzone_dropped)
  })

  # INTERACTIONS for items and cells
  jqui_draggable(selector = '.item')
  jqui_droppable(selector = '.cell',
                 options = list(
                   shiny = list(
                     dropped = list(
                       drop = htmlwidgets::JS('function(event, ui) { return ui.draggable.attr("id");}')
                     )
                   )
                 ))
})
