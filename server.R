library(shiny)
library(shinyjqui)

shinyServer(function(input, output) {
  output$text1 <- shiny::renderText({
    paste("Item on dropzone:", input$dropzone_dropped)
  })
})
