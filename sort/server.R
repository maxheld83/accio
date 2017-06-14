library(shiny)
library(shinyjqui)
library(readr)

shinyServer(function(input, output) {
  output$text1 <- shiny::renderText({
    paste("Ich bin in Zelle 0a links oben:", input$'0a_dropped')
  })

  # INTERACTIONS for items and cells
  jqui_draggable(selector = ".draggable",
                 options = list(
                   snap = ".droppable",
                   snapMode = "inner",
                   snapTolerance = 20,
                   opacity = 0.7,
                   addClasses = TRUE,
                   scroll = TRUE,
                   cursor = "move",
                   stack =  ".item",
                   revert = "invalid",
                   appendTo = ".grid",
                   helper = "clone",
                   containment = ".grid",
                   start = htmlwidgets::JS("function(){$(this).hide();}")
                  )
                )
  jqui_droppable(selector = '.droppable',
                 options = list(
                   tolerance = "intersect",
                   accept = ".item",
                   classes = list(`ui-droppable-hover` = "hover"),
                   drop = "function(event, ui) {
    $(this).droppable('option', 'accept', ui.draggable);
},",
                   out = "function(event, ui) {
    $(this).droppable('option', 'accept', '.drag-item');
}",
                   shiny = list(
                     dropped = list(
                       drop = htmlwidgets::JS('function(event, ui) { return ui.draggable.attr("id");}'),
                       dropout = htmlwidgets::JS('function(event, ui) { return "NA";}')
                     )
                   )
                 )
  )
})
