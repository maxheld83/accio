library(shiny)

shinyServer(function(input, output) {
  output$text1 <- shiny::renderText({
    paste("your input was", input$some_choice)
  })
})
