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
                   start = htmlwidgets::JS("function(){$(this).hide();}"),
                   stop = htmlwidgets::JS("function(){$(this).show();}")
                  )
                )
  # jqui_droppable(selector = ".droppable",
  #                options = list(
  #                  tolerance = "intersect",
  #                  accept = ".draggable",p
  #                  drop = htmlwidgets::JS(
  #                    "function(event, ui){
  #                      ui.draggable.detach().appendTo($(this));
  #                      $(this).removeClass('droppable');
  #                      $(this).droppable('option', 'disabled', 'true')
  #                     }"
  #                  ),
  #                  out = htmlwidgets::JS(
  #                    "function(event, ui){
  #                      $(this).addClass('droppable');
  #                      $(this).droppable('option', 'disabled', 'false')
  #                    }"
  #                  )
                 #   out = htmlwidgets::JS(
                 #     "function(event, ui) {$(this).droppable('option', 'accept', '.item');}"
                 #   ),
                 #   shiny = list(
                 #     dropped = list(
                 #       drop = htmlwidgets::JS('function(event, ui) { return ui.draggable.attr("id");}'),
                 #       dropout = htmlwidgets::JS('function(event, ui) { return "NA";}')
                 #     )
                 #   )
                 # )
  # )
})
