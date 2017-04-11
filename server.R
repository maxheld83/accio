library(shiny)

shinyServer(function(input, output) {
  output$text1 <- shiny::renderText({
    paste("Currently being dragged item:", input$dropzone_dragging)
  })
  output$text3 <- shiny::renderText({
    paste("Currently being dragged item:", input$item1_offset)
  })
  output$text2 <- shiny::renderText({
    paste("Currently being dragged item:", input$item2_position)
  })
  output$text4 <- shiny::renderText({
    paste("Item on dropzone:", input$dropzone_dropped)
  })
})
