library(shiny)

shinyServer(function(input, output) {
  output$text1 <- shiny::renderText({
    paste("Currently being dragged item:", input$dropzone_dragging)
  })
})
