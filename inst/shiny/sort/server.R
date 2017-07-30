library(shiny)
library(shinyjqui)
library(readr)

shinyServer(function(input, output) {
  output$text1 <- shiny::renderText({
    paste("Ich bin in Zelle 0a links oben:", input$'0a_dropped')
  })

  # script for draggable is in script, needs not shinyjqui action

#   jqui_droppable(
#     selector = ".droppable",
#     options = list(
#       tolerance = "intersect",
#       accept = ".draggable",
#       greedy = true,
#       over = htmlwidgets::JS(
#         # enable all .droppable elements
#         "$('.droppable').droppable('enable');"
#       )
#       drop = htmlwidgets::JS(
#       "function(event, ui){
#         ui.draggable.detach().appendTo($(this));
#         $(this).removeClass('droppable');
#         $(this).droppable('option', 'disabled', 'true')
#         }"
#         ),
#         out = htmlwidgets::JS(
#           "function(event, ui){
#             $(this).addClass('droppable');
#             $(this).droppable('option', 'disabled', 'false')
#             }"
#             )
#             out = htmlwidgets::JS(
#               "function(event, ui) {$(this).droppable('option', 'accept', '.item');}"
#               ),
#               shiny = list(
#                 dropped = list(
#                   drop = htmlwidgets::JS('function(event, ui) { return ui.draggable.attr("id");}'),
#                   dropout = htmlwidgets::JS('function(event, ui) { return "NA";}')
#                   )
#                   )
#                   )
#                   )
# })
